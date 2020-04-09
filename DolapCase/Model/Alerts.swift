//
//  Alerts.swift
//  DolapCase
//
//  Created by Ali Furkan Budak on 9.04.2020.
//  Copyright © 2020 Ali Furkan Budak. All rights reserved.
//

import Foundation
import UIKit

struct DisplayAlerts {
    
    // Informs the user about an error
    static func showErrorAlert(VC: UIViewController, title: String) {
        let alertController = UIAlertController(title: NSLocalizedString(title, comment: ""), message:
            nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("okay", comment: ""), style: .cancel))
        VC.present(alertController, animated: true, completion: nil)
    }
    
}
