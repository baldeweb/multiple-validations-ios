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
    
    func isValidCPF(_ text: String) -> Bool {
        let numbers = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        guard numbers.count == 11 else { return false }

        let set = NSCountedSet(array: Array(numbers))
        guard set.count != 1 else { return false }

        let i1 = numbers.index(numbers.startIndex, offsetBy: 9)
        let i2 = numbers.index(numbers.startIndex, offsetBy: 10)
        let i3 = numbers.index(numbers.startIndex, offsetBy: 11)
        let d1 = Int(numbers[i1..<i2])
        let d2 = Int(numbers[i2..<i3])

        var temp1 = 0, temp2 = 0

        for i in 0...8 {
            let start = numbers.index(numbers.startIndex, offsetBy: i)
            let end = numbers.index(numbers.startIndex, offsetBy: i+1)
            let char = Int(numbers[start..<end])

            temp1 += char! * (10 - i)
            temp2 += char! * (11 - i)
        }

        temp1 %= 11
        temp1 = temp1 < 2 ? 0 : 11-temp1

        temp2 += temp1 * 2
        temp2 %= 11
        temp2 = temp2 < 2 ? 0 : 11-temp2

        return temp1 == d1 && temp2 == d2
    }
    
    func onlyNumbers(_ text: String) -> String {
        guard !text.isEmpty else { return "" }
        return text.replacingOccurrences(
            of: "\\D",
            with: "",
            options: .regularExpression,
            range: text.startIndex..<text.endIndex
        )
    }
}
