//
//  UIAlertController.swift
//  KickTradersApp
//
//  Created by anil kumar on 01/12/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation
import UIKit

//extension UIAlertController{
//
//    func showKickTraderAlert(message: String) {
//    let alertController = UIAlertController(title: "KickTrader App", message: message, preferredStyle: .alert)
//    let okAction = UIAlertAction(title: "Ok", style: .default)
//    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
//    alertController.addAction(okAction)
//    alertController.addAction(cancelAction)
//    self.present(alertController, animated: true)
//    }
//
//}



extension UIViewController {
//Show a basic alert
func showAlert(alertMessage : String) {
    let alert = UIAlertController(title: "KickTrader App", message: alertMessage, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
//Add more actions as you see fit
self.present(alert, animated: true, completion: nil)
  }
}

