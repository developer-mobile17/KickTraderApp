//
//  AddressListVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 30/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit
class AddressListVC: UIViewController {
    
    
    @IBOutlet var objTbl: UITableView!

    var straddressRef : String = ""
    var strBuyRef: String = ""
    var strPassSelectedCartRef: String = ""

    //TODO:- This address ref is passing to Next VC for API Call
    var selectedAddressRef:String = ""
    var checkEditOrNewAddress:String?
    
    var arrShippingAddress = [Address]()
    var defulatsAddressList = UserDefaults.standard
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // overrideUserInterfaceStyle is available with iOS 13
            if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }

        self.callingFetchingShippingAddressAPI()
        
    }




    override func viewWillAppear(_ animated: Bool) {
        // overrideUserInterfaceStyle is available with iOS 13
            if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }

        self.callingFetchingShippingAddressAPI()

    }

    
    @IBAction func actionBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionAddNewAddress(_ sender: Any) {

        checkEditOrNewAddress = "newAddress"
        let vcAddressNew = self.storyboard?.instantiateViewController(identifier: "AddShippingAddressVC") as! AddShippingAddressVC

        vcAddressNew.checkNewAddress = "newAddress"
        self.navigationController?.pushViewController(vcAddressNew, animated: true)

    }
    
    
    
    @IBAction func actionOrderPlace(_ sender: Any) {
        if selectedAddressRef == "" {
            showAlert(alertMessage: "Please Select Address.")
        }
        else {
            let finalCheckOut = self.storyboard?.instantiateViewController(withIdentifier: "ProductCheckoutVC")as! ProductCheckoutVC
            finalCheckOut.strAddressCartRef = selectedAddressRef
            self.navigationController?.pushViewController(finalCheckOut, animated: true)
        }

    }


    }



//TODO:- fetching Shipping Address API
extension AddressListVC {
    func callingFetchingShippingAddressAPI() {
        
        ProgressHUD.show("Please wait.",  interaction: false)
        
        strBuyRef = defulatsAddressList.value(forKey:"DefaultsbuyerRef") as! String
     
        let fetchShippingAddressParma = fetchingShippingAddrssModel(buyerRef: strBuyRef )
       
        BuyerAPIManager.shareInstance.fetchingShippingAddressAPI(fetchingShippingAddrssParam: fetchShippingAddressParma) { [self](result) in
            
            
            switch result {
            case.success(let json):
                print(json!)
                ProgressHUD.dismiss()
                self.arrShippingAddress = (json as! fetchingShippingAddrssModelReponse).address!
                let msg = (json as! fetchingShippingAddrssModelReponse).msg
                print(msg!)
                
                self.objTbl.reloadData()
                
            case.failure(let err):
                ProgressHUD.dismiss()
                print(err.localizedDescription)
            }
            
        }
        
    }
  
}



extension AddressListVC: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        arrShippingAddress.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressListCell", for: indexPath) as! AddressListCell
        let shippingAddressData = arrShippingAddress[indexPath.row]
        cell.lblfullName.text = shippingAddressData.deliveredTo
        cell.lbladdress.text = shippingAddressData.address
        cell.lblmobile.text = shippingAddressData.mobile
        cell.lblcity.text = shippingAddressData.city
        cell.lblstate.text = shippingAddressData.state
        cell.lblZipCode.text = shippingAddressData.pin
        

        //TODO:- UIButton Action Delete
        cell.btnDelete.tag = indexPath.row
        cell.btnDelete .addTarget(self, action: #selector(removeAddressFromList), for:.touchUpInside)
        
        
        //TODO:- UIButton Action Edit Address
        cell.btnEdit.tag = indexPath.row
        cell.btnEdit .addTarget(self, action: #selector(efitAddressFromList), for:.touchUpInside)
        
        

        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        selectedAddressRef = arrShippingAddress[indexPath.row].addressRef!
        print("Selected AddressRef is : ",selectedAddressRef)


        let cell = tableView.cellForRow(at: indexPath) as! AddressListCell

        cell.toggleAddressSelected()

        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("fasdfasdfs")
        let cell = tableView.cellForRow(at: indexPath) as! AddressListCell

        cell.toggleAddressSelected()
    }
    
    
}


extension AddressListVC {
    @objc func removeAddressFromList(sender:UIButton){
        
        straddressRef = self.arrShippingAddress[sender.tag].addressRef!
        print("Here is the addressRef: ",straddressRef)
        self.callingRemoveShippingAddressAPI()
        
    }


    @objc func efitAddressFromList(sender:UIButton){

        UserDefaults.standard.set(try? PropertyListEncoder().encode(self.arrShippingAddress[sender.tag]),forKey: "editAddresList")
        let vcAddressEdit = self.storyboard?.instantiateViewController(identifier: "AddShippingAddressVC") as! AddShippingAddressVC

        vcAddressEdit.checkNewAddress = "editAddress"
        self.navigationController?.pushViewController(vcAddressEdit, animated: true)

    }



}


//TODO:- Remove  Shipping Address API
extension AddressListVC {
    func callingRemoveShippingAddressAPI() {
        
        ProgressHUD.show("Please wait.",  interaction: false)
        let removeAddressParam = removeAddressModel(addressRef: straddressRef)
        BuyerAPIManager.shareInstance.removeNewShippingAddressAPI(removeAddressModelParam: removeAddressParam) { (result) in
            
            
            switch result {
            case.success(let json):
                print(json!)
                ProgressHUD.dismiss()
                self.callingFetchingShippingAddressAPI()
    
            case.failure(let err):
                ProgressHUD.dismiss()
                print(err.localizedDescription)
            }
            
        }
        
    }
  
}



