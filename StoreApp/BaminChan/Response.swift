//
//  Response.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/24.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation

public struct Response: Decodable {
    
    public let statusCode: Int
    public let body: [Menu]
}
