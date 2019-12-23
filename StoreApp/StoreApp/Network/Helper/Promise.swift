//
//  Promiss.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/24.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation

class Promise<T> {
    
    // MARK: - Properties
    
    var value: T? {
        didSet {
            let task = DispatchWorkItem(block: { self.handler?(self.value) })
            thread(task)
        }
    }
    
    private var thread = DispatchQueue.global().async(execute:)
    
    private var handler: ((T?) -> Void)? {
        didSet {
            let task = DispatchWorkItem(block: { self.handler?(self.value) })
            thread(task)
        }
    }
    // MARK: - Methods
    
    @discardableResult
    func work(on threadType: ProcessingThread) -> Self {
        switch threadType {
        case .main:
            self.thread = DispatchQueue.main.async(execute:)
        case .global:
            self.thread = DispatchQueue.global().async(execute:)
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

