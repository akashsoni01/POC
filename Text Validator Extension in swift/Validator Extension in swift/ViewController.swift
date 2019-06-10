//
//  ViewController.swift
//  Validator Extension in swift
//
//  Created by Akash Soni on 10/06/19.
//  Copyright © 2019 Akash Soni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        email.addTarget(self, action: #selector(valueChange), for: .editingChanged)
        age.addTarget(self, action: #selector(valueChange), for: .editingChanged)
        username.addTarget(self, action: #selector(valueChange), for: .editingChanged)
        password.addTarget(self, action: #selector(valueChange), for: .editingChanged)

    }
    @objc func valueChange(){
        do {
            let emailString = try email.validatedText(validationType: ValidatorType.email)
            let passwordString = try password.validatedText(validationType: .password)
            let usernameString = try username.validatedText(validationType: .username)
            let ageString = try age.validatedText(validationType: .age)
            signupButton.backgroundColor = .green
            print("Successfull")
        } catch(let error) {
            print(error.localizedDescription)
            signupButton.backgroundColor = .lightGray
        }
        
    }


}

