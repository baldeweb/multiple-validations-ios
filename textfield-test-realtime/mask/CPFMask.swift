//
//  CPFMask.swift
//  textfield-test-realtime
//
//  Created by Wallace on 14/09/21.
//

import Foundation

class CPFMask {
    func mask(_ value: String) -> String {
        print("LOG >> CPF[inicio]: \(value)")
        let cpf = value
        var builder = ""
        builder += cpf[0..<3]
        builder += "."
        builder += cpf[3..<6]
        builder += "."
        builder += cpf[6..<9]
        builder += "-"
        builder += cpf[9..<11]
        print("LOG >> CPF[fim] \(builder)")
        return builder
    }

    func isCPF(_ text: String) -> Bool {
        let cpfRegex = "[0-9]{3}\\.?[0-9]{3}\\.?[0-9]{3}\\-?[0-9]{2}"
        var regex : NSRegularExpression!
        do {
            try regex = NSRegularExpression(pattern: cpfRegex, options: .caseInsensitive)
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
