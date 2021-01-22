//
//  APIManger.swift
//  KickTradersApp
//
//  Created by anil kumar on 12/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation
import Alamofire

enum APIError: Error {
    case custom(message:String)
}
typealias Handler = (Swift.Result<Any?, APIError>) -> Void

class APIManger {
    static let shareInstance = APIManger()
    
    
    
    //MARK: Login API
    
    func callingLoginAPI(loginCheck:loginModel ,completionHandler : @escaping Handler) {
        
    AF.request(login_url,
               method: .post,
               parameters: loginCheck,
               encoder: URLEncodedFormParameterEncoder.default,
               headers: nil).response {
               response in
            
                switch response.result{
                case .success(let data):
                    do {
                        
                        let jsonDecoder = JSONDecoder()
                        let responseModel = try jsonDecoder.decode(loginModelResponse.self, from: data!)
                        print(responseModel)
                        
                        if response.response?.statusCode == 200{
                            completionHandler(.success(responseModel))
                            print("Success Go to Home UI")
                        }
                        else{
                            ProgressHUD.dismiss()
                            print("There is an issue with login API, Please check!")
                        }
                        
                    } catch  {
                        ProgressHUD.dismiss()
                        print(error.localizedDescription)
                    }
                    
                case .failure(let err):
                    print(err.localizedDescription)
                }
            
        }
    }
    
    
    //MARK:- Seller SignUP API
    
    func callingSellerSignUpAPI(sellerSignUp:sellerSignUpModel ,completionHandler : @escaping Handler) {
        
    AF.request(sellerSignUp_url,
               method: .post,
               parameters: sellerSignUp,
               encoder: URLEncodedFormParameterEncoder.default,
               headers: nil).response {
               response in
            
                switch response.result{
                case .success(let data):
                    do {
                        
                        let json = try JSONSerialization.jsonObject(with: data!, options: [])
                        print(json)
                        
                        
                        let jsonDecoder = JSONDecoder()
                        let responseModel = try jsonDecoder.decode(sellerSignUpResponse.self, from: data!)
                        print(responseModel)

                        if response.response?.statusCode == 200{
                            completionHandler(.success(responseModel))
                            print("Success Go to Home UI")
                        }
                        else{
                            print("There is an issue with login API, Please check!")
                        }
                        
                    } catch  {
                        print(error.localizedDescription)
                    }
                    
                case .failure(let err):
                    print(err.localizedDescription)
                }
            
        }
    }
    
    
    
    
    //MARK:- Seller SignUp Verification API
    
    func callingSellerSignUpVerficationAPI(sellerSignUpVerfication:SellerSignUpVerfication ,completionHandler : @escaping Handler) {
        
    AF.request(sellerSignUpVerifcation_url,
               method: .post,
               parameters: sellerSignUpVerfication,
               encoder: URLEncodedFormParameterEncoder.default,
               headers: nil).response {
               response in
            
                switch response.result{
                case .success(let data):
                    do {
                        
                        
                        let jsonDecoder = JSONDecoder()
                        let responseModel = try jsonDecoder.decode(SellerSignUpVerficationResponse.self, from: data!)
                        print(responseModel)
                        
                        if response.response?.statusCode == 200{
                            completionHandler(.success(responseModel))
                            print("Success Go to Home UI")
                        }
                        else{
                            print("There is an issue with login API, Please check!")
                        }
                        
                    } catch  {
                        print(error.localizedDescription)
                    }
                    
                case .failure(let err):
                    print(err.localizedDescription)
                }
            
        }
    }
    
    //MARK:- Seller Get OTP  API // Forget API
    func callingSellerGetOtpAPI(getOtp:sellerGetOtp ,completionHandler : @escaping Handler) {
        
    AF.request(sellerGetOtp_url,
               method: .post,
               parameters: getOtp,
               encoder: URLEncodedFormParameterEncoder.default,
               headers: nil).response {
               response in
            
                switch response.result{
                case .success(let data):
                    do {
                        
                        let json = try JSONSerialization.jsonObject(with: data!, options: [])
                        print(json)
                        
                        let jsonDecoder = JSONDecoder()
                        let responseModel = try jsonDecoder.decode(sellerGetOtpResponse.self, from: data!)
                        print(responseModel)
                        
                        if response.response?.statusCode == 200{
                            completionHandler(.success(responseModel))
                            print("Success Forget API Calling")
                        }
                        else{
                            print("There is an issue with login API, Please check!")
                        }
                        
                    } catch  {
                        print(error.localizedDescription)
                    }
                    
                case .failure(let err):
                    print(err.localizedDescription)
                }
            
        }
    }
    
    
    
    
    //MARK:- Forget Password API

