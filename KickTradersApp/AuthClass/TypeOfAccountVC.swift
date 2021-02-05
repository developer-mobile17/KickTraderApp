

import UIKit

class TypeOfAccountVC: UIViewController {

    @IBOutlet var btnBuyer: DesignableButton!
    @IBOutlet var btnSeller: DesignableButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // overrideUserInterfaceStyle is available with iOS 13
            if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }
    }
    @IBAction func actionBuyerClicked(_ sender: Any) {
        GoToBuyerSignUP()
    }
    @IBAction func actionSellerClicked(_ sender: Any) {
        GoToSellerSingUp()
    }
    
    
    @IBAction func actionAlreadyHaveAccount(_ sender: Any) {
        GoToLogin()
    }
    
    
    
}

extension TypeOfAccountVC {
    func GoToBuyerSignUP(){
        let vcSignUP = self.storyboard?.instantiateViewController(identifier: "SignupVC") as! SignupVC
        self.navigationController?.pushViewController(vcSignUP, animated: true)
        
    }
    
    
    func GoToSellerSingUp(){
        
        let sellerStoryBoard = UIStoryboard(name: "SellerStoryboard", bundle:nil)
        let  sellerStoryVC = sellerStoryBoard.instantiateViewController(identifier: "SellerSignUpVC")
        self.navigationController?.pushViewController(sellerStoryVC, animated: true)
        
        
        
    }
    
    
    
    func GoToLogin(){
        let vcLoginVC = self.storyboard?.instantiateViewController(identifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vcLoginVC, animated: true)
        
    }
    
}
