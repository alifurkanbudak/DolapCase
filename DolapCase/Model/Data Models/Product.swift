//
//  Product.swift
//  DolapCase
//
//  Created by Ali Furkan Budak on 7.04.2020.
//  Copyright © 2020 Ali Furkan Budak. All rights reserved.
//

import Foundation

// MARK: - Product
class Product: Codable {
    let id: Int
    let name, desc: String
    let image: String
    let price: Price
    
    init(id: Int, name: String, desc: String, image: String, price: Price) {
        self.id = id
        self.name = name
        self.desc = desc
        self.image = image
        self.price = price
    }
}

// MARK: - Price
class Price: Codable {
    let value: Int
    let currency: String

    init(value: Int, currency: String) {
        self.value = value
        self.currency = currency
    }
}

