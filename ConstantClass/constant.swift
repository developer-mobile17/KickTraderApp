//
//  constant.swift
//  KickTradersApp
//
//  Created by anil kumar on 12/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation


//TODO:- Auth API for Seller & Buyer

let base_url = "http://hourlylancer.com/kickTraders/api/v1"
let login_url = "\(base_url)/login"
let forgerPassword_url = "\(base_url)/ForgetPassword"
let sellerSignUp_url = "\(base_url)/signup"
let sellerSignUpVerifcation_url = "\(base_url)/verify"
let sellerGetOtp_url = "\(base_url)/getOTP"
let CreateNewPassword_url = "\(base_url)/CreateNewPassword"
let ChangePassword_url = "\(base_url)/changePassword"
let contactUs_url = "\(base_url)/contactUs"



//TODO:- Seller API's
let getAllDropdownList_url = "\(base_url)/getAllDropdownList"
let getSellerProduct_url = "\(base_url)/getProduct"
let SellerOrderProduct_url = "\(base_url)/getOrderList"
let SellerAddProduect_url = "\(base_url)/addProduct"
let SellerAddProduectColor_url = "\(base_url)/addColorProduct"

let SellerRemoveColor_url = "\(base_url)/removeColor"



//TODO:- Seller API's
//TODO:- Seller Bid API's

let SellerGetBids_url = "\(base_url)/getBid"
let SellerAcceptBids_url = "\(base_url)/acceptBid"

//TODO:- Seller API's
//TODO:- getCencelOrdersBySeller API's

let getCencelOrdersBySeller_url = "\(base_url)/getCencelOrdersBySeller"



//TODO:- Seller API's
//TOOD:- Seller Earning API


let getEarningsOfSeller_url = "\(base_url)/getEarnings"







//TODO:- Buyer API's
//TODO:- Product API's

let buyerGetProduct_url = "\(base_url)/getProduct"
let buyergetProductDetailByRef_url = "\(base_url)/getProductByRef"
let buyerGetCartItem_url = "\(base_url)/getCartItem"
let buyerRemoveCartItem_url = "\(base_url)/removeCartItem"
let buyerAddItemToCart_url = "\(base_url)/addToCart"
let buyerPlaceABid_url = "\(base_url)/placeBid"





//TODO:- Buyer API's
//TODO:- Cart API's


let PlaceABidInToCart_url = "\(base_url)/placeBid"
let buyProduct_url = "\(base_url)/buyProduct"



//TODO:- Buyer API's
//TODO:- More Tab API's
let getBuyerOrders_url = "\(base_url)/getBuyerOrders"
let cancelOrders_url = "\(base_url)/cancelOrders"





//TODO:- Setting UI API's

let GetUserInfo_url = "\(base_url)/GetUserInfo"
let UpdateUserInfo_url = "\(base_url)/editUser"



//TODO:- Buyer API's
//TODO:- Shipping Address API's


let addShipingAddress_url = "\(base_url)/addShipingAddress"
let ftechShipingAddress_url = "\(base_url)/ftechShipingAddress"
let editShipingAddress_url = "\(base_url)/editShipingAddress"
let removeShipingAddress_url = "\(base_url)/removeShipingAddress"





//TODO:- Buyer API's
//TODO:- Favourite API's

let addFavoriteProductItem_url = "\(base_url)/addFavorite"
let getFavoriteByBuyer_url = "\(base_url)/getFavoriteByBuyer"




//TODO:- Buyer API's
//TODO:- Give Rating to Buyer & Seller

let addReview_Url = "\(base_url)/addReview"





//TODO:- Buyer API's
//TODO:- Unboxing Video API's

let getUnboxingVideo_Url = "\(base_url)/getUnboxingVideo"





//TODO:- Buyer API's
//TODO:- Notification API's

let getNotification_Url = "\(base_url)/getNotification"




//TODO:- Buyer API's
//TODO:- getShippingStatus API

let getShippingStatus_Url = "\(base_url)/getShippingStatus"




//TODO:- Buyer API's
//TODO:- Add Dispute API

let addDispute_Url = "\(base_url)/addDispute"
let addAuthentication_Url = "\(base_url)/authentication"




//MARK:- CHAT API Implemented Here.
let getChatList_Url = "\(base_url)/getChatList"
let getChatHistory_Url = "\(base_url)/chatHistory"
let chatSendMessage_Url = "\(base_url)/sendMessage"

let chatImgBase_Url = "http://hourlylancer.com/kickTraders/admin/assets/uploads/chatImage/"






//TODO:- Product Images
let  PRODUCT_UNBOXING_VIDEO = "http://hourlylancer.com/kickTraders/admin/assets/uploads/unboxingVideo/"
let  PRODUCT_VIDEO = "http://hourlylancer.com/kickTraders/admin/assets/uploads/productVideo/"
let  PRODUCT_IMAGE = "http://hourlylancer.com/kickTraders/admin/assets/uploads/productImages/"
let  PRODUCT_COVER_IMAGE = "http://hourlylancer.com/kickTraders/admin/assets/uploads/productCoverImage/"
let  PROFILE_IMAGE =  "http://hourlylancer.com/kickTraders/admin/assets/uploads/profile_pic/"


let  About_US = "https://kicktraders.com/about-us/"
