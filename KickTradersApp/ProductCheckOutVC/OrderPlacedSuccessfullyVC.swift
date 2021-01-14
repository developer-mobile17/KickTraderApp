//
//  OrderPlacedSuccessfullyVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 13/01/21.
//  Copyright © 2021 VikasSIngh. All rights reserved.
//

import UIKit

class OrderPlacedSuccessfullyVC: UIViewController {

    @IBOutlet var imgOrderPlaced: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionViewOrder(_ sender: Any) {

        let vcTrans = storyboard?.instantiateViewController(identifier: "TransactionVC") as! TransactionVC
       self.navigationController?.pushViewController(vcTrans, animated: true)

    }
    
    @IBAction func actionGotohome(_ sender: Any) {
        self.goToBuyerHome()
        
    }

    func goToBuyerHome(){
        let TabbarVC = self.storyboard?.instantiateViewController(identifier: "mainTabVC") as! mainTabVC

        self.navigationController?.pushViewController(TabbarVC, animated: true)
    }
    
}
