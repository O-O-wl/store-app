//
//  Promiss.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/24.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation
import Then

class Promise<T> {
    
    // MARK: - Properties
    
    var value: T? {
        didSet { execute() }
    }
    
    var thread: ProcessingThread?
    
    var handler: ((T?) -> Void)? {
        didSet { execute() }
    }
    
    // MARK: - Methods
    
    @discardableResult
    func on(thread: ProcessingThread) -> Self {
        self.thread = thread
        return self
    }
    
    func after(_ handler: ((T?) -> Void)?) -> Self {
        self.handler = handler
        return self
    }
    
    private func execute() {
        guard let thread = thread else { return }
        
        let task = DispatchWorkItem { self.handler?(self.value) }
        switch thread {
        case .main: DispatchQueue.main.async(execute: task)
        case .background: DispatchQueue.global().async(execute: task)
        }
    }
    
    // MARK: - ProcessingTread
    
    enum ProcessingThread {
        case main
        case background
    }
}

// MARK: - Then

extension Promise: Then {}
