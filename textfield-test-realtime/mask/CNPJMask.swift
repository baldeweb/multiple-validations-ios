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
        builder += cnpj[1..<3]
        builder += "."
        builder += cnpj[3..<6]
        builder += "."
        builder += cnpj[6..<9]
        builder += "/"
        builder += cnpj[9..<13]
        builder += "-"
        builder += cnpj[13..<15]
        return builder
    }

    func unmask(_ value: String) -> String {
        var cnpj = value.replacingOccurrences(of: ".", with: "")
        cnpj += value.replacingOccurrences(of: "/", with: "")
        return cnpj
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

extension Collection where Element == Int {
    var digitoCNPJ: Int {
        var number = 1
        let digit = 11 - reversed().reduce(into: 0) {
            number += 1
            $0 += $1 * number
            if number == 9 { number = 1 }
        } % 11
        return digit > 9 ? 0 : digit
    }
}
