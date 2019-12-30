//
//  StubService.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/06.
//  Copyright © 2019 이동영. All rights reserved.
//
import Foundation
import BaminChan

struct StubDataService: StoreDataService {
    
    // MARK: - Properties
    
    private let dispatchGroup = DispatchGroup()
    private let serialQueue = DispatchQueue(label: "store.fetch", qos: .default)
    
    
    // MARK: - Methods
    
    func fetchData(category: Category) -> Promise<Result<[Menu], Error>> {
        var endPoint: DummyAPI
        switch category {
        case .main: endPoint = .main
        case .soup: endPoint = .soup
        case .side: endPoint = .side
        }
        let promise = Promise<Result<[Menu], Error>>()
        
        serialQueue.async(group: dispatchGroup) {
            guard let data = endPoint.sampleData else { return }
            
            do {
                let menus = try JSONDecoder().decode([Menu].self, from: data)
                promise.value = .success(menus)
            } catch let error {
                promise.value = .failure(error)
            }
        }
        return promise
    }
}

