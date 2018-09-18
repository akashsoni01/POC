//
//  ViewController.swift
//  EncriptioinAndDecriptionInSwift
//
//  Created by Akash Soni on 17/09/18.
//  Copyright © 2018 Akash Soni. All rights reserved.
//

import UIKit
import CryptoSwift

class ViewController: UIViewController {
    let string = "hi this is akash soni"
    var cipherFileData:[UInt8] = [UInt8]()
    var cipherText:[UInt8] = [UInt8]()
    override func viewDidLoad() {
        
        // padding
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func encryptTapped(_ sender: UIButton) {
        encryptFile()
    }
    @IBAction func decryptTapped(_ sender: UIButton) {
        decryptFile()
    }
    
    func encryptString() {
        do{
            let aes = try! AES(key: "1234123412341234", iv: "drowssapdrowssap")
            let cipherText = try aes.encrypt(Array(string.utf8))
           self.cipherText = cipherText
            print(Array(string))
            print(Array(string.utf8))
            print(cipherText)
            print(cipherText.toHexString())
            print("Encrypted succesfully...................................")
        }catch {
            print("somthing went wrong while encription.")
        }
    }
    func encryptFile(){
        let aes = try! AES(key: "1234123412341234", iv: "drowssapdrowssap")
        let jsonFileurl = Bundle.main.url(forResource: "zips", withExtension: "json")
        //fetch the data as String
        let jsonFileData = try! Data.init(contentsOf: jsonFileurl!)
        let fileDataInString = try? String.init(contentsOf: jsonFileurl!, encoding: .utf8)

        print(Array((fileDataInString?.utf8)!))
        let cipherFileData = try? aes.encrypt(Array((fileDataInString?.utf8)!))
        self.cipherFileData = cipherFileData!
        print(cipherFileData?.toHexString())
        print("Encryption File called")
        print("Encryption Succesfull................")
        //convert into utf8
        
        //convert into Array
        //encrypt
    }
    
    
    func decryptString() {
        do{
            let aes = try! AES(key: "1234123412341234", iv: "drowssapdrowssap")
            let plainText = try aes.decrypt(cipherText)
            
            let str = String(bytes: plainText, encoding: .utf8)
            print(plainText)
            print(str)
        }catch{
            print("Somthing went wrong while decrypting")
        }
        
    }
    
    func decryptFile(){
        do{
            let aes = try! AES(key: "1234123412341234", iv: "drowssapdrowssap")
            let plainData = try aes.decrypt(cipherFileData)
            let str = String(bytes: plainData, encoding: .utf8)
            print(plainData)
            print(str)
            print("Decription Sussefull")
        }
        catch{
            print("Somthing Went wrong while decryptiong file")
        }
    }

}

public extension FileManager{
    static var documentUrl:URL {
        get {
            return try! FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false)
            
        }
    }
}
