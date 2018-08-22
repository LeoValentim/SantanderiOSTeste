//
//  UIString+Validation.swift
//  TesteiOSSantander
//
//  Created by Mac on 20/08/2018.
//  Copyright © 2018 Leo Valentim. All rights reserved.
//
import UIKit

extension String {
    var isValidEmail: Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var numbers: String {
        get {
            return self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        }
    }
}
