//
//  SettingVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 02/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

struct SettingModel {
    let titleSetting: String!
    let imgTitle: String!
}


class SettingVC: UIViewController {
    @IBOutlet var objtbl: UITableView!
    var arrSetting = [SettingModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // overrideUserInterfaceStyle is available with iOS 13
            if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }
        arrSetting = [SettingModel (titleSetting: "Notification", imgTitle: "bell.badge.fill"),
                      SettingModel(titleSetting: "Location", imgTitle: "location.fill"),
                      SettingModel(titleSetting: "Change Passoword", imgTitle: "lock.fill")
        ]
        objtbl.tableFooterView = UIView()

    }

    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated:true)
    }
}

extension SettingVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrSetting.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellSetting = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingCell
        
        let settingData = arrSetting[indexPath.row]
        cellSetting.lblTitle.text = settingData.titleSetting
       // cellSetting.imgTitle.image = UIImage(imageLiteralResourceName: settingData.imgTitle)
        cellSetting.imgTitle.image = UIImage(systemName:settingData.imgTitle)


        if cellSetting.lblTitle.text == "Change Passoword" {
            cellSetting.switchNotification.isHidden = true
        }
        else {
            cellSetting.switchNotification.tag = indexPath.row
            cellSetting.switchNotification.isHidden = false
        }

        

        //here is programatically switch make to the table view
//        let switchView = UISwitch(frame: .zero)
//        switchView.setOn(false, animated: true)
//        switchView.tag = indexPath.row // for detect which row switch Changed
//        // switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
//        cellSetting.accessoryView = switchView

        
        return cellSetting
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vcChangePassword =  self.storyboard?.instantiateViewController(identifier: "ChangePassword") as! ChangePassword
        self.navigationController?.pushViewController(vcChangePassword, animated: true)
        
    }
    
    
}
