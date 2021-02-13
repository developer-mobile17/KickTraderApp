//
//  AddShippingAddressVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 30/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit
import CoreLocation

class AddShippingAddressVC: UIViewController {

    @IBOutlet var txfFullname: UITextField!
    @IBOutlet var txfPhoneNumber: UITextField!
    
    @IBOutlet var txfZipCode: UITextField!
    @IBOutlet var txfAddress: UITextField!
    @IBOutlet var txfCity: UITextField!
    @IBOutlet var txfState: UITextField!
    var getCity:String?
    var getState:String?
    var checkNewAddress:String?
    
    
    var defaultsAddress = UserDefaults.standard
    var arrAddressPass = [Address]()
    
    override func viewDidLoad() {
        super.viewDidLoad()


        // overrideUserInterfaceStyle is available with iOS 13
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }

        txfZipCode.addTarget(self,
                             action : #selector(textFieldDidChange),
                             for : .editingDidEnd)
        

        if checkNewAddress == "newAddress" {

        }
        else {
            self.getEditAddressData()
        }



    }

    @objc func textFieldDidChange()
    {
        self.GetCityNameUsingZip()
    }
    
    @IBAction func actionBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    


    @IBAction func actionAddNewAddress(_ sender: Any) {
        if txfFullname.text == "" || txfPhoneNumber.text == "" || txfZipCode.text == "" || txfAddress.text == "" || txfCity.text == "" || txfState.text == ""
        {
            showAlert(alertMessage: "All fields are required!")
        }
        else {
            self.callingAddNewShippingAddressAPI()
        }


    }


    func getEditAddressData() {
        //Fetching Data using UserDefaults
        if let addressListData = UserDefaults.standard.value(forKey:"editAddresList") as? Data
        {
            let retrieveObject = try? PropertyListDecoder().decode(Address.self, from: addressListData)

            txfFullname.text = retrieveObject?.deliveredTo
            txfPhoneNumber.text = retrieveObject?.mobile
            txfZipCode.text = retrieveObject?.pin
            txfAddress.text = retrieveObject?.address
            txfCity.text = retrieveObject?.city
            txfState.text = retrieveObject?.state

        }


    }

    func GetCityNameUsingZip() {
        let location: String = txfZipCode.text ?? ""
        let geocoder: CLGeocoder = CLGeocoder()
        geocoder.geocodeAddressString(location, completionHandler: {(placemarks: [CLPlacemark]?, error: Error?) -> Void in

            guard placemarks?.count == 0 else{return}
            if ((placemarks?.count)! > 0) {
                let placemark: CLPlacemark = (placemarks?[0])!
                let placeMarkcity : String = placemark.locality ?? ""
                let placeMarkstate: String = placemark.administrativeArea ?? ""

                self.txfCity.text = placeMarkcity
                self.txfState.text = placeMarkstate

            }
        } )
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

                self.navigationController?.popViewController(animated: true)
                
               // print(msg!)
                
            case.failure(let err):
                ProgressHUD.dismiss()
                print(err.localizedDescription)
            }
            
        }
        
    }
  
}

