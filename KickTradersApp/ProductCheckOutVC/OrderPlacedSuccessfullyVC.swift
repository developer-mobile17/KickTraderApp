//
//  OrderPlacedSuccessfullyVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 13/01/21.
//  Copyright © 2021 VikasSIngh. All rights reserved.
//

import UIKit
import Lottie

class OrderPlacedSuccessfullyVC: UIViewController {

    @IBOutlet var animationView: AnimationView!
    @IBOutlet var imgOrderPlaced: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()


        self.createAnimation()

    }


    func createAnimation() {
        // 1. Set animation content mode
        animationView.contentMode = .scaleAspectFit
        // 2. Set animation loop mode
        animationView.loopMode = .playOnce
        // 3. Adjust animation speed
        animationView.animationSpeed = 0.7
        // 4. Play animation
        animationView.play()
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
