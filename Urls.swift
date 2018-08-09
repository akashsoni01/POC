//
//  Urls.swift
//  goCrypto
//
//  Created by shobhit tyagi on 11/07/18.
//  Copyright © 2018 Rajat. All rights reserved.
//

import Foundation

let register = "register"
let login = "login"
let saveUserDetail = "userDetails"
let getUserDetail = "userDetails/"
let accountKYC = "account_kyc"
let getCards = "getCards/"
let getclientToken = "getToken/"
let completetransaction = "completeTransaction"
let forgotPassword = "forgotPassword"
let resetPassword = "resetPassword"
let removeCard = "removeCard"
let changePassword = "changePassword"
func baseurl(string: String) -> String
{
    return "http://192.168.1.191:8080/goCrypto/" + string
}


