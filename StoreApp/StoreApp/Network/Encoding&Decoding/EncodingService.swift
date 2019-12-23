//
//  EncodingService.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/24.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation

struct EncodingService {
    
    static func encode(_ endpoint: EndPoint) -> URLRequest? {
        switch endpoint.task {
        case .request:
            return endpoint.asURLRequest()
        case .requestWithQueryParameters(let parameter):
            return URLEncodedFormParameterEncoder.encode(endpoint, with: parameter)
        case .requestWithBodyParameters(let parameter):
            return JSONParameterEncoder.encode(endpoint, with: parameter)
        }
    }
}
