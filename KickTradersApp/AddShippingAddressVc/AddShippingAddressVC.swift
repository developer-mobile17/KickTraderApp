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
    @IBOutlet var btnZipCode: UIButton!
    @IBOutlet var txfAddress: UITextField!
    @IBOutlet var txfCity: UITextField!
    @IBOutlet var txfState: UITextField!
    
    
    var defaultsAddress = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
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
       // guard let zipCode = txfFullname.text else {return}
        guard let address = txfAddress.text else {return}
        guard let city = txfCity.text else {return}
        guard let state = txfState.text else {return}
        
        
        
     
        let addShippingAddressParam = addShippingAddressModel(buyerRef:strBuyRef as! String, deliveredTo: fullname, mobile: phoneNumber, address: address, city: city, state: state, pin: "140603")
       
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













//extension AddShippingAddressVC: GMSAutocompleteViewControllerDelegate {
//
//  // Handle the user's selection.
//  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
//    print("Place name: \(place.name)")
//    print("Place ID: \(place.placeID)")
//    print("Place attributions: \(place.attributions)")
//    dismiss(animated: true, completion: nil)
//  }
//
//  func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
//    // TODO: handle the error.
//    print("Error: ", error.localizedDescription)
//  }
//
//  // User canceled the operation.
//  func wasCancelled(_ viewController: GMSAutocompleteViewController) {
//    dismiss(animated: true, completion: nil)
//  }
//
//  // Turn the network activity indicator on and off again.
//  func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
//    UIApplication.shared.isNetworkActivityIndicatorVisible = true
//  }
//
//  func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
//    UIApplication.shared.isNetworkActivityIndicatorVisible = false
//  }
//
//}
