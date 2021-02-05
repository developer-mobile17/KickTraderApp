//
//  ChangePassword.swift
//  KickTradersApp
//
//  Created by anil kumar on 22/01/21.
//  Copyright © 2021 VikasSIngh. All rights reserved.
//

import UIKit

class ChangePassword: UIViewController {

    @IBOutlet var txfOldPassword: UITextField!
    @IBOutlet var txfNewPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // overrideUserInterfaceStyle is available with iOS 13
            if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }


    }
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionResetPassword(_ sender: Any) {
        self.changePassword_API()
    }
    
}

extension ChangePassword {
    func changePassword_API() {

        guard let oldPassword = txfOldPassword.text else {return}
        guard let newPassword = txfNewPassword.text else {return}

        let changePassParam = changePasswordRequest(userRef:UserDefaults.standard.value(forKey: "DefaultsbuyerRef") as! String , oldPass: oldPassword, newPass: newPassword)
        APIManger.shareInstance.callingChangePassword_API(changePasswordParam: changePassParam) { (result) in

            switch result {
            case.success(let json):
                print(json!)
                ProgressHUD.dismiss()
                if let msg = (json as! changePasswordResponse).msg{
                    self.showAlert(alertMessage:msg)
                print(msg)
                }

            case.failure(let err):
                ProgressHUD.dismiss()
                print(err.localizedDescription)
            }

        }


    }
}


