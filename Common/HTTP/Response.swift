//
//  Detail.swift
//  ImageNasa
//
//  Created by Alejandro Noriega Montalban on 8/25/20.
//  Copyright © 2020 Alejandro Noriega Montalban. All rights reserved.
//

import Alamofire

struct apodResponse: Decodable {
    let copyright: String?
    let date: String?
    let explanation: String?
    let hdurl: String?
    let media_type: String?
    let service_version: String?
    let title: String?
    let url: String?
}

enum Response {
    case success
    case failure
}