    func callingForgetPassAPI(forgetParam:ForgetPasswordModel ,completionHandler : @escaping Handler) {
        
        AF.request(forgerPassword_url,
                   method: .post,
                   parameters:forgetParam,
                   encoder: URLEncodedFormParameterEncoder.default,
                   headers: nil).response {
                    response in
                    
                    switch response.result{
                    case .success(let data):
                        do {
                            
                            
                            let json = try JSONSerialization.jsonObject(with: data!, options: [])
                            print(json)
                            
                            
                            let jsonDecoder = JSONDecoder()
                            let responseModel = try jsonDecoder.decode(ForgetPasswordModelResponse.self, from: data!)
                            print(responseModel)
                            
                            if response.response?.statusCode == 200{
                                completionHandler(.success(responseModel))
                                print("Success Go ForgetPass UI")
                            }
                            else{
                                print("There is an issue with ForgetPass API, Please check!")
                            }
                            
                        } catch  {
                            print(error.localizedDescription)
                        }
                        
                    case .failure(let err):
                        print(err.localizedDescription)
                    }
                    
                   }
    }
    
    
    
    
    
    
    
    
    //MARK:- Reset Password API

    func callingResetAPI(resetPasswordParam:resetPasswordModel ,completionHandler : @escaping Handler) {
        
        AF.request(CreateNewPassword_url,
                   method: .post,
                   parameters:resetPasswordParam,
                   encoder: URLEncodedFormParameterEncoder.default,
                   headers: nil).response {
                    response in
                    
                    switch response.result{
                    case .success(let data):
                        do {
                            
//                            
//                            let json = try JSONSerialization.jsonObject(with: data!, options: [])
//                            print(json)
//                            
//                            
                            let jsonDecoder = JSONDecoder()
                            let responseModel = try jsonDecoder.decode(resetPasswordModelResponse.self, from: data!)
                            print(responseModel)
                            
                            if response.response?.statusCode == 200{
                                completionHandler(.success(responseModel))
                                print("Success Go Login UI")
                            }
                            else{
                                print("There is an issue with reset Password API, Please check!")
                            }
                            
                        } catch  {
                            print(error.localizedDescription)
                        }
                        
                    case .failure(let err):
                        print(err.localizedDescription)
                    }
                    
                   }
    }
    
    




    //MARK:- Change Password API

    func callingChangePassword_API(changePasswordParam:changePasswordRequest ,completionHandler : @escaping Handler) {

        AF.request(ChangePassword_url,
                   method: .post,
                   parameters:changePasswordParam,
                   encoder: URLEncodedFormParameterEncoder.default,
                   headers: nil).response {
                    response in

                    switch response.result{
                    case .success(let data):
                        do {
                        let jsonDecoder = JSONDecoder()
                            let responseModel = try jsonDecoder.decode(changePasswordResponse.self, from: data!)
                            print(responseModel)

                            if response.response?.statusCode == 200{
                                completionHandler(.success(responseModel))
                                print("Success Change password API")
                            }
                            else{
                                print("There is an issue withChange password API, Please check!")
                            }

                        } catch  {
                            print(error.localizedDescription)
                        }

                    case .failure(let err):
                        print(err.localizedDescription)
                    }

                   }
    }






    
    //MARK:- Seller GetDrop Down Category API
    
    func callingGetAllDropdownListAPI(completionHandler : @escaping Handler) {
        
        AF.request(getAllDropdownList_url,
                   method: .get,
                   parameters: nil,
                   headers:nil ).response
                   { response in
            
                switch response.result{
                case .success(let data):
                    do {
                        
                        let jsonDecoder = JSONDecoder()
                        let responseAddProModel = try jsonDecoder.decode(Welcome.self, from: data!)
                        print(responseAddProModel)
                        
                        if response.response?.statusCode == 200{
                            completionHandler(.success(responseAddProModel))
                            print("Success Go to AddProduct UI")
                        }
                        else{
                            ProgressHUD.dismiss()
                            print("There is an issue with login API, Please check!")
                        }
                        
                    } catch  {
                        ProgressHUD.dismiss()
                        print(error.localizedDescription)
                    }
                    
                case .failure(let err):
                    ProgressHUD.dismiss()
                    print(err.localizedDescription)
                }
            
        }
    }
    
    
    //MARK:- Seller get Seller Products API
    
