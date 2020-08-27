//
//  Detail.swift
//  ImageNasa
//
//  Created by Alejandro Noriega Montalban on 8/25/20.
//  Copyright © 2020 Alejandro Noriega Montalban. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

var delegate: ResponseDelegate?

protocol ResponseDelegate {
    func didFinish(finishLoad response:(Response, apodResponse?))
}

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

func getApod(date: String) {
    let parameter = Parameters(date: date)

    Alamofire.request(URLS.base, method: .get, parameters: parameter.description, encoding: URLEncoding.queryString)
        .responseJSON { (response) in
            
            switch response.result {
            case .success:
                let jsonData = response.data

                do{
                    let data = try JSONDecoder().decode(apodResponse.self, from: jsonData!)
                    delegate?.didFinish(finishLoad: (.success, data))
                }catch {
                    debugPrint("[error]:", error.localizedDescription)
                    delegate?.didFinish(finishLoad: (.failure, nil))
                }
                
            case .failure(let error):
                debugPrint("[ERROR]:", error.localizedDescription)
                delegate?.didFinish(finishLoad: (.failure, nil))
            }
    }
    
}
