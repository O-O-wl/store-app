//
//  Encodable+.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/24.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation

extension Encodable {
    
    func asDictionary() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
        
        return jsonObject as? [String: Any]
    }
}
