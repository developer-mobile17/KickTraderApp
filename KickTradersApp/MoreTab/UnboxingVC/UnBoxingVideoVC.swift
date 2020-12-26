//
//  UnBoxingVideoVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 22/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

class UnBoxingVideoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
 
}


extension UnBoxingVideoVC : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "unBoxingVideoCell", for: indexPath) as!unBoxingVideoCell
       
        return cell
    }
    
    
}

