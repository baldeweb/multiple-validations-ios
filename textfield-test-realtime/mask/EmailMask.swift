//
//  EmailMask.swift
//  textfield-test-realtime
//
//  Created by Wallace Baldenebre on 16/09/21.
//

import Foundation

class EmailMask {
    func isValidEmail(_ text: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: text)
    }
    
    func isEmail(_ text: String) -> Bool {
        return text.contains("@") && text.contains(".")
    }
}
