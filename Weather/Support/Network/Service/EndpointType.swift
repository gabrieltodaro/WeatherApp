//
//  EndpointType.swift
//  Weather
//
//  Created by Gabriel Patane Todaro on 19/05/22.
//

import Foundation

public protocol EndpointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var httpHeaders: HTTPHeaders? { get }
}
