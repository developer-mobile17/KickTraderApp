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
    
    
    @IBOutlet var objSegment: UISegmentedControl!
    @IBOutlet var objTable: UITableView!
    @IBOutlet var lblHeader: UILabel!
    var videoURL : URL!
    var imgURL: URL!
    var arrUnboxingVideo = [UnboxingVideos]()
    var arrProductVideo = [URL]()
    var productVideoPass: String!
    var checkVideoType: String!
    var productNamePass: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: "DefaultsproductVideoPass") {
            arrUnboxingVideo = try! PropertyListDecoder().decode([UnboxingVideos].self, from: data)
            print("Product Video are:- ",arrUnboxingVideo)
            
        }
        
        
        guard let ProductVideoURL = URL(string:"\(productVideoPass!)")  else {
            return
        }
        videoURL =   ProductVideoURL
        print(videoURL!)
        
        arrProductVideo.append(videoURL)
        print(arrProductVideo)
        
        // self.PlayProductVideo()
        
        
        checkVideoType = "ProductVideo"
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        checkVideoType = "ProductVideo"
        lblHeader.text =  productNamePass.capitalized
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

    
    
}


extension ProductVideoVC {
    func PlayProductVideo (){
    
        let player = AVPlayer(url: videoURL)
        let vc = AVPlayerViewController()
        vc.player = player
        present(vc, animated: true) {
            vc.player?.play()
        }
    }
}


//TODO:- Segment Bar
extension ProductVideoVC {
    @IBAction func actionSegementClicked(_ sender: Any) {
        if objSegment.selectedSegmentIndex == 0 {
            checkVideoType = "ProductVideo"
            self.objTable.reloadData()
           
        }
        else {
            checkVideoType = "UnboxingVideo"
            self.objTable.reloadData()
        }
    }
    
}



extension ProductVideoVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if checkVideoType == "ProductVideo" {
            return arrProductVideo.count
        }
        else if checkVideoType == "UnboxingVideo" {
            return arrUnboxingVideo.count
        }
        return arrUnboxingVideo.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "productVideoCell", for: indexPath) as! productVideoCell
        
        cell.btnPlay.tag = indexPath.row
        cell.btnPlay .addTarget(self, action: #selector(btnPlayClicked), for:.touchUpInside)
        
        cell.btnPlay.isHidden = true
        
        if checkVideoType == "ProductVideo" {
        if arrProductVideo.count == 0 {
            print("No Product Video Found")
        }
        }
        
        if checkVideoType == "ProductVideo" {
            cell.imgUnboxingVideo.showLoading(color: .systemRed)
            //TODO:- Algo To Genrate ThumbImage From URL
            DispatchQueue.global().async { [self] in
                
                do {
                    self.imgURL =  URL(string:"\(PRODUCT_UNBOXING_VIDEO)\(arrProductVideo[indexPath.row])")!
                    let asset = AVURLAsset(url: self.imgURL!)
                    let imageGenerator = AVAssetImageGenerator(asset: asset)
                    imageGenerator.appliesPreferredTrackTransform = true
                    let cgImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 3, timescale: 1), actualTime: nil)
                    let thumbnail = UIImage(cgImage: cgImage)
                    DispatchQueue.main.async {
                        cell.imgUnboxingVideo.stopLoading()
                        cell.imgUnboxingVideo.image = thumbnail
                        cell.btnPlay.isHidden = false
                    }
                    
                }catch{
                    print("Error is : \(error)")
                    DispatchQueue.main.async {
                        cell.imgUnboxingVideo.stopLoading()
                        //                                cell.imgUnboxingVideo.image = UIImage(imageLiteralResourceName:"NoImg.png")
                    }
                    
                }
                
                
            }
            
        }
        
        
        
        else {
            
            let UnboxingVideoData = arrUnboxingVideo[indexPath.row]
            
            cell.imgUnboxingVideo.showLoading(color: .systemRed)
            // cell.imgUnboxingVideo.kf.indicatorType = .activity
            
            //TODO:- Algo To Genrate ThumbImage From URL
            DispatchQueue.global().async { [self] in
                
                do {
                    self.imgURL =  URL(string:"\(PRODUCT_UNBOXING_VIDEO)\(UnboxingVideoData.unboxingVideo!)")!
                    let asset = AVURLAsset(url: self.imgURL!)
                    let imageGenerator = AVAssetImageGenerator(asset: asset)
                    imageGenerator.appliesPreferredTrackTransform = true
                    let cgImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 3, timescale: 1), actualTime: nil)
                    let thumbnail = UIImage(cgImage: cgImage)
                    DispatchQueue.main.async {
                        cell.imgUnboxingVideo.stopLoading()
                        cell.imgUnboxingVideo.image = thumbnail
                        cell.btnPlay.isHidden = false
                    }
                    
                }catch{
                    print("Error is : \(error)")
                    DispatchQueue.main.async {
                        //                            cell.imgUnboxingVideo.image = UIImage(imageLiteralResourceName:"NoImg.png")
                    }
                    
                }
                
                
            }
            
            
        }
        
        
        
        
        return cell
    }
    
    
}

//MARK:- Button Delete Item Clicked
extension ProductVideoVC{
    @objc func btnPlayClicked(sender: UIButton){
        videoURL =  URL(string:"\(PRODUCT_UNBOXING_VIDEO)\(arrUnboxingVideo[sender.tag].unboxingVideo!)")!
        print(videoURL!)
        let player = AVPlayer(url: videoURL)
        let vc = AVPlayerViewController()
        vc.player = player
        present(vc, animated: true) {
            vc.player?.play()
        }
        
    
    }
}
