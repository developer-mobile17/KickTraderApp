//
//  ViewController.swift
//  KickTradersApp
//
//  Created by anil kumar on 15/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    var checkFirtLogin: String?

    override func viewDidLoad() {
        super.viewDidLoad()


        let launchedBefore = UserDefaults.standard.bool(forKey: "DefaultFirstTimeLogin")
                if launchedBefore
                {
                    print("Not first launch.")
                    self.goToBuyerHome()
                }
                else
                {
                    print("First launch")
                    UserDefaults.standard.set(true, forKey: "DefaultFirstTimeLogin")
                }


        
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


extension ViewController {

    func goToBuyerHome(){
        let TabbarVC = self.storyboard?.instantiateViewController(identifier: "mainTabVC") as! mainTabVC

        self.navigationController?.pushViewController(TabbarVC, animated: true)
    }
}
