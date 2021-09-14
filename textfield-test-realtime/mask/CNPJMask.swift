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
extension StringProtocol {
    var isCNPJ: Bool {
        let numbers = compactMap(\.wholeNumberValue)
        guard numbers.count == 14 && Set(numbers).count != 1 else { return false }
        return numbers.prefix(12).digitoCNPJ == numbers[12] &&
               numbers.prefix(13).digitoCNPJ == numbers[13]
    }
}
