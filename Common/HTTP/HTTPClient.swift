//
//  HTTPClient.swift
//  ImageNasa
//
//  Created by Orlando Sanchez on 27/08/20.
//  Copyright © 2020 Alejandro Noriega Montalban. All rights reserved.
//

import Alamofire

// TODO: Include an error to show to the user
typealias APODClosure = (_ response: apodResponse?) -> Void

final class HTTPClient {

    static let shared = HTTPClient()
    private let session: Session

    private init() {
        self.session = Session()
    }

    func getAPOD(for date: String, completion: @escaping APODClosure) {
        let apodReq = APODRequest(date: date)

        session
            .request(APIRequests.fetchAPODDetail(apodReq))
            .validate()
            .responseDecodable(of: apodResponse.self) { (response) in
                switch response.result {
                case .success(let res):
                    completion(res)
                case .failure(let error):
                    print("Error: \(error)")
                    completion(nil)
                }
        }
    }

}
