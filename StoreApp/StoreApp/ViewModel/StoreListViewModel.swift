//
//  StoreListVIewModel.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/05.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation
import UIKit


typealias Store = (category: Category, menus: [Menu])

final class StoreListViewModel: StoreListViewBindable {
    
    // MARK: - Dependencies
    
    private let service: StoreDataService
    
    // MARK: - Properties
    
    private var stores: [Store] = [Store(category: .main, menus: []),
                                   Store(category: .soup, menus: []),
                                   Store(category: .side, menus: [])]
    
    // MARK: - Status Closure
    
    var dataDidLoad: (() -> Void)?
    var dataDidUpadated: (() -> Void)?
    var errorDidOccured: ((Error) -> Void)?
    var dataDidSelected: ((Menu) -> Void)?
    
    // MARK: - Initializer
    
    init(service: StoreDataService) {
        self.service = service
        fetchData()
    }
    
    // MARK: - Methods
    
    func numOfCategories() -> Int {
        return stores.filter { !$0.menus.isEmpty }.count
    }
    
    func numOfMenusInCategory(_ category: Int) -> Int {
        
        return stores[category].menus.count
    }
    
    // MARK: - Subscripts
    
    subscript(category index: Int) -> Category {
        let store = stores[index]
        return store.category
    }
    
    subscript(menu indexPath: IndexPath) -> Menu {
        let store = stores[indexPath.section]
        return store.menus[indexPath.row]
    }
    
    func select(at indexPath: IndexPath) {
        let menu = self[menu: indexPath]
        self.dataDidSelected?(menu)
    }
}

// MARK: - Fetch

extension StoreListViewModel {
    
    private func fetchData() {
        service
            .fetchData(category: .main)
            .workSpace(.main)
            .handle { result in
                guard let result = result else { return }
                switch result {
                case .success(let menus):
                    self.stores[0].menus = menus
                    self.dataDidLoad?()
                    print("Log:  \(self.stores[0].category.description) 0")
                case .failure(let error):
                    self.errorDidOccured?(error)
                }
        }
        
        service
            .fetchData(category: .soup)
            .workSpace(.main)
            .handle { result in
                guard let result = result else { return }
                switch result {
                case .success(let menus):
                    self.stores[1].menus = menus
                    self.dataDidLoad?()
                    print("Log:  \(self.stores[1].category.description) 1")
                case .failure(let error):
                    self.errorDidOccured?(error)
                }
        }
        
        service
            .fetchData(category: .side)
            .workSpace(.main)
            .handle { result in
                guard let result = result else { return }
                switch result {
                case .success(let menus):
                    self.stores[2].menus = menus
                    self.dataDidLoad?()
                    print("Log:  \(self.stores[2].category.description) 2")
                case .failure(let error):
                    self.errorDidOccured?(error)
                }
        }
    }
}
