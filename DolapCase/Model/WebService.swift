//
//  WebService.swift
//  DolapCase
//
//  Created by Ali Furkan Budak on 9.04.2020.
//  Copyright © 2020 Ali Furkan Budak. All rights reserved.
//

import Foundation
import UIKit

struct ProductService {
    static func getProduct(VC: UIViewController)-> Product?{
        do {
            return try ProductNetwork.getProduct()
        }catch{
            print("\(error)")
            DisplayAlerts.showErrorAlert(VC: VC, title: "error_loading_product_info")
            return nil
        }
    }
    
    static func getSocials(VC: UIViewController)-> ProductSocials?{
        do {
            return try ProductNetwork.getSocials()
        }catch{
            print("\(error)")
            DisplayAlerts.showErrorAlert(VC: VC, title: "error_loading_product_info")
            return nil
        }
    }
}
