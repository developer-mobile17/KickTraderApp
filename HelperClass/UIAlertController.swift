//
//  UIAlertController.swift
//  KickTradersApp
//
//  Created by anil kumar on 01/12/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController{
  
    func showKickTraderAlert(message: String) {
    let alertController = UIAlertController(title: "KickTrader App", message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default)
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    alertController.addAction(okAction)
    alertController.addAction(cancelAction)
    self.present(alertController, animated: true)
    }
    
}

