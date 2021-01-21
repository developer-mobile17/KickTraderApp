//
//  BuyerAPIManger.swift
//  KickTradersApp
//
//  Created by anil kumar on 20/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation
import Foundation
import Alamofire

enum BuyerAPIError: Error {
    case custom(message:String)
}
typealias BuyerHandler = (Swift.Result<Any?, BuyerAPIError>) -> Void

class BuyerAPIManager {
    
    static let shareInstance = BuyerAPIManager()
    
    
    
    
    
    //MARK:- Seller SignUp Verification API
    
    func callingEnterOtpAPI(EnterOtpParam:EnterOtpModel ,completionHandler : @escaping Handler) {
        
    AF.request(sellerSignUpVerifcation_url,
               method: .post,
               parameters: EnterOtpParam,
               encoder: URLEncodedFormParameterEncoder.default,
               headers: nil).response {
               response in
            
                switch response.result{
                case .success(let data):
                    do {
                        
                        
                        let jsonDecoder = JSONDecoder()
                        let responseModel = try jsonDecoder.decode(EnterOtpModelResponse.self, from: data!)
                        print(responseModel)
                        
                        if response.response?.statusCode == 200{
                            completionHandler(.success(responseModel))
                            print("Success Go to Home UI")
                        }
                        else{
                            print("There is an issue with Enter Otp API, Please check!")
                        }
                        
                    } catch  {
                        print(error.localizedDescription)
                    }
                    
                case .failure(let err):
                    print(err.localizedDescription)
                }
            
        }
    }
    
    
    //MARK:- Seller get Seller Products API
    
