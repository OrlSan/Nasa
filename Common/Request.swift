//
//  ConstantString.swift
//  ImageNasa
//
//  Created by Alejandro Noriega Montalban on 8/26/20.
//  Copyright © 2020 Alejandro Noriega Montalban. All rights reserved.
//

struct URLS {
    static let base = "https://api.nasa.gov/planetary/apod"
    static let key = "uQv9NryUqgOUbbhWGbV3PbpE6tFYioNckKX6GRYs"
    static let imageDefault = "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQDLdh40tsAVxk_BDPtMxJ9nERE43War5Zebg&usqp=CAU"
}

struct Parameters: Codable {
    var date: String
    
    var description: [String: Any] {
        return [
            "date" : date,
            "api_key" : URLS.key
        ]
    }
}
