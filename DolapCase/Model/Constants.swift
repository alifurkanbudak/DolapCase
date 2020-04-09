//
//  Constants.swift
//  DolapCase
//
//  Created by Ali Furkan Budak on 9.04.2020.
//  Copyright © 2020 Ali Furkan Budak. All rights reserved.
//

import Foundation

struct Errors {
    enum DataFetchError: Error {
        case socialInfoError
        case productInfoError
    }
}

struct Constants {
    static let counterCycle = 60
}
