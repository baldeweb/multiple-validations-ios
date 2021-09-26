//
//  ViewController.swift
//  textfield-test-realtime
//
//  Created by Wallace on 14/09/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameField: CustomUITextField!
    private var cleanText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    func onTextChanged(_ text: String) {
        print(" ")
        print("LOG >> onTextChanged: \(text)")
        print("LOG >> getOnlyNumbers: \(String(describing: text.removeAllFormatting()))")
        print("LOG >> hasOnlyNumbers[cleanText]: \(cleanText.hasOnlyNumbers())")
        print("LOG >> hasOnlyNumbers[hasOnlyNumbers]: \(text.hasOnlyNumbers())")
        
        if !text.hasOnlyNumbers() {
            if text.isEmail() {
                //  EMAIL VALIDO
                emailValidation(text)
            }
        } else {
            self.cleanText = text.removeAllFormatting()
            print("LOG >> cleanText: \(cleanText) | Tamanho: \(cleanText.count)")
            
            switch cleanText.count {
                case 11:
                    //  CPF ou CELULAR
                    if cleanText.isCellphone() && cleanText.isCPF() {
                        //  CPF E CELULAR VALIDOS
                        print("LOG >> CPF E CELULAR")
                    } else if cleanText.isCPF() {
                        //  CPF VALIDO
                        cpfValidation()
                    } else if cleanText.isCellphone() {
                        //  CELULAR VALIDO
                        phoneValidation()
                    } else {
                        //  CPF E CELULAR INVALIDOS
                        print("LOG >> CPF E CELULAR INVALIDOS")
                        chaveInvalidaValidation()
                    }
                    break
                case 14:
                    //  CNPJ
                    cnpjValidation()
                    break
                case 32:
                    //  CHAVE ALEATORIA
                    chaveAleatoriaValidation(text)
                    break
                default:
                    //  "CHAVE INVALIDA"
                    chaveInvalidaValidation()
                    break
            }
        }
    }
    
    private func emailValidation(_ text: String) {
        print("LOG >> EMAIL")
        print("LOG >> EMAIL VALIDO")
    }
    
    private func cpfValidation() {
        print("LOG >> CPF")
        self.setMask(cleanText.toCPFmask())
    }
    
    private func cnpjValidation() {
        print("LOG >> CNPJ")
        if cleanText.isCNPJ() {
            self.setMask(cleanText.toCNPJmask())
        } else {
            print("LOG >> CNPJ INVALIDO")
        }
    }
    
    private func phoneValidation() {
        print("LOG >> CELULAR")
        self.setMask(cleanText.toPhoneMask())
    }
    
    private func chaveAleatoriaValidation(_ text: String) {
        print("LOG >> CHAVE ALEATORIA")
        if text.isChaveAleatoria() {
            self.setMask(cleanText)
        } else {
            //  "Chave aleatória invalida"
            print("LOG >> CHAVE ALEATORIA INVALIDA")
        }
    }
    
    private func chaveInvalidaValidation() {
        print("LOG >> CHAVE INVALIDA")
        cleanText = cleanText.removeAllFormatting()
        nameField.text = cleanText
    }
    
    private func setMask(_ text: String) {
        print("setMask: \(text)")
        nameField.text = text
    }
    
    @objc func textFieldDidChange(_ text: UITextField) {
        self.onTextChanged(text.text ?? "")
    }
}
