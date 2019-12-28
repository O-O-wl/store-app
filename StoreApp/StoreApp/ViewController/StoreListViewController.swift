//
//  ViewController.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/04.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit
import SnapKit
import Then
import Toaster


final class StoreListViewController: UIViewController, StoreListViewPresentable {
    
    // MARK: - UI
    
    private let storeTableView = UITableView()
    
    // MARK: - Dependencies
    
    var viewModel: StoreListViewBindable? {
        didSet { bindViewModel() }
    }
    
    var reactor: StoreTableViewReactor? {
        didSet { bindReactor() }
    }
    
    // MARK: - Life Cycle
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setUpAttribute()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setUpConstraints()
    }
}

// MARK: - Attributes & Layouts

extension StoreListViewController {
    
    private func setUpAttribute() {
        self.view.do {
            $0.addSubview(storeTableView)
            $0.backgroundColor = .systemBackground
        }
        
        storeTableView.do {
            $0.register(MenuCell.self,
                        forCellReuseIdentifier: MenuCell.reuseId)
            $0.register(CategoryHeaderView.self,
                        forHeaderFooterViewReuseIdentifier: CategoryHeaderView.reuseId)
            $0.rowHeight = UITableView.automaticDimension
            $0.sectionHeaderHeight = 70
            $0.separatorStyle = .none
        }
    }
    
    private func setUpConstraints() {
        storeTableView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalTo(self.view)
        }
    }
}

// MARK: - Bind

extension StoreListViewController {
    
    private func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        viewModel.sectionDataDidUpdate = { [weak self] section in
            DispatchQueue.main.async {
                self?.storeTableView.reloadData()
                self?.storeTableView.beginUpdates()
                self?.storeTableView.reloadSections([section], with: .automatic)
                self?.storeTableView.endUpdates()
            }
        }
        
        viewModel.rowDataDidUpdate = { [weak self] indexPath in
            DispatchQueue.main.async {
                self?.storeTableView.reloadData()
            }
        }
        
        viewModel.errorDidOccured = { [weak self] error in
            
            let alert = UIAlertController(title: "네트워크 오류",
                                          message: error.localizedDescription,
                                          preferredStyle: .alert)
            DispatchQueue.main.async {
                alert.do {
                    $0.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self?.present($0, animated: true, completion: nil)
                }
            }
        }
        
        viewModel.dataDidSelected = { menu in
            let description = "\(menu.title)\n\(menu.salePrice)"
            
            DispatchQueue.main.async {
                Toast(text: description, duration: Delay.short).show()
            }
        }
    }
    
    private func bindReactor() {
        storeTableView.do {
            $0.dataSource = reactor
            $0.delegate = reactor
        }
    }
}
