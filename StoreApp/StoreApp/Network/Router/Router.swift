//
//  Router.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/24.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation

struct Router {
    
    // MARK: - Properties
    
    static let session = URLSession(configuration: .default)
    
    // MARK: - Methods
    
    static func route(to endpoint: EndPoint) -> Promise<Result<[Menu], Error>> {
        let promiss = Promise<Result<[Menu], Error>>()
        guard let request = EncodingService.encode(endpoint) else { return promiss }
        
        let task = session.dataTask(with: request) { data, _, error in
            if let error = error {
                promiss.value = .failure(error)
            }
            
            guard let data = data,
                let response = DecodingService.decode(type: Response.self, data: data)
                else { return }
            
            promiss.value = .success(response.body)
        }
        
        task.resume()
        
        return promiss
    }
}