    func callinggetProductAPI(sellerProduct:getSellerProducts ,completionHandler : @escaping Handler) {
        
    AF.request(getSellerProduct_url,
               method: .post,
               parameters: sellerProduct,
               encoder: URLEncodedFormParameterEncoder.default,
               headers: nil).response {
               response in
            
                switch response.result{
                case .success(let data):
                    do {
                        
//                        let json = try JSONSerialization.jsonObject(with: data!, options: [])
//                        print(json)
                        
                        
                        let jsonDecoder = JSONDecoder()
                        let responseModel = try jsonDecoder.decode(ResponsegetSellerProducts.self, from: data!)
                        print(responseModel)

                        if response.response?.statusCode == 200{
                            completionHandler(.success(responseModel))
                            print("Success Go to Home UI")
                        }
                        else{
                            print("There is an issue with login API, Please check!")
                        }
                        
                    } catch  {
                        print(error.localizedDescription)
                    }
                    
                case .failure(let err):
                    print(err.localizedDescription)
                }
            
        }
    }
    
    
    
    
    
    
    
    //MARK:- Seller Order Product API
    
    func callingSellerOrderProductAPI(sellerorderProduct:SellerOrderModel ,completionHandler : @escaping Handler) {
        
    AF.request(SellerOrderProduct_url,
               method: .post,
               parameters: sellerorderProduct,
               encoder: URLEncodedFormParameterEncoder.default,
               headers: nil).response {
               response in
            
                switch response.result{
                case .success(let data):
                    do {
                        
//                        let json = try JSONSerialization.jsonObject(with: data!, options: [])
//                        print(json)
                        
                        
                        let jsonDecoder = JSONDecoder()
                        let responseModel = try jsonDecoder.decode(ResponseSellerOrderModel.self, from: data!)
                        print(responseModel)

                        if response.response?.statusCode == 200{
                            completionHandler(.success(responseModel))
                            print("Success Go to Home UI")
                        }
                        else{
                            print("There is an issue with login API, Please check!")
                        }
                        
                    } catch  {
                        print(error.localizedDescription)
                    }
                    
                case .failure(let err):
                    print(err.localizedDescription)
                }
            
        }
    }
    
    
    
    
    //MARK:- Seller Add Products API
    
    func callingSellerAddProductAPI(sellerAddProduct:SellerAddProductModel ,completionHandler : @escaping Handler) {
        
    AF.request(SellerAddProduect_url,
               method: .post,
               parameters: sellerAddProduct,
               encoder: URLEncodedFormParameterEncoder.default,
               headers: nil).response {
               response in
            
                switch response.result{
                case .success(let data):
                    do {
               
                        let jsonDecoder = JSONDecoder()
                        let responseModel = try jsonDecoder.decode(SellerResponseAddProduct.self, from: data!)
                        print(responseModel)

                        if response.response?.statusCode == 200{
                            completionHandler(.success(responseModel))
                            print("Success Go to Home UI")
                        }
                        else{
                            print("There is an issue with login API, Please check!")
                        }
                        
                    } catch  {
                        print(error.localizedDescription)
                    }
                    
                case .failure(let err):
                    print(err.localizedDescription)
                }
            
        }
    }
    
    
    
    
    
    
    //MARK:- Seller Add Products Color API
    
    func callingSellerAddColorProductAPI(sellerAddColorProductParam:SellerAddColorProductModel ,completionHandler : @escaping Handler) {
        
    AF.request(SellerAddProduectColor_url,
               method: .post,
               parameters: sellerAddColorProductParam,
               encoder: URLEncodedFormParameterEncoder.default,
               headers: nil).response {
               response in
            
                switch response.result{
                case .success(let data):
                    do {
               
                        let jsonDecoder = JSONDecoder()
                        let responseModel = try jsonDecoder.decode(SellerAddColorProductModelResponse.self, from: data!)
                        print(responseModel)

                        if response.response?.statusCode == 200{
                            completionHandler(.success(responseModel))
                            print("Success Add color product")
                        }
                        else{
                            print("There is an issue with SellerAddProduectColor_url API, Please check!")
                        }
                        
                    } catch  {
                        print(error.localizedDescription)
                    }
                    
                case .failure(let err):
                    print(err.localizedDescription)
                }
            
        }
    }
    
    
    
    
    
    
    
    
    //MARK:- Seller Remove Color API
    
