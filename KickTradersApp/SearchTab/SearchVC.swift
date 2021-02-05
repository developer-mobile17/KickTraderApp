//
//  SearchVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 21/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit


var arrCategories = [Category]()
var arrbrands = [Brand]()
var arrsize = [Size]()
var arrcolor = [Color]()

class SearchVC: UIViewController {
    @IBOutlet var objTable: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // overrideUserInterfaceStyle is available with iOS 13
            if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }
        self.CallingGetAllDropDownBuyerAPI()
    }
    
}


extension SearchVC {
    func CallingGetAllDropDownBuyerAPI(){
        
        ProgressHUD.show()
        APIManger.shareInstance.callingGetAllDropdownListAPI() {(result) in
            
            switch result{
            case.success(let json):
            print(json!)
                
            ProgressHUD.dismiss()
                arrCategories = ((json as! Welcome).array?.categories!)!
             //   print("Categories are: ",self.arrCategories)
                
                
            arrbrands = ((json as! Welcome).array?.brands!)!
               // print("Brands are: ",arrbrands)
            
            
            arrcolor = ((json as! Welcome).array?.color!)!
                
             arrsize = ((json as! Welcome).array?.size!)!
      
                self.objTable.reloadData()
                
                
            case.failure(let err):
                print(err.localizedDescription)
            }
            
        }
        
    }
}



extension SearchVC: UITableViewDataSource,UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
       3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let BrandCell = tableView.dequeueReusableCell(withIdentifier: "SearchTopBrandCell", for: indexPath) as! SearchTopBrandCell
            
            BrandCell.reloadBrandCollectionView()
            
            return BrandCell
        }
        else if indexPath.section == 1 {
            
            let colorTableCell = tableView.dequeueReusableCell(withIdentifier: "colorTableCell", for: indexPath) as! colorTableCell
            
            colorTableCell.reloadColorCollectionView()
            
            return colorTableCell
            
        }
        
        
        else if indexPath.section == 2 {
            
            let GenderTableCell = tableView.dequeueReusableCell(withIdentifier: "GendertableCell", for: indexPath) as! GendertableCell
            
            GenderTableCell.reloadGenderCollectionView()
            
            return GenderTableCell
            
        }
        
        
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
             return 125
        }
        else if indexPath.section  == 1{
             return 90
        }
        
        else if indexPath.section  == 2{
             return 95
        }
        
       return 0
    }


    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let label = UILabel()
        let Color = UIColor(red: 200.0/255.0, green: 16.0/255.0, blue: 46.0/255.0, alpha: 1.0)
        
        if section == 0 {
            label.text = "Top Brands:"
            label.textColor = Color
            label.font = label.font.withSize(15)
        } else if section  == 1 {
            label.text = "Colors: "
            label.textColor = Color
            label.font = label.font.withSize(15)
        }
        else{
            label.text = "Gender:"
            label.textColor = Color
            label.font = label.font.withSize(15)
        }
        
        return label
        
    }
    
}


