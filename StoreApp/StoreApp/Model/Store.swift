//
//  Store.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/25.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation

struct Store {
    
    // MARK: - Properties
    
    let category: Category
    var menus: [Menu] = []
    
    // MARK: - Factory
    
    static func allStore() -> [Store] {
        return Category.allCases.map { Store(category: $0) }
    }
}
