//
//  StoreListViewBindable.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/09.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation
import BaminChan

// MARK: - StoreListViewDataSource

protocol StoreListViewDataSource: AnyObject {
    
    func numOfCategories() -> Int
    func numOfMenusInCategory(_ category: Int) -> Int
    
    subscript(category index: Int) -> Category { get }
    subscript(menu indexPath: IndexPath) -> Menu { get }
}

protocol StoreListViewDelegate: AnyObject {
    
    func select(at indexPath: IndexPath)
}

// MARK: - StoreListViewInteractable

protocol StoreListViewInteractable: AnyObject {
    
    var sectionDataDidUpdate: ((Int) -> Void)? { get set }
    var rowDataDidUpdate: ((IndexPath) -> Void)? { get set }
    var errorDidOccured: ((Error) -> Void)? { get set }
    var dataDidSelected: ((Menu) -> Void)? { get set }
}

// MARK: - StoreListViewManager

protocol StoreListViewManager:  StoreListViewDataSource, StoreListViewDelegate {}

// MARK: - StoreListViewBindable

protocol StoreListViewBindable: StoreListViewManager, StoreListViewInteractable {
    
}
