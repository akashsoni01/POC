//
//  UI.swift
//  Validator Extension in swift
//
//  Created by Akash Soni on 10/06/19.
//  Copyright © 2019 Akash Soni. All rights reserved.
//

import UIKit.UITextField

extension UITextField {
    func validatedText(validationType: ValidatorType) throws -> String {
        let validator = VaildatorFactory.validatorFor(type: validationType)
        return try validator.validated(self.text!)
    }
}
