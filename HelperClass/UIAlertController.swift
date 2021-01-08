//
//  UIAlertController.swift
//  KickTradersApp
//
//  Created by anil kumar on 01/12/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
//Show a basic alert
func showAlert(alertMessage : String) {
    let alert = UIAlertController(title: "KickTrader App", message: alertMessage, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//Add more actions as you see fit
self.present(alert, animated: true, completion: nil)
  }
}

