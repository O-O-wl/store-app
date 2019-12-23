//
//  StoreTableViewManager.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/13.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit

// MARK: - StoreTableViewManager

class StoreTableViewReactor: NSObject {
    
    weak var dataManager: StoreListViewManager?
    
    init(manager: StoreListViewManager) {
        self.dataManager = manager
    }
}

// MARK: - UITableViewDataSource

extension StoreTableViewReactor: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataManager?.numOfCategories() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager?.numOfMenusInCategory(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(with: MenuCell.self, for: indexPath),
            let menu = dataManager?[menu: indexPath]
            else { return MenuCell() }
        
        cell.configure(menu)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension StoreTableViewReactor: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard
            let categoryHeader = tableView.dequeueReusableHeaderFooterView(with: CategoryHeaderView.self),
            let category = dataManager?[category: section]
            else { return nil }
        
        categoryHeader.configure(category: category)
        return categoryHeader
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        dataManager?.select(at: indexPath)
    }
}
