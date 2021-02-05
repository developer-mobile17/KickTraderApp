//
//  AddShippingAddressVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 30/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit
import GooglePlaces

class AddShippingAddressVC: UIViewController {

    @IBOutlet var txfFullname: UITextField!
    @IBOutlet var txfPhoneNumber: UITextField!
    
    @IBOutlet var txfZipCode: UITextField!
    @IBOutlet var txfAddress: UITextField!
    @IBOutlet var txfCity: UITextField!
    @IBOutlet var txfState: UITextField!
    
    
    var defaultsAddress = UserDefaults.standard
    var arrAddressPass = [Address]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // overrideUserInterfaceStyle is available with iOS 13
            if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }
        
        
        GMSPlacesClient.provideAPIKey("AIzaSyADyDKWRpepDv2l00WJ4EVvEFmS3IlzPVc")
    }
    
    @IBAction func actionBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionZipCode(_ sender: Any) {
        
//        let autocompleteController = GMSAutocompleteViewController()
//            autocompleteController.delegate = self
//
//            // Specify the place data types to return.
//            let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
//              UInt(GMSPlaceField.placeID.rawValue))!
//            autocompleteController.placeFields = fields
//
//            // Specify a filter.
//            let filter = GMSAutocompleteFilter()
//            filter.type = .address
//            autocompleteController.autocompleteFilter = filter
//
//            // Display the autocomplete view controller.
//            present(autocompleteController, animated: true, completion: nil)
    }
    
    
    
    @IBAction func actionAddNewAddress(_ sender: Any) {
        self.callingAddNewShippingAddressAPI()
    }
}

//TODO:- Add New  Shipping Address API
extension AddShippingAddressVC {
    func callingAddNewShippingAddressAPI() {
        
        ProgressHUD.show("Please wait.",  interaction: false)
        let strBuyRef = defaultsAddress.value(forKey:"DefaultsbuyerRef")
        guard let fullname = txfFullname.text else {return}
        guard let phoneNumber = txfPhoneNumber.text else {return}
        guard let zipCode = txfZipCode.text else {return}
        guard let address = txfAddress.text else {return}
        guard let city = txfCity.text else {return}
        guard let state = txfState.text else {return}
        
        

        let addShippingAddressParam = addShippingAddressModel(buyerRef:strBuyRef as! String, deliveredTo: fullname, mobile: phoneNumber, address: address, city: city, state: state, pin: zipCode)
       
        BuyerAPIManager.shareInstance.addNewShippingAddressAPI(addShippingAddressParam: addShippingAddressParam) { (result) in
            
            
            switch result {
            case.success(let json):
                print(json!)
                ProgressHUD.dismiss()
              //  let msg = (json as! addShippingAddressModelReponse).msg
                self.navigationController?.popViewController(animated: true)
                
               // print(msg!)
                
            case.failure(let err):
                ProgressHUD.dismiss()
                print(err.localizedDescription)
            }
            
        }
        
    }
  
}

