//
//  CNPJMask.swift
//  textfield-test-realtime
//
//  Created by Wallace on 14/09/21.
//

import Foundation

class CNPJMask {
    func mask(_ value: String) -> String {
        let cnpj = value
        var builder = ""
        builder += cnpj[0..<2]
        builder += "."
        builder += cnpj[2..<5]
        builder += "."
        builder += cnpj[5..<8]
        builder += "/"
        builder += cnpj[8..<12]
        builder += "-"
        builder += cnpj[12..<14]
        return builder
    }
    
    func isCNPJ(_ text: String) -> Bool {
        let cnpjRegex = "[0-9]{2}\\.?[0-9]{3}\\.?[0-9]{3}\\/?[0-9]{4}\\-?[0-9]{2}"
        var regex : NSRegularExpression!
        do {
            try regex = NSRegularExpression(pattern: cnpjRegex, options: .caseInsensitive)
        } catch {
            print("LOG >> REGEX CNPJ FAILED")
        }
        
        return regex.firstMatch(
            in: text,
            options: NSRegularExpression.MatchingOptions(rawValue: 0),
            range: NSMakeRange(0, text.count)
        ) != nil
    }
}
