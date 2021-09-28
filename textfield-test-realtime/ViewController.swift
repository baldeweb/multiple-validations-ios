//
//  ViewController.swift
//  textfield-test-realtime
//
//  Created by Wallace on 14/09/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    private var cleanText = ""
    private var dictValue = Dictionary<String, PIXKey>()
    public var onKeyChoosed: ((Dictionary<String, PIXKey>) -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        self.onKeyChoosed = { result in
            print("LOG >> self.onKeyChoosed >> result.first?.key: \(result.first?.key ?? "") result.first?.value: \(result.first?.value ?? PIXKey.CHAVE_INVALIDA)")
        }
    }
    
    func onTextChanged(_ text: String) {
        /*print(" ")
        print("LOG >> onTextChanged: \(text)")
        print("LOG >> getOnlyNumbers: \(String(describing: text.removeAllFormatting()))")
        print("LOG >> hasOnlyNumbers[cleanText]: \(cleanText.hasOnlyNumbers())")
        print("LOG >> hasOnlyNumbers[hasOnlyNumbers]: \(text.hasOnlyNumbers())")*/
        
        if !text.hasOnlyNumbers() {
            if text.isEmail() {
                //  EMAIL VALIDO
                emailValidation(text)
            } else if text.isChaveAleatoria() {
                //  CHAVE ALEATORIA
                chaveAleatoriaValidation(text)
            }
        } else {
            self.cleanText = text.removeAllFormatting()
            print("LOG >> cleanText: \(cleanText) | Tamanho: \(cleanText.count)")
            
            switch cleanText.count {
            case 11:
                //  CPF ou CELULAR
                if cleanText.isCellphone() && cleanText.isCPF() {
                    //  CPF E CELULAR VALIDOS
                    cpfAndCellphoneValidation()
                } else if cleanText.isCPF() {
                    //  CPF VALIDO
                    cpfValidation()
                } else if cleanText.isCellphone() {
                    //  CELULAR VALIDO
                    phoneValidation()
                } else {
                    //  CPF E CELULAR INVALIDOS
                    chaveInvalidaValidation()
                }
                break
            case 14:
                //  CNPJ
                cnpjValidation()
                break
            default:
                //  "CHAVE INVALIDA"
                chaveInvalidaValidation()
                break
            }
        }
    }
    
    private func cpfAndCellphoneValidation() {
        self.dictValue[self.cleanText] = PIXKey.CPF_AND_CELULAR
        self.onKeyChoosed(dictValue)
    }
    
    private func emailValidation(_ text: String) {
        self.dictValue[self.cleanText] = PIXKey.EMAIL
        self.onKeyChoosed(dictValue)
    }
    
    private func cpfValidation() {
        self.setMask(cleanText.toCPFmask())
        
        self.dictValue[cleanText] = PIXKey.CPF
        self.onKeyChoosed(dictValue)
    }
    
    private func cnpjValidation() {
        if cleanText.isCNPJ() {
            self.setMask(cleanText.toCNPJmask())
            
            self.dictValue[self.cleanText] = PIXKey.CNPJ
            self.onKeyChoosed(dictValue)
        } else {
            self.dictValue[self.cleanText] = PIXKey.CHAVE_INVALIDA
            self.onKeyChoosed(dictValue)
        }
    }
    
    private func phoneValidation() {
        self.setMask(cleanText.toPhoneMask())
        
        self.dictValue[self.cleanText] = PIXKey.CELULAR
        self.onKeyChoosed(dictValue)
    }
    
    private func chaveAleatoriaValidation(_ text: String) {
        if text.isChaveAleatoria() {
            self.setMask(cleanText)
            self.dictValue[self.cleanText] = PIXKey.CHAVE_ALEATORIA
            self.onKeyChoosed(dictValue)
        } else {
            self.dictValue[self.cleanText] = PIXKey.CHAVE_INVALIDA
            self.onKeyChoosed(dictValue)
        }
    }
    
    private func chaveInvalidaValidation() {
        cleanText = cleanText.removeAllFormatting()
        nameField.text = cleanText
        self.dictValue.removeAll()
    }
    
    private func setMask(_ text: String) {
        print("setMask: \(text)")
        nameField.text = text
    }
    
    @objc func textFieldDidChange(_ text: UITextField) {
        self.onTextChanged(text.text ?? "")
    }
}
