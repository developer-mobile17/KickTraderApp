//
//  ViewController.swift
//  KickTradersApp
//
//  Created by anil kumar on 15/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
    }

    @IBAction func actionGetStarted(_ sender: Any) {
        let loginVW = self.storyboard?.instantiateViewController(identifier: "TypeOfAccountVC") as! TypeOfAccountVC
                self.navigationController?.pushViewController(loginVW, animated: true)
    }
    @IBAction func actionLogin(_ sender: Any) {
        
        
     
        let loginVW = self.storyboard?.instantiateViewController(identifier: "LoginVC") as! LoginVC
         self.navigationController?.pushViewController(loginVW, animated: true)
        
    }
    
}

