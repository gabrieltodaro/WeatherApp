//
//  ParameterEncoding.swift
//  Weather
//
//  Created by Gabriel Patane Todaro on 19/05/22.
//

import Foundation

public typealias Parameters = [String: Any]

public protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public enum NetworkError: String, Error {
    case parameterNil = "Parameter is missing."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is missing."
}
