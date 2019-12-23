//
//  Promiss.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/24.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation

class Promiss<T> {
    
    // MARK: - Properties
    
    var value: T? {
        didSet {
            let task = DispatchWorkItem(block: { self.handler?(self.value) })
            workSpace(task)
        }
    }
    
    private var workSpace = DispatchQueue.global().async(execute:)
    
    private var handler: ((T?) -> Void)? {
        didSet {
            let task = DispatchWorkItem(block: { self.handler?(self.value) })
            workSpace(task)
        }
    }
    // MARK: - Methods
    
    @discardableResult
    func workSpace(_ type: ProcessingThread) -> Self {
        switch type {
        case .main:
            self.workSpace = DispatchQueue.main.async(execute:)
        case .global:
            self.workSpace = DispatchQueue.global().async(execute:)
        }
        
        return self
    }
    
    func handle(_ handler: ((T?) -> Void)?) {
        self.handler = handler
    }
    
    // MARK: - ProcessingTread
    
    enum ProcessingThread {
        case main
        case global
    }
}

