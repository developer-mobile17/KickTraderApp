//
//  ProductVideoVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 28/12/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit
import AVKit
import WMSegmentControl

class ProductVideoVC: UIViewController {
    @IBOutlet weak var sgTextOnlyBar: WMSegment!
    @IBOutlet var objTable: UITableView!
    var videoURL : URL!
    var arrProductVideo = [UnboxingVideos]()
    
    
    var productVideoPass: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        sgTextOnlyBar.selectorType = .bottomBar
        sgTextOnlyBar.normalFont = UIFont(name:"Helvetica", size: 14)!
        sgTextOnlyBar.SelectedFont = UIFont(name: "Helvetica-Bold", size: 14)!
        
        
        
        let defaults = UserDefaults.standard
              if let data = defaults.data(forKey: "SavedItemArray") {
                arrProductVideo = try! PropertyListDecoder().decode([UnboxingVideos].self, from: data)
                
              }
        
        
        
        print(productVideoPass!)
        videoURL =  URL(string:"\(PRODUCT_VIDEO)\(productVideoPass!)")

        print(videoURL!)
        let player = AVPlayer(url: videoURL)
        let vc = AVPlayerViewController()
        vc.player = player
        present(vc, animated: true) {
            vc.player?.play()
        }
    }
}
extension ProductVideoVC {
    func segmentLoadData(){
     
        //Using callbacks
        sgTextOnlyBar.onValueChanged = { [self] index in
                   print("I have selected index \(index) from WMSegment!")
                
                if index == 0 {
                    
                   
                    self.objTable.reloadData()
                    
                }
                if index == 1 {
                   
                    self.objTable.reloadData()
                    
                }
               
                
                
               }
    }
        
}


extension ProductVideoVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrProductVideo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "productVideoCell", for: indexPath) as! productVideoCell
        
        let productVideoData = arrProductVideo[indexPath.row]
        
        
        cell.btnPlay.tag = indexPath.row
        cell.btnPlay .addTarget(self, action: #selector(btnPlayClicked), for:.touchUpInside)
        
        
        return cell
    }
    
    
}


//MARK:- Button Delete Item Clicked
extension ProductVideoVC{
    @objc func btnPlayClicked(sender: UIButton){
        
        let vURL = arrProductVideo[sender.tag].unboxingVideo!
        print(vURL)
        
        videoURL =  URL(string:"\(PRODUCT_VIDEO)\(arrProductVideo[sender.tag].unboxingVideo!)")!
        print(videoURL!)
        let player = AVPlayer(url: videoURL)
        let vc = AVPlayerViewController()
        vc.player = player
        present(vc, animated: true) {
            vc.player?.play()
        }
        
    
    }
}
