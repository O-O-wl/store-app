//
//  StoreRepository.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/22.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation
import BaminChan

class StoreRepository: StoreDataService {
    
    typealias API = BaminChanAPI
    
    func fetchData(category: Category) -> Promise<Result<[Menu], Error>> {
        var endPoint: API
        switch category {
        case .main: endPoint = .main
        case .soup: endPoint = .soup
        case .side: endPoint = .side
        }
        
        return Router.route(to: endPoint)
    }
}
