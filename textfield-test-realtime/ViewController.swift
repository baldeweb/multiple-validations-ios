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
    public var onKeyChoosed: ((PIXKey, String) -> Void)?
    public var oldKey = PIXKey.NONE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        self.onKeyChoosed = { key, value in
            print("LOG >> onKeyChoosed >> Key: \(key) | Value: \(value)")
        }
    }
    
    func onTextChanged(_ text: String) {
        if text.isEmpty {
            oldKey = PIXKey.NONE
            self.onKeyChoosed!(PIXKey.NONE, "")
        } else if text.isEmail() {
            emailValidation(text)
        } else {
            self.cleanText = text.removeAllFormatting()
            
            switch cleanText.count {
            case 11:
                //  CPF ou CELULAR
                if cleanText.isCellphone() && cleanText.isCPF() {
                    //  CPF E CELULAR VALIDOS
                    cpfAndCellphoneValidation(text)
                } else if cleanText.isCPF() {
                    //  CPF VALIDO
                    cpfValidation()
                } else if cleanText.isCellphone() {
                    //  CELULAR VALIDO
                    celularValidation()
                } else {
                    //  CPF E CELULAR INVALIDOS
                    chaveInvalidaValidation(text)
                }
                break
            case 13:
                if cleanText.isCellphone() {
                    celularValidation()
                } else {
                    chaveInvalidaValidation(text)
                }
                break
            case 14:
                cnpjValidation(text)
                break
            case 32:
                chaveAleatoriaValidation(text)
                break
            default:
                chaveInvalidaValidation(text)
                break
            }
        }
    }
    private func cpfAndCellphoneValidation(_ text: String) {
        setMask(cleanText)
        oldKey = PIXKey.CPF_AND_CELULAR
        self.onKeyChoosed!(PIXKey.CPF_AND_CELULAR, text)
    }
    
    private func emailValidation(_ text: String) {
        setMask(text)
        oldKey = PIXKey.EMAIL
        self.onKeyChoosed!(PIXKey.EMAIL, text)
    }
    
    private func cpfValidation() {
        self.setMask(cleanText.toCPFmask())
        
        oldKey = PIXKey.CPF
        self.onKeyChoosed!(PIXKey.CPF, cleanText)
    }
    
    private func cnpjValidation(_ text: String) {
        if cleanText.isValidCNPJ {
            self.setMask(cleanText.toCNPJmask())
            oldKey = PIXKey.CNPJ
            self.onKeyChoosed!(PIXKey.CNPJ, cleanText)
        } else {
            chaveInvalidaValidation(text)
        }
    }
    
    private func celularValidation() {
        self.setMask(cleanText.toPhoneMask())
        
        oldKey = PIXKey.CELULAR
        self.onKeyChoosed!(PIXKey.CELULAR, cleanText)
    }
    
    private func chaveAleatoriaValidation(_ text: String) {
        if text.isChaveAleatoria() {
            self.setMask(cleanText.toChaveAleatoriaMask())
            oldKey = PIXKey.CHAVE_ALEATORIA
            self.onKeyChoosed!(PIXKey.CHAVE_ALEATORIA, cleanText)
        } else {
            chaveInvalidaValidation(text)
        }
    }
    
    private func chaveInvalidaValidation(_ text: String) {
        cleanText = text.removeAllFormatting()
        
        if oldKey != PIXKey.CHAVE_INVALIDA && oldKey != PIXKey.EMAIL {
            self.nameField.text = cleanText
        } else {
            self.nameField.text = text
        }
        
        oldKey = PIXKey.CHAVE_INVALIDA
        self.onKeyChoosed!(PIXKey.CHAVE_INVALIDA, "")
    }
    
    private func setMask(_ text: String) {
        self.nameField.text = text
    }
    
    @objc func textFieldDidChange(_ text: UITextField) {
        self.onTextChanged(text.text ?? "")
    }
}
