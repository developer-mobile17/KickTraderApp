//
//  SellerProductColorVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 11/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit
import IGColorPicker

class SellerProductColorVC: UIViewController {
    
    @IBOutlet weak var selectedColorView: UIView!
    @IBOutlet weak var colorPickerView: ColorPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup selectedColorView
        selectedColorView.layer.cornerRadius = selectedColorView.frame.width/2
        
        // Setup colorPickerView
        colorPickerView.delegate = self
        colorPickerView.layoutDelegate = self
        colorPickerView.style = .circle
        colorPickerView.selectionStyle = .check
        colorPickerView.isSelectedColorTappable = false
        colorPickerView.preselectedIndex = colorPickerView.colors.indices.first
        
        selectedColorView.backgroundColor = colorPickerView.colors.first
        // Do any additional setup after loading the view.
    }
    

}

extension SellerProductColorVC : ColorPickerViewDelegate,ColorPickerViewDelegateFlowLayout {
    // MARK: - ColorPickerViewDelegate
    
    func colorPickerView(_ colorPickerView: ColorPickerView, didSelectItemAt indexPath: IndexPath) {
        self.selectedColorView.backgroundColor = colorPickerView.colors[indexPath.item]
        print(self.selectedColorView.backgroundColor as Any)
    }
    
    // MARK: - ColorPickerViewDelegateFlowLayout
    
    func colorPickerView(_ colorPickerView: ColorPickerView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 48, height: 48)
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 11
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
}
