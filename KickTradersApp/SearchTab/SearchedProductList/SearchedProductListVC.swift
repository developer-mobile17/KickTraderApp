//
//  SearchedProductListVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 12/02/21.
//  Copyright © 2021 VikasSIngh. All rights reserved.
//

import UIKit

class SearchedProductListVC: UIViewController {
    @IBOutlet var objTable: UITableView!
    var arrSearchedProductItem = [SearchResult]()

    override func viewDidLoad() {
        super.viewDidLoad()

        //TODO:- Pass StructArray into UserDefaults

        let defaults = UserDefaults.standard
              if let data = defaults.data(forKey: "DefaultSearchedProductArray") {
                arrSearchedProductItem = try! PropertyListDecoder().decode([SearchResult].self, from: data)

              }
        print(arrSearchedProductItem)
        objTable.reloadData()
}

    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
}

extension SearchedProductListVC: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSearchedProductItem.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchProductListCell", for: indexPath) as! SearchProductListCell


        let mySearchItemIS = self.arrSearchedProductItem[indexPath.row]


        let imgURL = URL(string:"\(PRODUCT_COVER_IMAGE)\(mySearchItemIS.productCoverImage!)")
        cell.imgShoes.kf.setImage(with: imgURL)
        cell.lblShoeName.text = mySearchItemIS.productName?.capitalized
        cell.lblPrice.text = "\("$")\(mySearchItemIS.productPrice!)"
//        if let rating = (mySearchItemIS.averageRating!){
//            cell.vwStarRating.rating = Double(Float(rating)!)
//
//        }
       // cell.vwStarRating.rating = Double(Float(mySearchItemIS.averageRating!)!)




        return cell
    }



    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let productRef = arrSearchedProductItem[indexPath.row].productRef

        let Defaults = UserDefaults.standard
        Defaults.set(productRef, forKey: "DefaultsproductRef")

        self.show(self.storyboard!.instantiateViewController(withIdentifier: "ProductDetailVC"), sender: self)







//        let productDetails =  self.storyboard?.instantiateViewController(identifier: "ProductDetailVC") as! ProductDetailVC
//
//
//        self.navigationController?.pushViewController(productDetails, animated: true)
    }


}
