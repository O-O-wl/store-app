//
//  Menu.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/05.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation

// MARK: - Menu

public struct Menu: Decodable {
    
    // MARK: - Properties
    
    public let imageURL: String
    public let deliveryType: [DeliveryType]
    public let title: String
    public let detail: String
    public let price: String?
    public let salePrice: String
    public let badge: [String]?

    // MARK: - CodingKeys
    
    public enum CodingKeys: String, CodingKey {
        case imageURL = "image"
        case deliveryType = "delivery_type"
        case title
        case detail = "description"
        case price = "n_price"
        case salePrice = "s_price"
        case badge
    }
}


// MARK: - DeliveryType

public enum DeliveryType: String, Decodable {
    
    case dawnShipping = "새벽배송"
    case nationalShipping = "전국택배"
}
