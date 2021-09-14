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

    func unmask(_ value: String) -> String {
        var cpf = value.replacingOccurrences(of: ".", with: "")
        cpf += value.replacingOccurrences(of: "-", with: "")
        return cpf
    }
    
    func isCPF(_ text: String) -> Bool {
        return text.isCPF
    }
}

extension Collection where Element == Int {
    var digitoCPF: Int {
        var number = count + 2
        let digit = 11 - reduce(into: 0) {
            number -= 1
            $0 += $1 * number
        } % 11
        return digit > 9 ? 0 : digit
    }
}
extension StringProtocol {
    var isCPF: Bool {
        let numbers = compactMap(\.wholeNumberValue)
        guard numbers.count == 11 && Set(numbers).count != 1 else { return false }
        return numbers.prefix(9).digitoCPF == numbers[9] &&
               numbers.prefix(10).digitoCPF == numbers[10]
    }
}
