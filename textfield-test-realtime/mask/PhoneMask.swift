//
//  PhoneMask.swift
//  textfield-test-realtime
//
//  Created by Wallace on 14/09/21.
//

import Foundation

class PhoneMask {
    func mask(_ value: String, _ withDDI: Bool = false) -> String {
        let phone = value
        
        let prefix = withDDI ? "(" : "("
        var builder = ""
        builder += prefix
        builder += phone[0..<2]
        builder += ") "
        builder += phone[2..<7]
        builder += "-"
        builder += phone[7..<11]
        return builder
    }

    func isPhone(_ text: String) -> Bool {
        let phoneRegex = "[(]?(?:((10|20|23|25|26|29|30|36|39|40|50|52|56|57|58|59|60|70|72|76|78|80|90)))[)]?(?:[2-8]|9[1-9])[0-9]{3}[0-9]{4}$"
        var regex : NSRegularExpression!
        do {
            try regex = NSRegularExpression(pattern: phoneRegex, options: NSRegularExpression.Options.caseInsensitive)
        } catch {
            print("LOG >> REGEX CPF FAILED")
        }
        
        return regex.firstMatch(
            in: text,
            options: NSRegularExpression.MatchingOptions(rawValue: 0),
            range: NSMakeRange(0, text.count)
        ) != nil
    }
    
    func isValidPhone(_ text: String) -> Bool {
        let phoneNumberRegex = "/^\\(\\d{2}\\)\\d{4,5}-\\d{4}$/gi"
        var regex : NSRegularExpression!
        do {
            try regex = NSRegularExpression(pattern: phoneNumberRegex, options: NSRegularExpression.Options.caseInsensitive)
        } catch {
            print("LOG >> REGEX CPF FAILED")
        }
        
        return regex.firstMatch(
            in: text,
            options: NSRegularExpression.MatchingOptions(rawValue: 0),
            range: NSMakeRange(0, text.count)
        ) != nil
    }
}
