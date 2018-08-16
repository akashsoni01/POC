    override func viewDidLoad() {
        super.viewDidLoad()
        oldPassWordTextField.delegate = self
        newPasswordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        oldPassWordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        newPasswordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        confirmPasswordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

        self.navigationController?.setNavigationBarHidden(false, animated: false)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: self, action: nil)
    }






extension SettingsViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //get called after return txtfield
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let password = KeychainWrapper.standard.string(forKey: Constants.password),let text = oldPassWordTextField.text,password == text{
            oldPassWordTextField.errorMessage = nil
        }else{
            oldPassWordTextField.errorMessage = "Dose't match with old password"
            submitButton.backgroundColor = AppTheme.colorForDisableButton
            submitButton.isEnabled = false
        }

    }
    
    //get called each time textField change their value
    @objc func textFieldDidChange(textField: SkyFloatingLabelTextField){
        submitButton.backgroundColor = AppTheme.colorForDisableButton
        submitButton.isEnabled = false
        if  (oldPassWordTextField.text?.count)! >= 6,
            (newPasswordTextField.text?.count)! >= 6,
            newPasswordTextField.text == confirmPasswordTextField.text,
            let oldPassword = KeychainWrapper.standard.string(forKey: Constants.password),let text = oldPassWordTextField.text,oldPassword == text
        {
            submitButton.isEnabled = true
            submitButton.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.5411764706, blue: 0.4549019608, alpha: 1)
        }
        
        
        if (textField.text?.count)! < 6{
            textField.errorMessage = "Password must be of minimum 6 characters"
        }else{
            textField.errorMessage = nil
        }
    }
    

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 0{
            previousTextFieldContent = textField.text;
            previousSelection = textField.selectedTextRange;
            
            let maxLength = 19
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
    }
}
