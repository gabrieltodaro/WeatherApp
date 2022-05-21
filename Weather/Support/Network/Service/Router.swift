//
//  Router.swift
//  Weather
//
//  Created by Gabriel Patane Todaro on 19/05/22.
//

import Foundation

class Router<Endpoint: EndpointType>: NetworkRouter {
    private var task: URLSessionTask?

    // MARK: - Network Router protocol
    func request(_ route: Endpoint,
                 completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            NetworkLogger.log(request: request)
            task = session.dataTask(with: request) { data, response, error in
                completion(data, response, error)
            }
        } catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }

    func cancel() {
        self.task?.cancel()
    }

    // MARK: - Router functions
    private func buildRequest(from route: Endpoint) throws -> URLRequest {
        // swiftlint:disable:next line_length
        guard let urlString = route.baseURL.appendingPathComponent(route.path).absoluteString.removingPercentEncoding,
              let url = URL(string: urlString) else {
                  fatalError("URL String should work.")
              }
        var urlRequest = URLRequest(url: url,
                                    cachePolicy: .useProtocolCachePolicy,
                                    timeoutInterval: 10.0)
        urlRequest.httpMethod = route.httpMethod.rawValue

        do {
            switch route.task {
            case .request:
                urlRequest.setValue(Constants.HTTPConstants.applicationJson,
                                    forHTTPHeaderField: Constants.HTTPConstants.contentType)

            case .requestParameters(let bodyParameters,
                                    let urlParameters):
                try self.configureParameter(bodyParameters: bodyParameters,
                                            urlParameters: urlParameters,
                                            request: &urlRequest)

            case .requestParamentersAndHeaders(let bodyParameters,
                                               let urlParameters,
                                               let additionalHeaders):
                self.addAdditionalHeaders(additionalHeaders,
                                          request: &urlRequest)
                try self.configureParameter(bodyParameters: bodyParameters,
                                            urlParameters: urlParameters,
                                            request: &urlRequest)
            }
            return urlRequest
        } catch {
            throw error
        }
    }

    private func configureParameter(bodyParameters: Parameters?,
                                    urlParameters: Parameters?,
                                    request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request,
                                                with: bodyParameters)
            }

            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request,
                                               with: urlParameters)
            }
        } catch {
            throw error
        }
    }

    private func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?,
                                      request: inout URLRequest) {
        guard let additionalHeaders = additionalHeaders else {
            return
        }
        for (headerKey, headerValue) in additionalHeaders {
            request.setValue(headerValue, forHTTPHeaderField: headerKey)
        }
    }
}
