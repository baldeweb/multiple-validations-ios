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
    
    func removeAllFormatting() -> String {
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
        return !self.removeAllFormatting().filter{ $0.isNumber }.isEmpty
    }
    
    func isValidCPF() -> Bool {
        let numbers = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
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
    
    func isCPF() -> Bool {
        let cpfRegex = "[0-9]{3}\\.?[0-9]{3}\\.?[0-9]{3}\\-?[0-9]{2}"
        var regex : NSRegularExpression!
        do {
            try regex = NSRegularExpression(pattern: cpfRegex, options: .caseInsensitive)
        } catch {
            print("LOG >> REGEX CPF FAILED")
        }
        
        return regex.firstMatch(
            in: self,
            options: NSRegularExpression.MatchingOptions(rawValue: 0),
            range: NSMakeRange(0, self.count)
        ) != nil
    }
    
    func isValidCNPJ() -> Bool {
        let cnpjRegex = "[0-9]{2}\\.?[0-9]{3}\\.?[0-9]{3}\\/?[0-9]{4}\\-?[0-9]{2}"
        var regex : NSRegularExpression!
        do {
            try regex = NSRegularExpression(pattern: cnpjRegex, options: .caseInsensitive)
        } catch {
            print("LOG >> REGEX CNPJ FAILED")
        }
        
        return regex.firstMatch(
            in: self,
            options: NSRegularExpression.MatchingOptions(rawValue: 0),
            range: NSMakeRange(0, self.count)
        ) != nil
    }
    
    func isValidPhone() -> Bool {
        let invalidDDI = "10|20|23|25|26|29|30|36|39|40|50|52|56|57|58|59|60|70|72|76|78|80|90"
        let phoneRegex = "^(\\+55)?([(]?(?:"+invalidDDI+")[)]?|(?:"+invalidDDI+"))9[5-9]{1}\\d{4}[-]?\\d{4}$"
        var regex : NSRegularExpression!
        do {
            try regex = NSRegularExpression(pattern: phoneRegex, options: NSRegularExpression.Options.caseInsensitive)
        } catch {
            print("LOG >> REGEX CPF FAILED")
        }
        
        return regex.firstMatch(
            in: self,
            options: NSRegularExpression.MatchingOptions(rawValue: 0),
            range: NSMakeRange(0, self.count)
        ) == nil
    }
    
    func isValidChaveAleatoria() -> Bool {
        let chaveAleatoriaRegex = "[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}"
        var regex : NSRegularExpression!
        do {
            try regex = NSRegularExpression(pattern: chaveAleatoriaRegex, options: NSRegularExpression.Options.caseInsensitive)
        } catch {
            print("LOG >> REGEX CPF FAILED")
        }
        
        return regex.firstMatch(
            in: self,
            options: NSRegularExpression.MatchingOptions(rawValue: 0),
            range: NSMakeRange(0, self.count)
        ) == nil
    }
    
    func isValidEmail() -> Bool {
        return self.contains("@") && self.contains(".")
    }
    
    func isEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}
