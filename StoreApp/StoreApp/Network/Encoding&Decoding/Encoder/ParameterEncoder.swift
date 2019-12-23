//
//  ParameterEncoder.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/24.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation


protocol ParameterEncoder {
    static func encode(_ request: URLRequestConvertible, with parameter: Encodable) -> URLRequest?
}
