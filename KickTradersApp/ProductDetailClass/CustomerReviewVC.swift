//
//  CustomerReviewVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 28/01/21.
//  Copyright © 2021 VikasSIngh. All rights reserved.
//

import UIKit

class CustomerReviewVC: UIViewController {
    var ratingRef:String?
    var userRef:String?
    var fromRef:String?
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



        //TODO:-String to Date Convert
        let dateString =  arrComments[indexPath.row].create_at
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
      //  dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let s = dateFormatter.date(from: dateString ?? "")


        //TODO:- CONVERT FROM NSDate to String

        let date2Formatter = DateFormatter()
        date2Formatter.dateFormat = "MMM d, h:mm a"
      //  date2Formatter.timeZone = NSTimeZone.local
        let date2String = date2Formatter.string(from:s! as Date)
        print(date2String)
        //cell.lblDate.text = date2String


        userReview_cell.lblUsername.text = arrComments[indexPath.row].full_Name
        userReview_cell.lblReviewDate.text = date2String
        userReview_cell.lblReviewDesc.text = arrComments[indexPath.row].comment
        userReview_cell.lblReviewRating.text = arrComments[indexPath.row].rating

        fromRef = arrComments[indexPath.row].fromRef
        userRef = UserDefaults.standard.value(forKey: "DefaultsbuyerRef") as? String

        if userRef == fromRef {
            userReview_cell.btnDeleteComment.isHidden = false
        }
        else {
            userReview_cell.btnDeleteComment.isHidden = true

        }

        //TODO: btn DeleteComment Action

        userReview_cell.btnDeleteComment.tag = indexPath.row
        userReview_cell.btnDeleteComment .addTarget(self, action: #selector(btnDeleteCommentClicked), for:.touchUpInside)

        return userReview_cell
    }
}

//MARK:- Button remove Cart Item Clicked
extension CustomerReviewVC{
    @objc func btnDeleteCommentClicked(sender: UIButton){


        ratingRef = arrComments[sender.tag].rattingRef
        self.ShowAlertForRemoveReview()

        }
    }


extension CustomerReviewVC {
    func ShowAlertForRemoveReview() {
        let alert = UIAlertController(title: "KickTrader App", message: "Are you sure want to delete this review?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
            action in
            print("You clicked on remove review")
            self.removeReviewOfBuyerAPI()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: {
            action in
            print("You clicked NO")
        }))

        self.present(alert, animated: true)
    }
}
extension CustomerReviewVC {
    func removeReviewOfBuyerAPI() {

        ProgressHUD.show(interaction: false)
        let removeReviewParam = removeReviewRequest(ratingRef:ratingRef ?? "")
        BuyerAPIManager.shareInstance.callingRemoveReview_API(removeReviewParam: removeReviewParam) {(result) in

            switch result{
            case.success(let json):
                ProgressHUD.dismiss()

                if let msg = (json as? removeReviewResponse)?.msg {
                    print(msg)
                    AppSnackBar.make(in: self.view, message: msg, duration: .lengthShort).show()
                    self.objTblCustomerReview.reloadData()

                }

            case.failure(let err):
                print(err.localizedDescription)
            }

        }

    }
}

