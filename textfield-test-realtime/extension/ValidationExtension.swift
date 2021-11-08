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
        var textUnmasked = self
        
        textUnmasked = textUnmasked.replacingOccurrences(of: ".", with: "")
        
        if self.starts(with: "+55") {
            textUnmasked = textUnmasked.replacingOccurrences(of: "+55", with: "")
        } else if self.starts(with: "55") {
            textUnmasked = textUnmasked.replacingOccurrences(of: "55", with: "")
        }
        
        textUnmasked = textUnmasked.replacingOccurrences(of: ",", with: "")
        textUnmasked = textUnmasked.replacingOccurrences(of: "-", with: "")
        textUnmasked = textUnmasked.replacingOccurrences(of: "/", with: "")
        textUnmasked = textUnmasked.replacingOccurrences(of: "(", with: "")
        textUnmasked = textUnmasked.replacingOccurrences(of: " ", with: "")
        textUnmasked = textUnmasked.replacingOccurrences(of: "+", with: "")
        textUnmasked = textUnmasked.replacingOccurrences(of: ")", with: "")
        return textUnmasked
    }
    
    func hasOnlyNumbers() -> Bool {
        let hasNumber = self.range(of: "\\d+", options: .regularExpression) != nil
        let hasLetter = self.range(of: "[a-zA-Z]+", options: .regularExpression) != nil
        return hasNumber && !hasLetter
    }
    
    func isEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return self.range(of: emailRegEx, options: .regularExpression) != nil
    }
    
    func isCPF() -> Bool {
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
    
    func isCellphone() -> Bool {
        let validDDD = "11|12|13|14|15|16|17|18|19|21|22|24|27|28|31|32|33|34|35|37|38|41|42|43|44|45|46|47|48|49|51|53|54|55|61|62|63|64|65|66|67|68|69|71|73|74|75|77|79|81|82|83|84|85|86|87|88|89|91|92|93|94|95|96|97|98|99"
        let phoneRegex = "(?:(?:\\+|00)?(\\+?55)?)?(\(validDDD))((9[0-9]\\d{3})-?(\\d{4}))$"
        return self.range(of: phoneRegex, options: .regularExpression) != nil
    }
    
    func isCNPJ() -> Bool {
        let cnpjRegex = "[0-9]{2}\\.?[0-9]{3}\\.?[0-9]{3}\\/?[0-9]{4}\\-?[0-9]{2}"
        return self.range(of: cnpjRegex, options: .regularExpression) != nil
    }
    
    func isChaveAleatoria() -> Bool {
        let chaveAleatoriaRegex = "[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}"
        return self.range(of: chaveAleatoriaRegex, options: .regularExpression) != nil
    }
    
    var isValidCNPJ: Bool {
        let numbers = self.compactMap({Int(String($0))})
        guard numbers.count == 14 && Set(numbers).count != 1 else { return false }
        let soma1 = 11 - ( numbers[11] * 2 +
            numbers[10] * 3 +
            numbers[9] * 4 +
            numbers[8] * 5 +
            numbers[7] * 6 +
            numbers[6] * 7 +
            numbers[5] * 8 +
            numbers[4] * 9 +
            numbers[3] * 2 +
            numbers[2] * 3 +
            numbers[1] * 4 +
            numbers[0] * 5 ) % 11
        let dv1 = soma1 > 9 ? 0 : soma1
        let soma2 = 11 - ( numbers[12] * 2 +
            numbers[11] * 3 +
            numbers[10] * 4 +
            numbers[9] * 5 +
            numbers[8] * 6 +
            numbers[7] * 7 +
            numbers[6] * 8 +
            numbers[5] * 9 +
            numbers[4] * 2 +
            numbers[3] * 3 +
            numbers[2] * 4 +
            numbers[1] * 5 +
            numbers[0] * 6 ) % 11
        let dv2 = soma2 > 9 ? 0 : soma2
        return dv1 == numbers[12] && dv2 == numbers[13]
    }
}
