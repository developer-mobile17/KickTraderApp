//
//  SellerProductEditVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 10/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

class SellerProductEditVC: UIViewController {
    
    @IBOutlet var productImgSlider : PhotoSliderView!
    @IBOutlet var objScroll: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
    objScroll.contentSize = (CGSize(width: self.objScroll.frame.size.width, height: 800))
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
           
           let images: [UIImage] = [UIImage(named: "Shoe")!,
                                    UIImage(named: "shoe2")!,
                                    UIImage(named: "ezgif1 1")!,
                                    UIImage(named: "Shoe")!,
                                    UIImage(named: "shoe2")!,
                                    UIImage(named: "ezgif1 1")!]
           
           productImgSlider.configure(with: images)
       }
    
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
