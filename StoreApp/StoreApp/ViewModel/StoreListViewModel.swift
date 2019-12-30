//
//  StoreListVIewModel.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/05.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation
import UIKit
import BaminChan

final class StoreListViewModel: StoreListViewBindable {
    
    // MARK: - Dependencies
    
    private let service: StoreDataService
    
    // MARK: - Properties
    
    private var stores: [Store] = Store.allStore()
    
    // MARK: - Status Closure
    
    var sectionDataDidUpdate: ((Int) -> Void)?
    var rowDataDidUpdate: ((IndexPath) -> Void)?
    var errorDidOccured: ((Error) -> Void)?
    var dataDidSelected: ((Menu) -> Void)?
    
    // MARK: - Initializer

    init(service: StoreDataService) {
        self.service = service
        
        fetchData()
    }
    
    // MARK: - Methods
    
    func numOfCategories() -> Int {
        return stores.count
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
        Category.allCases.forEach { fetchMenus(in: $0) }
    }
    
    private func fetchMenus(in category: Category) {
        service
            .fetchData(category: category)
            .on(thread: .main)
            .after { result in
                guard let result = result else { return }
                switch result {
                case .success(let menus):
                    self.stores[category.index].menus = menus
                    self.sectionDataDidUpdate?(category.index)
                case .failure(let error):
                    self.errorDidOccured?(error)
                }
        }
    }
}
