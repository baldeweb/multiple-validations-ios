import Foundation

extension String {
    func toCPFmask() -> String {
        let cpf = self
        var builder = ""
        builder += cpf[0..<3]
        builder += "."
        builder += cpf[3..<6]
        builder += "."
        builder += cpf[6..<9]
        builder += "-"
        builder += cpf[9..<11]
        return builder
    }
    
    func toCNPJmask() -> String {
        let cnpj = self
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
    
    func toPhoneMask() -> String {
        var prefix = ""
        var builder = ""
        
        if !self.starts(with: "+55") {
            prefix = "+55("
            builder += prefix
            builder += self[0..<2]
            builder += ")"
            builder += self[2..<7]
            builder += "-"
            builder += self[7..<11]
        } else {
            prefix = ""
            builder += prefix
            builder += self[0..<2]
            builder += ")"
            builder += self[2..<7]
            builder += "-"
            builder += self[7..<11]
        }
        
        return builder
    }
    
    func toChaveAleatoriaMask() -> String {
        var builder = ""
        builder += self[0..<8]
        builder += "-"
        builder += self[8..<12]
        builder += "-"
        builder += self[12..<16]
        builder += "-"
        builder += self[16..<20]
        builder += "-"
        builder += self[20..<32]
        return builder
    }
}
