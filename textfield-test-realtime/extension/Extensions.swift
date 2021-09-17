//
//  Extensions.swift
//  textfield-test-realtime
//
//  Created by Wallace on 14/09/21.
//

import Foundation

extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(start, offsetBy: min(self.count - range.lowerBound,
                                             range.upperBound - range.lowerBound))
        return String(self[start..<end])
    }

    subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
         return String(self[start...])
    }
    
    func getOnlyNumbers() -> String {
        var textUnmasked = self.replacingOccurrences(of: ".", with: "")
        if self.starts(with: "+55") {
            textUnmasked = self.replacingOccurrences(of: "+55", with: "")
        }
        textUnmasked = textUnmasked.replacingOccurrences(of: "-", with: "")
        textUnmasked = textUnmasked.replacingOccurrences(of: "/", with: "")
        textUnmasked = textUnmasked.replacingOccurrences(of: "(", with: "")
        textUnmasked = textUnmasked.replacingOccurrences(of: " ", with: "")
        textUnmasked = textUnmasked.replacingOccurrences(of: "+", with: "")
        textUnmasked = textUnmasked.replacingOccurrences(of: ")", with: "")
        return textUnmasked
    }
  
    func hasOnlyNumbers() -> Bool {
        return !self.getOnlyNumbers().filter{ $0.isNumber }.isEmpty
    }
}
