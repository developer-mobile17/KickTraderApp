//
//  OrderVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 31/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

struct OrderModelData {
    let ShoeImg: String
    let ShoesName: String
    let Size : String
    let Color : UIColor
    let Price :String
    let Status:String
    
}


class OrderVC: UIViewController {

      var arrOrderData = [OrderModelData]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // overrideUserInterfaceStyle is available with iOS 13
            if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }

        arrOrderData = [OrderModelData(ShoeImg: "ezgif1 1",ShoesName: "Puma Shoes", Size: "7",Color: #colorLiteral(red: 0.7019607843, green: 0.09803921569, blue: 0.1333333333, alpha: 1),Price: "$105", Status: "Delivered"),
                     OrderModelData(ShoeImg: "ezgif1 1",ShoesName: "Nike Shoes", Size: "7",Color: #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1),Price: "$105", Status: "Cancelled"),
        
        ]
        
    }
    
}

extension OrderVC : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrOrderData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as!orderCell
        
        let MyOrderData = arrOrderData[indexPath.row]
        
        cell.imgShoes.image = UIImage(imageLiteralResourceName: MyOrderData.ShoeImg)
        cell.lblShoeName.text = MyOrderData.ShoesName
        cell.lblSize.text = MyOrderData.Size
        cell.lblColor.text = MyOrderData.Color.cgColor as? String
        
        cell.lblPrice.text = MyOrderData.Price
        cell.lblDate.text =  MyOrderData.Status
        
        cell.lblColor.layer.cornerRadius = 7
        cell.lblColor.clipsToBounds = true
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        guard let vc = storyboard?.instantiateViewController(identifier: "RateSellerVC") as? RateSellerVC else{
            
            return
        }
        present(vc, animated: true)
        
        
//        let rateToSeller = self.storyboard?.instantiateViewController(identifier: "RateSellerVC") as! RateSellerVC
//        self.navigationController?.pushViewController(rateToSeller, animated: true)
    }
    
    
}