    func callingBuyergetProductAPI(BuyerProducts:getBuyerProducts ,completionHandler : @escaping Handler) {
        
        AF.request(getSellerProduct_url,
                   method: .post,
                   parameters: BuyerProducts,
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
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK:- Buyer Get Product Details  API
    
    func callingBuyergetProductDetailAPI(buyerProductDetails:BuyerGetProductDetailsModel ,completionHandler : @escaping Handler) {
        
        AF.request(buyergetProductDetailByRef_url,
                   method: .post,
                   parameters: buyerProductDetails,
                   encoder: URLEncodedFormParameterEncoder.default,
                   headers: nil).response {
                    response in
                    
                    switch response.result{
                    case .success(let data):
                        do {
                            
                            
                            let json = try JSONSerialization.jsonObject(with: data!, options: [])
                            print(json)
                            
                            
                            let jsonDecoder = JSONDecoder()
                            let responseModel = try jsonDecoder.decode(BuyerGetProductDetailsModelResponse.self, from: data!)
                            print(responseModel.productInfo?.sellerDetail! as Any)
                            
                            if response.response?.statusCode == 200{
                                completionHandler(.success(responseModel))
                                print("Success Buyer Get Product Details")
                            }
                            else{
                                print("There is an issue with Buyer Get Product Details API, Please check!")
                            }
                            
                        } catch  {
                            print(error.localizedDescription)
                        }
                        
                    case .failure(let err):
                        print(err.localizedDescription)
                    }
                    
                   }
    }
    
    
    
    //TODO:- getCart Item Product list API
    
    func callinggetCartItemAPI(getCartItemparam:getCartItemModel ,completionHandler : @escaping Handler) {
        
        AF.request(buyerGetCartItem_url,
                   method: .post,
                   parameters: getCartItemparam,
                   encoder: URLEncodedFormParameterEncoder.default,
                   headers: nil).response {
                    response in
                    
                    switch response.result{
                    case .success(let data):
                        do {
                            
                            //                        let json = try JSONSerialization.jsonObject(with: data!, options: [])
                            //                        print(json)
                            //
                            
                            let jsonDecoder = JSONDecoder()
                            let responseModel = try jsonDecoder.decode(getCartModelResponse.self, from: data!)
                            print(responseModel)
                            
                            if response.response?.statusCode == 200{
                                completionHandler(.success(responseModel))
                                print("Successfully Fetch Cart ITEMS")
                            }
                            else{
                                print("There is an issue with Cart API, Please check!")
                            }
                            
                        } catch  {
                            print(error.localizedDescription)
                        }
                        
                    case .failure(let err):
                        print(err.localizedDescription)
                    }
                    
                   }
    }
    
    
    
    
    
    
    
    //TODO:- Add to Cart Item Product list API
    
    func callingAddItemToCartAPI(addItemToCartParam:addToCartModel ,completionHandler : @escaping Handler) {
        
        AF.request(buyerAddItemToCart_url,
                   method: .post,
                   parameters: addItemToCartParam,
                   encoder: URLEncodedFormParameterEncoder.default,
                   headers: nil).response {
                    response in
                    
                    switch response.result{
                    case .success(let data):
                        do {
                            
                            let json = try JSONSerialization.jsonObject(with: data!, options: [])
                            print(json)
                            
                            
                            let jsonDecoder = JSONDecoder()
                            let responseModel = try jsonDecoder.decode(addToCartModelResponse.self, from: data!)
                            print(responseModel)
                            
                            if response.response?.statusCode == 200{
                                completionHandler(.success(responseModel))
                                print("Successfully, Item Added to Cart")
                            }
                            else{
                                print("There is an issue with Added to Cart  API, Please check!")
                            }
                            
                        } catch  {
                            print(error.localizedDescription)
                        }
                        
                    case .failure(let err):
                        print(err.localizedDescription)
                    }
                    
                   }
    }
    
    
    
    
    
    
    //TODO:- remove Cart Item Product list API
    
    func callingRemoveCartItemAPI(removeCartItemparam:removeCartItemModel ,completionHandler : @escaping Handler) {
        
        AF.request(buyerRemoveCartItem_url,
                   method: .post,
                   parameters: removeCartItemparam,
                   encoder: URLEncodedFormParameterEncoder.default,
                   headers: nil).response {
                    response in
                    
                    switch response.result{
                    case .success(let data):
                        do {
                            
                            //                        let json = try JSONSerialization.jsonObject(with: data!, options: [])
                            //                        print(json)
                            //
                            
                            let jsonDecoder = JSONDecoder()
                            let responseModel = try jsonDecoder.decode(removeCartItemResponse.self, from: data!)
                            print(responseModel)
                            
                            if response.response?.statusCode == 200{
                                completionHandler(.success(responseModel))
                                print("Successfully Remove Cart ITEMS")
                            }
                            else{
                                print("There is an issue with Remove Cart API, Please check!")
                            }
                            
                        } catch  {
                            print(error.localizedDescription)
                        }
                        
                    case .failure(let err):
                        print(err.localizedDescription)
                    }
                    
                   }
    }
    
    
    
    
    
    
    
    
    
    //TODO:- Get User Info list API
    
    func callingGetUserInfoAPI(getUserInfoParam:getUserInfoModel ,completionHandler : @escaping Handler) {
        
        AF.request(GetUserInfo_url,
                   method: .post,
                   parameters: getUserInfoParam,
                   encoder: URLEncodedFormParameterEncoder.default,
                   headers: nil).response {
                    response in
                    
                    switch response.result{
                    case .success(let data):
                        do {
                            
                            let json = try JSONSerialization.jsonObject(with: data!, options: [])
                            print(json)
                            //
                            
                            let jsonDecoder = JSONDecoder()
                            let responseModel = try jsonDecoder.decode(getUserInfoModelResponse.self, from: data!)
                            print(responseModel)
                            
                            if response.response?.statusCode == 200{
                                completionHandler(.success(responseModel))
                                print("Successfully Fetch User info")
                            }
                            else{
                                ProgressHUD.dismiss()
                                print("There is an issue with Fetch User info API, Please check!")
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
    
    
    
    
    
    //TODO:- PlaceABid  API
    
    func callingPlaceABidAPI(PlaceABidParam:PlaceABidModel ,completionHandler : @escaping Handler) {
        
        
        AF.request(buyerPlaceABid_url,
                   method: .post,
                   parameters: PlaceABidParam,
                   encoder: URLEncodedFormParameterEncoder.default,
                   headers: nil).response {
                    response in
                    
                    switch response.result{
                    case .success(let data):
                        do {
                            
                            //                        let json = try JSONSerialization.jsonObject(with: data!, options: [])
                            //                        print(json)
                            
                            
                            let jsonDecoder = JSONDecoder()
                            let responseModel = try jsonDecoder.decode(PlaceABidModelResponse.self, from: data!)
                            print(responseModel)
                            
                            if response.response?.statusCode == 200{
                                completionHandler(.success(responseModel))
                                print("Successfully Place Bid")
                            }
                            else{
                                
                                ProgressHUD.dismiss()
                                print("There is an issue with Place Bid API, Please check!")
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
    
    
    
    
    
    
    //TODO:- placeBidInToCart  API
    
    func callingplaceBidInToCartAPI(placeABidInToCartParam:placeABidInToCartModel ,completionHandler : @escaping Handler) {
        
        
        AF.request(PlaceABidInToCart_url,
                   method: .post,
                   parameters: placeABidInToCartParam,
                   encoder: URLEncodedFormParameterEncoder.default,
                   headers: nil).response {
                    response in
                    
                    switch response.result{
                    case .success(let data):
                        do {
                            
                            //                        let json = try JSONSerialization.jsonObject(with: data!, options: [])
                            //                        print(json)
                            
                            
                            let jsonDecoder = JSONDecoder()
                            let responseModel = try jsonDecoder.decode(placeABidInToCartModelResponse.self, from: data!)
                            print(responseModel)
                            
                            if response.response?.statusCode == 200{
                                completionHandler(.success(responseModel))
                                print("Successfully Place Bid for Cart Item")
                            }
                            else{
                                
                                ProgressHUD.dismiss()
                                print("There is an issue with Place Bid API, Please check!")
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
    
    //TODO:- Buy Product  API
    
    func callingBuyProductAPI(buyProductPara:buyProductModel ,completionHandler : @escaping Handler) {
        
        
        AF.request(buyProduct_url,
                   method: .post,
                   parameters: buyProductPara,
                   encoder: URLEncodedFormParameterEncoder.default,
                   headers: nil).response {
                    response in
                    
                    switch response.result{
                    case .success(let data):
                        do {
                            
                            //                        let json = try JSONSerialization.jsonObject(with: data!, options: [])
                            //                        print(json)
                            
                            
                            let jsonDecoder = JSONDecoder()
                            let responseModel = try jsonDecoder.decode(buyProductModelResponse.self, from: data!)
                            print(responseModel)
                            
                            if response.response?.statusCode == 200{
                                completionHandler(.success(responseModel))
                                print("Successfully Place Bid for Cart Item")
                            }
                            else{
                                
                                ProgressHUD.dismiss()
                                print("There is an issue with Place Bid API, Please check!")
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
    
    
    
    
    
    
    
    //TODO:- Shipping Address  API's
    
    
    //TODO:- fetching Shipping Address API
    
    func fetchingShippingAddressAPI(fetchingShippingAddrssParam:fetchingShippingAddrssModel ,completionHandler : @escaping Handler) {
        
        
        AF.request(ftechShipingAddress_url,
                   method: .post,
                   parameters: fetchingShippingAddrssParam,
                   encoder: URLEncodedFormParameterEncoder.default,
                   headers: nil).response {
                    response in
                    
                    switch response.result{
                    case .success(let data):
                        do {
                            
                            //                        let json = try JSONSerialization.jsonObject(with: data!, options: [])
                            //                        print(json)
                            
                            
                            let jsonDecoder = JSONDecoder()
                            let responseModel = try jsonDecoder.decode(fetchingShippingAddrssModelReponse.self, from: data!)
                            print(responseModel)
                            
                            if response.response?.statusCode == 200{
                                completionHandler(.success(responseModel))
                                print("Successfully Place Bid for Cart Item")
                            }
                            else{
                                
                                ProgressHUD.dismiss()
                                print("There is an issue with Place Bid API, Please check!")
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
    
    
    
    
    
    
    
    //TODO:- Add  New Shipping Address API
    
    func addNewShippingAddressAPI(addShippingAddressParam:addShippingAddressModel ,completionHandler : @escaping Handler) {
        
        
        AF.request(addShipingAddress_url,
                   method: .post,
                   parameters: addShippingAddressParam,
                   encoder: URLEncodedFormParameterEncoder.default,
                   headers: nil).response {
                    response in
                    
                    switch response.result{
                    case .success(let data):
                        do {
                            
                            //                        let json = try JSONSerialization.jsonObject(with: data!, options: [])
                            //                        print(json)
                            
                            
                            let jsonDecoder = JSONDecoder()
                            let responseModel = try jsonDecoder.decode(fetchingShippingAddrssModelReponse.self, from: data!)
                            print(responseModel)
                            
                            if response.response?.statusCode == 200{
                                completionHandler(.success(responseModel))
                                print("Successfully Added new Address")
                            }
                            else{
                                
                                ProgressHUD.dismiss()
                                print("There is an issue with Added new Address, Please check!")
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
    
    
    
    //TODO:- Remove Shipping Address API
    
    func removeNewShippingAddressAPI(removeAddressModelParam:removeAddressModel ,completionHandler : @escaping Handler) {
        
        
        AF.request(removeShipingAddress_url,
                   method: .post,
                   parameters: removeAddressModelParam,
                   encoder: URLEncodedFormParameterEncoder.default,
                   headers: nil).response {
                    response in
                    
                    switch response.result{
                    case .success(let data):
                        do {
                            
                            //                        let json = try JSONSerialization.jsonObject(with: data!, options: [])
                            //                        print(json)
                            
                            
                            let jsonDecoder = JSONDecoder()
                            let responseModel = try jsonDecoder.decode(fetchingShippingAddrssModelReponse.self, from: data!)
                            print(responseModel)
                            
                            if response.response?.statusCode == 200{
                                completionHandler(.success(responseModel))
                                print("Successfully remove New Shipping Address API")
                            }
                            else{
                                
                                ProgressHUD.dismiss()
                                print("There is an issue with remove New Shipping Address API, Please check!")
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
    
    
    
    
    
    //TODO:- get Buyer Orders API
    
    func getBuyerOrdersAPI(getBuyerOrdersParam:getBuyerOrders ,completionHandler : @escaping Handler) {
        
        
        AF.request(getBuyerOrders_url,
                   method: .post,
                   parameters: getBuyerOrdersParam,
                   encoder: URLEncodedFormParameterEncoder.default,
                   headers: nil).response {
                    response in
                    
                    switch response.result{
                    case .success(let data):
                        do {
                            
                            let jsonDecoder = JSONDecoder()
                            let responseModel = try jsonDecoder.decode(getBuyerOrdersResponse.self, from: data!)
                            print(responseModel)
                            
                            if response.response?.statusCode == 200{
                                completionHandler(.success(responseModel))
                                print("Successfully get Buyer Orders API")
                            }
                            else{
                                
                                ProgressHUD.dismiss()
                                print("There is an issue with remove get Buyer Orders API, Please check!")
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
    
    
    
    
    
    
    
    //TODO:- add Favorite API
    
    func addFavoriteAPI(addFavoriteParam:addFavoriteModel ,completionHandler : @escaping Handler) {
        
        
        AF.request(addFavoriteProductItem_url,
                   method: .post,
                   parameters: addFavoriteParam,
                   encoder: URLEncodedFormParameterEncoder.default,
                   headers: nil).response {
                    response in
                    
                    switch response.result{
                    case .success(let data):
                        do {
                            
                            let jsonDecoder = JSONDecoder()
                            let responseModel = try jsonDecoder.decode(addFavoriteModelResponse.self, from: data!)
                            print(responseModel)
                            
                            if response.response?.statusCode == 200{
                                completionHandler(.success(responseModel))
                                print("Successfully add Favorite API")
                            }
                            else{
                                
                                ProgressHUD.dismiss()
                                print("There is an issue with add Favorite API, Please check!")
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
    
    
    
    
    
    
    //TODO:- get Favorite By Buyer_url API
    
    func getFavoriteByBuyerAPI(getFavoriteByBuyerParam:getFavoriteByBuyerModel ,completionHandler : @escaping Handler) {
        
        
        AF.request(getFavoriteByBuyer_url,
                   method: .post,
                   parameters: getFavoriteByBuyerParam,
                   encoder: URLEncodedFormParameterEncoder.default,
                   headers: nil).response {
                    response in
                    
                    switch response.result{
                    case .success(let data):
                        do {
                            
                            let jsonDecoder = JSONDecoder()
                            let responseModel = try jsonDecoder.decode(getFavoriteByBuyerModelResponse.self, from: data!)
                            print(responseModel)
                            
                            if response.response?.statusCode == 200{
                                completionHandler(.success(responseModel))
                                print("Successfully get Favorite By Buyer_url API")
                            }
                            else{
                                
                                ProgressHUD.dismiss()
                                print("There is an issue with get FavoriteBy Buyer_url  API, Please check!")
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
    
    
    
    
    
    
    
    
    
    //TODO:- addReview To Buyer / Seller
    
    func addReviewAPI(addReviewParam:addReviewModel ,completionHandler : @escaping Handler) {
        
        
        AF.request(addReview_Url,
                   method: .post,
                   parameters: addReviewParam,
                   encoder: URLEncodedFormParameterEncoder.default,
                   headers: nil).response {
                    response in
                    
                    switch response.result{
                    case .success(let data):
                        do {
                            
                            let jsonDecoder = JSONDecoder()
                            let responseModel = try jsonDecoder.decode(addReviewModelResponse.self, from: data!)
                            print(responseModel)
                            
                            if response.response?.statusCode == 200{
                                completionHandler(.success(responseModel))
                                print("Successfully addReview_Url")
                            }
                            else{
                                
                                ProgressHUD.dismiss()
                                print("There is an issue with addReview_Url, Please check!")
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
        
    //TODO:- cancelOrderAPI Buyer / Seller
    
    func cancelOrderAPI(cancelOrderParam:cancelOrderModel ,completionHandler : @escaping Handler) {
        
        
        AF.request(cancelOrders_url,
                   method: .post,
                   parameters: cancelOrderParam,
                   encoder: URLEncodedFormParameterEncoder.default,
                   headers: nil).response {
                    response in
                    
                    switch response.result{
                    case .success(let data):
                        do {
                            
                            let jsonDecoder = JSONDecoder()
                            let responseModel = try jsonDecoder.decode(cancelOrderModelResponse.self, from: data!)
                            print(responseModel)
                            
                            if response.response?.statusCode == 200{
                                completionHandler(.success(responseModel))
                                print("Successfully cancel the order")
                            }
                            else{
                                
                                ProgressHUD.dismiss()
                                print("There is an issue with cancel order API, Please check!")
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
    
    
    
    
    
    //MARK:- Get UnBoxing Video API
    
    func callingGetUnboxingVideo(completionHandler : @escaping Handler) {
        
        AF.request(getUnboxingVideo_Url,
                   method: .get,
                   parameters: nil,
                   headers:nil ).response
                   { response in
            
                switch response.result{
                case .success(let data):
                    do {
                        
                        let jsonDecoder = JSONDecoder()
                        let responseAddProModel = try jsonDecoder.decode(unboxingVideoModel.self, from: data!)
                        print(responseAddProModel)
                        
                        if response.response?.statusCode == 200{
                            completionHandler(.success(responseAddProModel))
                            print("Success List of Unboxing Video UI")
                        }
                        else{
                            ProgressHUD.dismiss()
                            print("There is an issue with Unboxing Video API, Please check!")
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
    
    
    
    
    //MARK:- getNotification API
    
    func callingGetNotificationAPI(getNotificationParam:getNotificationRequestModel ,completionHandler : @escaping Handler) {
        
    AF.request(getNotification_Url,
               method: .post,
               parameters: getNotificationParam,
               encoder: URLEncodedFormParameterEncoder.default,
               headers: nil).response {
               response in
            
                switch response.result{
                case .success(let data):
                    do {
                        
                        
                        let jsonDecoder = JSONDecoder()
                        let responseModel = try jsonDecoder.decode(getNotificationResponse.self, from: data!)
                        print(responseModel)
                        
                        if response.response?.statusCode == 200{
                            completionHandler(.success(responseModel))
                            print("Successfully Fetch User Notification")
                        }
                        else{
                            print("There is an issue with Get Notification, Please check!")
                        }
                        
                    } catch  {
                        print(error.localizedDescription)
                    }
                    
                case .failure(let err):
                    print(err.localizedDescription)
                }
            
        }
    }
    
    
    
    
    
    
    //MARK:- Chat API Implementatin
    

    
    func CallingGetChatListAPI(getChatListParam:getChatListRequest ,completionHandler : @escaping Handler) {
        
    AF.request(getChatList_Url,
               method: .post,
               parameters: getChatListParam,
               encoder: URLEncodedFormParameterEncoder.default,
               headers: nil).response {
               response in
            
                switch response.result{
                case .success(let data):
                    do {
                        
                        
                        let jsonDecoder = JSONDecoder()
                        let responseModel = try jsonDecoder.decode(getChatListResponse.self, from: data!)
                        print(responseModel)
                        
                        if response.response?.statusCode == 200{
                            completionHandler(.success(responseModel))
                            print("Successfully Fetch User Chat List")
                        }
                        else{
                            print("There is an issue with Get get Chat List API, Please check!")
                        }
                        
                    } catch  {
                        print(error.localizedDescription)
                    }
                    
                case .failure(let err):
                    print(err.localizedDescription)
                }
            
        }
    }
    
    





    //MARK:- Chat API Implementatin



    func CallingGetChat_HistoryAPI(getChat_HistoryParam:ChatHistoryModelRequest ,completionHandler : @escaping Handler) {

    AF.request(getChatHistory_Url,
               method: .post,
               parameters: getChat_HistoryParam,
               encoder: URLEncodedFormParameterEncoder.default,
               headers: nil).response {
               response in

                switch response.result{
                case .success(let data):
                    do {


                        let jsonDecoder = JSONDecoder()
                        let responseModel = try jsonDecoder.decode(ChatHistoryModelResponse.self, from: data!)
                        print(responseModel)

                        if response.response?.statusCode == 200{
                            completionHandler(.success(responseModel))
                            print("Successfully Fetch User Chat History")
                        }
                        else{
                            print("There is an issue with get ChatHistory_Url API, Please check!")
                        }

                    } catch  {
                        print(error.localizedDescription)
                    }

                case .failure(let err):
                    print(err.localizedDescription)
                }

        }
    }







    //MARK:- Chat  Send Message  API Implementatin



    func CallingSendMessage_API(sendMessageParam:ChatSendMessageRequest ,completionHandler : @escaping Handler) {

    AF.request(chatSendMessage_Url,
               method: .post,
               parameters: sendMessageParam,
               encoder: URLEncodedFormParameterEncoder.default,
               headers: nil).response {
               response in

                switch response.result{
                case .success(let data):
                    do {


                        let jsonDecoder = JSONDecoder()
                        let responseModel = try jsonDecoder.decode(ChatSendMessageResponse.self, from: data!)
                        print(responseModel)

                        if response.response?.statusCode == 200{
                            completionHandler(.success(responseModel))
                            print("Successfully Send Message")
                        }
                        else{
                            print("There is an issue with get (http://hourlylancer.com/kickTraders/api/v1/sendMessage) API, Please check!")
                        }

                    } catch  {
                        print(error.localizedDescription)
                    }

                case .failure(let err):
                    print(err.localizedDescription)
                }

        }
    }









    //MARK:- Get Shipping Status  API Implementatin



    func CallingGetShippingStatus_API(getShippingStatusParam:getShippingStatusRequest ,completionHandler : @escaping Handler) {

    AF.request(getShippingStatus_Url,
               method: .post,
               parameters: getShippingStatusParam,
               encoder: URLEncodedFormParameterEncoder.default,
               headers: nil).response {
               response in

                switch response.result{
                case .success(let data):
                    do {


                        let jsonDecoder = JSONDecoder()
                        let responseModel = try jsonDecoder.decode(getShippingStatusResponse.self, from: data!)
                        print(responseModel)

                        if response.response?.statusCode == 200{
                            completionHandler(.success(responseModel))
                            print("Successfully fetch getShippingStatusRequest")
                        }
                        else{
                            print("There is an issue with get getShippingStatusRequest API, Please check!")
                        }

                    } catch  {
                        print(error.localizedDescription)
                    }

                case .failure(let err):
                    print(err.localizedDescription)
                }

        }
    }





    //MARK:- Add Dispute  API Implementatin



    func callingAddDispute_API(addDisputeParam:addDisputeRequest ,completionHandler : @escaping Handler) {

    AF.request(addDispute_Url,
               method: .post,
               parameters: addDisputeParam,
               encoder: URLEncodedFormParameterEncoder.default,
               headers: nil).response {
               response in

                switch response.result{
                case .success(let data):
                    do {


                        let jsonDecoder = JSONDecoder()
                        let responseModel = try jsonDecoder.decode(addDisputeResponse.self, from: data!)
                        print(responseModel)

                        if response.response?.statusCode == 200{
                            completionHandler(.success(responseModel))
                            print("Successfully sent Dispute")
                        }
                        else{
                            print("There is an issue with get add dispute API, Please check!")
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
