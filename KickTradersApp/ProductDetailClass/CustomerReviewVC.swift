//
//  CustomerReviewVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 28/01/21.
//  Copyright © 2021 VikasSIngh. All rights reserved.
//

import UIKit

class CustomerReviewVC: UIViewController {
    var arrComments = [Comments]()

    @IBOutlet var objTblCustomerReview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // overrideUserInterfaceStyle is available with iOS 13
            if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }

        let defaults = UserDefaults.standard
              if let data = defaults.data(forKey: "arrCommentPass") {
                arrComments = try! PropertyListDecoder().decode([Comments].self, from: data)

              }
        print(arrComments)
        objTblCustomerReview.reloadData()
        


    }

    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}

extension CustomerReviewVC:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return arrComments.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let userReview_cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailReviewCell", for: indexPath) as! ProductDetailReviewCell
                let imgURL = URL(string:"\(PROFILE_IMAGE)\(arrComments[indexPath.row].profile_Image!)")
                userReview_cell.imgCommentUser.kf.setImage(with: imgURL)

                userReview_cell.lblUsername.text = arrComments[indexPath.row].full_Name
                userReview_cell.lblReviewDate.text = arrComments[indexPath.row].create_at
                userReview_cell.lblReviewDesc.text = arrComments[indexPath.row].comment
                userReview_cell.lblReviewRating.text = arrComments[indexPath.row].rating

                return userReview_cell
            }


}
