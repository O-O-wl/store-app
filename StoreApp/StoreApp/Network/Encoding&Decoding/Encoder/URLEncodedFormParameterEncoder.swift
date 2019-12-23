//
//  URLEncodedFormParameterEncoder.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/24.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation

struct URLEncodedFormParameterEncoder: ParameterEncoder {
    
    static func encode(_ request: URLRequestConvertible, with parameter: Encodable) -> URLRequest?  {
        var request = request.asURLRequest()
        let parameter = parameter.asDictionary()
        var urlComponents = URLComponents(url: request.url!, resolvingAgainstBaseURL: true)
        
        let queryItems = parameter?.compactMap {
            URLQueryItem(name: $0.key, value: $0.value as? String)
        }
        
        urlComponents?.queryItems = queryItems
        request.url = urlComponents?.url
        
        return request
    }
}
