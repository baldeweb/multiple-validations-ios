//
//  PhoneMask.swift
//  textfield-test-realtime
//
//  Created by Wallace on 14/09/21.
//

import Foundation

class PhoneMask {
    func mask(_ value: String, _ withDDI: Bool = false) -> String {
        var phone = value
        if phone.starts(with: "+") {
            phone = String(value.dropFirst())
        }
        
        if phone.starts(with: "55") {
            phone = String(value.drop(while: "55".contains(_:)))
        }
        
        let prefix = withDDI ? "+55(" : "("
        var builder = ""
        builder += prefix
        builder += phone[1..<3]
        builder += ") "
        builder += phone[3..<8]
        builder += "-"
        builder += phone[8..<12]
        return builder
    }

    func isPhone(_ text: String) -> Bool {
        let phoneRegex = "([\\+]?[5-5]{2})?[(]?((11)|(12)|(13)|(14)|(15)|(16)|(17)|(18)|(19)|(21)|(22)|(24)|(27)|(28)|(31)|(32)|(33)|(34)|(35)|(37)|(38)|(41)(42)|(43)|(44)|(45)|(46)|(47)|(48)|(49)|(51)|(53)|(54)|(55)|(61)|(62)|(63)|(64)|(65)|(66)|(67)|(68)|(69)|(71)(73)|(74)|(75)|(77)|(79)|(81)|(82)|(83)|(84)|(85)|(86)|(87)|(88)|(89)|(91)|(92)|(93)|(94)|(95)|(96)|(97)|(98)|(99))[)]?(?:[2-8]|9[1-9])[0-9]{3}[0-9]{4}$"
        var regex : NSRegularExpression!
        do {
            try regex = NSRegularExpression(pattern: phoneRegex, options: .caseInsensitive)
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
