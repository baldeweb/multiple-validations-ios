//
//  ChaveAleatoria.swift
//  textfield-test-realtime
//
//  Created by Wallace Baldenebre on 15/09/21.
//

import Foundation
class ChaveAleatoriaMask {
    func mask(_ value: String) -> String {
        let chave = value
        
        var builder = ""
        builder += chave[0..<8]
        builder += "-"
        builder += chave[8..<12]
        builder += "-"
        builder += chave[12..<16]
        builder += "-"
        builder += chave[16..<20]
        builder += "-"
        builder += chave[20..<32]
        return builder
    }

    func isValid(_ text: String) -> Bool {
        let chaveAleatoriaRegex = "[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}"
        var regex : NSRegularExpression!
        do {
            try regex = NSRegularExpression(pattern: chaveAleatoriaRegex, options: NSRegularExpression.Options.caseInsensitive)
        } catch {
            print("LOG >> REGEX CPF FAILED")
        }
        
        return regex.firstMatch(
            in: text,
            options: NSRegularExpression.MatchingOptions(rawValue: 0),
            range: NSMakeRange(0, text.count)
        ) == nil
    }
}
