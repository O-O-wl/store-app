//
//  ImageRepository.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/25.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation
import Then

class ImageDataRepository {
    
    // MARK: - Singletone
    
    static let shared = ImageDataRepository()
    
    // MARK: - Properties
    
    private var cache = NSCache<NSURL, NSData>()
    private var imageLoadQueue = DispatchQueue(label: "Image.load.queue", attributes: .concurrent)
    
    // MARK: - Initializer
    
    private init() {}
    
    // MARK: - Methods
    
    func fetchImageData(from url: URL) -> Promise<Data> {
        let promise = Promise<Data>()
        
        if let data = cache.object(forKey: url as NSURL) {
            return promise.then { $0.value = data as Data }
        }
        
        imageLoadQueue.async {
            guard let data = NSData(contentsOf: url) else { return }
            
            self.cache.setObject(data, forKey: url as NSURL)
            promise.value = data as Data
        }
        return promise
    }
}
