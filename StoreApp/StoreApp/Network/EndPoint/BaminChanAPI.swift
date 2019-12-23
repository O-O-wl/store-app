//
//  BaminChanAPI.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/22.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation

enum BaminChanAPI {
    case main
    case soup
    case side
}

extension BaminChanAPI: EndPoint {
    
    var baseURL: URL {
        return URL(string:"https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan")!
    }
    
    var path: String {
        switch self {
        case .main: return "main"
        case .soup: return "soup"
        case .side: return "side"
        }
    }
    
    var method: HTTP.Method {
        return .get
    }
    
    var task: HTTP.Task {
        return .request
    }
    
    var headers: HTTP.Headers? {
        return nil
    }
    
    var sampleData: Data? {
        return nil
    }
    
    func asURLRequest() -> URLRequest {
        return URLRequest(baseURL, path: path, method: method, headers: headers)
    }
}
