//
//  WebService.swift
//  DolapCase
//
//  Created by Ali Furkan Budak on 9.04.2020.
//  Copyright © 2020 Ali Furkan Budak. All rights reserved.
//

import Foundation

struct ProductNetwork {
    static func getProduct()throws-> Product {
        let path = Bundle.main.path(forResource: "Product", ofType: "json")
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
            return try JSONDecoder().decode(Product.self, from: data)
        }catch {
            print("\(error)")
            throw Errors.DataFetchError.productInfoError
        }
    }
    
    static func getSocials()throws-> ProductSocials {
        let path = Bundle.main.path(forResource: "Social", ofType: "json")
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
            return try JSONDecoder().decode(ProductSocials.self, from: data)
        }catch {
            print("\(error)")
            throw Errors.DataFetchError.socialInfoError
        }
    }
}
