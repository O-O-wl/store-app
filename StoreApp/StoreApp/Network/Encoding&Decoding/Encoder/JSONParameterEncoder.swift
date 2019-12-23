//
//  JSONParameterEncoder.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/24.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation

struct JSONParameterEncoder: ParameterEncoder {
    
    static func encode(_ request: URLRequestConvertible, with parameter: Encodable) -> URLRequest? {
        var request = request.asURLRequest()
        let encodable = EncodableWrapper(encodable: parameter)
        
        guard let encoded = try? JSONEncoder().encode(encodable) else { return request }
        
        request.httpBody = encoded
        return request
    }
}
