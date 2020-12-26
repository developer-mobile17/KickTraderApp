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
        arrSetting = [SettingModel (titleSetting: "Notification", imgTitle: "notification"),
                      SettingModel(titleSetting: "Location", imgTitle: "location")
        ]
        objtbl.tableFooterView = UIView()

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
        cellSetting.imgTitle.image = UIImage(imageLiteralResourceName: settingData.imgTitle)
        
        return cellSetting
    }
    
    
}
