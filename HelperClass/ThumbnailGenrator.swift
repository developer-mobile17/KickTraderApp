//
//  ThumbnailGenrator.swift
//  KickTradersApp
//
//  Created by anil kumar on 29/12/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit


extension AVAsset {

    func generateThumbnail(completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            let imageGenerator = AVAssetImageGenerator(asset: self)
            let time = CMTime(seconds: 0.0, preferredTimescale: 600)
            let times = [NSValue(time: time)]
            imageGenerator.generateCGImagesAsynchronously(forTimes: times, completionHandler: { _, image, _, _, _ in
                if let image = image {
                    completion(UIImage(cgImage: image))
                } else {
                    completion(nil)
                }
            })
        }
    }
}



extension UIView {
    static let loadingViewTag = 1938123987
    func showLoading(style: UIActivityIndicatorView.Style = .gray, color: UIColor? = nil, scale: CGFloat = 1) {
        var loading = viewWithTag(UIView.loadingViewTag) as? UIActivityIndicatorView
        if loading == nil {
            loading = UIActivityIndicatorView(style: style)
        }
      //  loading?.scale(value: scale)
        if let color = color {
            loading?.color = color
        }
        loading?.translatesAutoresizingMaskIntoConstraints = false
        loading!.startAnimating()
        loading!.hidesWhenStopped = true
        loading?.tag = UIView.loadingViewTag
        addSubview(loading!)
        loading?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loading?.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    func stopLoading() {
        let loading = viewWithTag(UIView.loadingViewTag) as? UIActivityIndicatorView
        loading?.stopAnimating()
        loading?.removeFromSuperview()
    }
}
