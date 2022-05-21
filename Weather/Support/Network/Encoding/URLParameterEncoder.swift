//
//  URLParameterEncoder.swift
//  Weather
//
//  Created by Gabriel Patane Todaro on 19/05/22.
//

import Foundation

public struct URLParameterEncoder: ParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url else { throw NetworkError.missingURL }

        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
            !parameters.isEmpty {

            urlComponents.queryItems = [URLQueryItem]()
            for (parameterKey, parameterValue) in parameters {
                // swiftlint:disable:next line_length
                let queryItem = URLQueryItem(name: parameterKey, value: "\(parameterValue)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }

        if urlRequest.value(forHTTPHeaderField: Constants.HTTPConstants.contentType) == nil {
            urlRequest.setValue(Constants.HTTPConstants.applicationWww,
                                forHTTPHeaderField: Constants.HTTPConstants.contentType)
        }
    }

}
