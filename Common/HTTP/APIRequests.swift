//
//  APIRequests.swift
//  ImageNasa
//
//  Created by Orlando Sanchez on 27/08/20.
//  Copyright © 2020 Alejandro Noriega Montalban. All rights reserved.
//

import Alamofire

private let baseURL = URL(string: "https://api.nasa.gov")!

// Taken from https://github.com/Alamofire/Alamofire/blob/master/Documentation/AdvancedUsage.md#routing-requests
enum APIRequests: URLRequestConvertible {

    case fetchAPODDetail(APODRequest)

    private var method: HTTPMethod {
        switch self {
        case .fetchAPODDetail:
            return .get
        }
    }

    private var path: String {
        switch self {
        case .fetchAPODDetail:
            return "/planetary/apod"
        }
    }

    func asURLRequest() throws -> URLRequest {
        var urlReq = try URLRequest(url: baseURL.appendingPathComponent(path), method: method)

        switch self {
        case .fetchAPODDetail(let request):
            urlReq = try URLEncodedFormParameterEncoder.default.encode(request, into: urlReq)
        }

        return urlReq
    }

}
