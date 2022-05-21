//
//  HTTPTask.swift
//  Weather
//
//  Created by Gabriel Patane Todaro on 19/05/22.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public enum HTTPTask {
    case request
    case requestParameters(bodyParamenters: Parameters?,
                           urlParameters: Parameters?)
    case requestParamentersAndHeaders(bodyParamenters: Parameters?,
                                      urlParameters: Parameters?,
                                      additionHeaders: HTTPHeaders?)
}
