//
//  JSONParameterEncoder.swift
//  Weather
//
//  Created by Gabriel Patane Todaro on 19/05/22.
//

import Foundation

public struct JSONParameterEncoder: ParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: Constants.HTTPConstants.contentType) == nil {
                urlRequest.setValue(Constants.HTTPConstants.applicationJson,
                                    forHTTPHeaderField: Constants.HTTPConstants.contentType)
            }
        } catch {
            throw NetworkError.encodingFailed
        }
    }

}
