//
//  PhoneMask.swift
//  textfield-test-realtime
//
//  Created by Wallace on 14/09/21.
//

import Foundation

class PhoneMask {
    var VALID_DDD = Array<String>(arrayLiteral:
            "11", "12", "13", "14", "15", "16", "17", "18", "19", "21", "22",
            "24", "27", "28", "31", "32", "33", "34", "35", "37", "38", "41",
            "42", "43", "44", "45", "46", "47", "48", "49", "51", "53", "54",
            "55", "61", "62", "63", "64", "65", "66", "67", "68", "69", "71",
            "73", "74", "75", "77", "79", "81", "82", "83", "84", "85", "86",
            "87", "88", "89", "91", "92", "93", "94", "95", "96", "97", "98",
            "99"
    )

    func mask(_ value: String, _ withDDI: Bool = false) -> String {
        var phone = value
        if phone.starts(with: "+") {
            phone = String(value.dropFirst())
        }
        
        if phone.starts(with: "55") {
            phone = String(value.drop(while: "55".contains(_:)))
        }
        
        let prefix = withDDI ? "+55 (" : "("
        var builder = ""
        builder += prefix
        builder += phone[1..<3]
        builder += ") "
        builder += phone[3..<8]
        builder += "-"
        builder += phone[8..<12]
        return builder
    }

    func unmask(_ value: String, _ withDDI: Bool = false) -> String {
        var phone = value
        
        //  Remove o +
        phone = String(phone.dropFirst())
        
        //  Remove o 55
        phone = String(phone.dropFirst())
        phone = String(phone.dropFirst())
            
        phone = phone.replacingOccurrences(of: "(", with: "")
        phone = phone.replacingOccurrences(of: ")", with: "")
        phone = phone.replacingOccurrences(of: " ", with: "")
        phone = phone.replacingOccurrences(of: "-", with: "")
        let prefix = withDDI ? "55" : ""
        return prefix + phone
    }

    func isPhone(_ value: String) -> Bool {
        let ddd = String(value[0..<2])
        if (!isRealDDD(ddd)) {
            return false
        }
        return true
    }

    private func isRealDDD(_ ddd: String) -> Bool {
        for dddTest in VALID_DDD {
            if ddd == dddTest {
                return true
            }
        }
        return false
    }
}
