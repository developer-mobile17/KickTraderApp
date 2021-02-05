//
//  UnBoxingVideoVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 22/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Kingfisher

class UnBoxingVideoVC: UIViewController {
    @IBOutlet var objTable: UITableView!
    var arrUnboxingResult = [UnboxingResult]()
    var strBaseUrl : String!
    var videoURL: URL!
    var imgURL: URL!

    override func viewDidLoad() {
        super.viewDidLoad()


        // overrideUserInterfaceStyle is available with iOS 13
            if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }
        
        self.CallingGetUnboxingVideoAPI()
        
    }
 
}


extension UnBoxingVideoVC {
    func CallingGetUnboxingVideoAPI(){
        
        ProgressHUD.show()
        BuyerAPIManager.shareInstance.callingGetUnboxingVideo() { [self](result) in
            
            switch result{
            case.success(let json):
                print(json!)
                
                ProgressHUD.dismiss()
                self.arrUnboxingResult = ((json as! unboxingVideoModel).unboxingResult)!

                guard let videoBaseURL = (json as? unboxingVideoModel)?.base_url else {return}
                strBaseUrl = videoBaseURL
                self.objTable.reloadData()
                
                
            case.failure(let err):
                print(err.localizedDescription)
            }
            
        }
        
    }
}




extension UnBoxingVideoVC : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrUnboxingResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "unBoxingVideoCell", for: indexPath) as!unBoxingVideoCell
     //   let thumbnail = ROThumbnail.sharedInstance
        let unboxingVideoData = self.arrUnboxingResult[indexPath.row]
        
        cell.btnVideoPlayClicked.isHidden = true
        cell.imgShoes.showLoading(color: .systemRed)
        self.imgURL =  URL(string:"\(self.strBaseUrl!)\(unboxingVideoData.unboxingVideo!)")!
      //  cell.imgShoes.image = thumbnail.getThumbnail(self.imgURL)


        
        DispatchQueue.global().async { [self] in

        do {
            self.imgURL =  URL(string:"\(self.strBaseUrl!)\(unboxingVideoData.unboxingVideo!)")!
            let asset = AVURLAsset(url: self.imgURL!)
                        let imageGenerator = AVAssetImageGenerator(asset: asset)
                        imageGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 3, timescale: 1), actualTime: nil)
                        let thumbnail = UIImage(cgImage: cgImage)
            DispatchQueue.main.async {
                cell.imgShoes.stopLoading()
                cell.imgShoes.image = thumbnail
                cell.btnVideoPlayClicked.isHidden = false
            }

                    }catch{
                        print("Error is : \(error)")
                        DispatchQueue.main.async {
                            cell.imgShoes.stopLoading()
                            cell.imgShoes.image = UIImage(imageLiteralResourceName:"NoImg.png")

                                    }

                    }


        }

        cell.lblBrandName.text = unboxingVideoData.brandName
        cell.lblShoeName.text = unboxingVideoData.productName
        cell.lblPrice.text = "\("$")\(unboxingVideoData.productPrice ?? "00")"

        if let avgRating = unboxingVideoData.averageRating {
        cell.vwStarRating.rating = Double(Float(avgRating)!)
        }
        else {

        }

        cell.btnVideoPlayClicked.tag = indexPath.row
        cell.btnVideoPlayClicked .addTarget(self, action: #selector(btnVideoPlayClicked), for:.touchUpInside)

        return cell
    }
    
    
}


//MARK:- Button Video Play Clicked
extension UnBoxingVideoVC{
    @objc func btnVideoPlayClicked(sender: UIButton){
        
        videoURL =  URL(string:"\(strBaseUrl!)\(arrUnboxingResult[sender.tag].unboxingVideo!)")
        print(videoURL!)
        let player = AVPlayer(url: videoURL)
        let vc = AVPlayerViewController()
        vc.player = player
        present(vc, animated: true) {
            vc.player?.play()
        }
    }
    
}

