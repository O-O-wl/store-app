//
//  DecodingService.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/24.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation

struct DecodingService {
    
    static func decode<D: Decodable>(type: D.Type, data: Data) -> D? {
        return try? JSONDecoder().decode(D.self, from: data)
    }
}