    func callingRemoveColorAPI(SellerRemoveColorParam:SellerRemoveColorModel ,completionHandler : @escaping Handler) {
        
    AF.request(SellerRemoveColor_url,
               method: .post,
               parameters: SellerRemoveColorParam,
               encoder: URLEncodedFormParameterEncoder.default,
               headers: nil).response {
               response in
            
                switch response.result{
                case .success(let data):
                    do {
               
                        let jsonDecoder = JSONDecoder()
                        let responseModel = try jsonDecoder.decode(SellerRemoveColorModelResponse.self, from: data!)
                        print(responseModel)

                        if response.response?.statusCode == 200{
                            completionHandler(.success(responseModel))
                            print("SuccessSeller Remove Color API")
                        }
                        else{
                            print("There is an issue with Seller Remove Color API, Please check!")
                        }
                        
                    } catch  {
                        print(error.localizedDescription)
                    }
                    
                case .failure(let err):
                    print(err.localizedDescription)
                }
            
        }
    }
    
    
    
    
    
    
    
    //MARK:- Seller Get BID's API
    
    func callingSellergetBidsAPI(sellerGetBidsParam:sellerGetBidsModel ,completionHandler : @escaping Handler) {
        
    AF.request(SellerGetBids_url,
               method: .post,
               parameters: sellerGetBidsParam,
               encoder: URLEncodedFormParameterEncoder.default,
               headers: nil).response {
               response in
            
                switch response.result{
                case .success(let data):
                    do {
               
                        let jsonDecoder = JSONDecoder()
                        let responseModel = try jsonDecoder.decode(sellerGetBidsModelResponse.self, from: data!)
                        print(responseModel)

                        if response.response?.statusCode == 200{
                            completionHandler(.success(responseModel))
                            print("Success fetch Seller Bids")
                        }
                        else{
                            print("There is an issue with seller get bids API, Please check!")
                        }
                        
                    } catch  {
                        print(error.localizedDescription)
                    }
                    
                case .failure(let err):
                    print(err.localizedDescription)
                }
            
        }
    }
    
    
    
    //MARK:- Seller Accept /  Reject BID's API
    
    func callingAcceptBidAPI(sellerAcceptRejectBidParam:sellerAcceptRejectBidModel ,completionHandler : @escaping Handler) {
        
    AF.request(SellerAcceptBids_url,
               method: .post,
               parameters: sellerAcceptRejectBidParam,
               encoder: URLEncodedFormParameterEncoder.default,
               headers: nil).response {
               response in
            
                switch response.result{
                case .success(let data):
                    do {
               
                        let jsonDecoder = JSONDecoder()
                        let responseModel = try jsonDecoder.decode(sellerAcceptRejectBidModelResponse.self, from: data!)
                        print(responseModel)

                        if response.response?.statusCode == 200{
                            completionHandler(.success(responseModel))
                            print("Success Accept /  Reject BID's API")
                        }
                        else{
                            print("There is an issue with Accept /  Reject BID's API, Please check!")
                        }
                        
                    } catch  {
                        print(error.localizedDescription)
                    }
                    
                case .failure(let err):
                    print(err.localizedDescription)
                }
            
        }
    }
    
    
    
    
    
    
    //MARK:- Get Earning of Seller API
    
    func callingGetEarningsAPI(SellerGetEarningParam:SellerGetEarningRequest ,completionHandler : @escaping Handler) {
        
    AF.request(getEarningsOfSeller_url,
               method: .post,
               parameters: SellerGetEarningParam,
               encoder: URLEncodedFormParameterEncoder.default,
               headers: nil).response {
               response in
            
                switch response.result{
                case .success(let data):
                    do {
               
                        let jsonDecoder = JSONDecoder()
                        let responseModel = try jsonDecoder.decode(SellerGetEarningResponse.self, from: data!)
                        print(responseModel)

                        if response.response?.statusCode == 200{
                            completionHandler(.success(responseModel))
                            print("Success Get Earning of Seller  API")
                        }
                        else{
                            print("There is an issue with Get Earning of Seller API, Please check!")
                        }
                        
                    } catch  {
                        print(error.localizedDescription)
                    }
                    
                case .failure(let err):
                    print(err.localizedDescription)
                }
            
        }
    }
    
    
    
    
}
