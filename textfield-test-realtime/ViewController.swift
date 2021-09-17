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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    func onTextChanged(_ text: String) {
        self.cleanText = text.removeAllFormatting()
        
        //  TODO: validar com Regex, se for qualquer numero sequencial, ja dar um return
        
        print(" ")
        print("LOG >> onTextChanged: \(text)")
        print("LOG >> getOnlyNumbers: \(String(describing: text.removeAllFormatting()))")
        print("LOG >> cleanText: \(cleanText)")
        print("LOG >> cleanText.count: \(cleanText.count)")
        print("LOG >> hasOnlyNumbers(self.cleanText)t: \(self.cleanText.hasOnlyNumbers())")
        
        if text.isEmail() {
            //  EMAIL VALIDO
            emailValidation(text)
        } else if self.cleanText.count == 11 && self.cleanText.hasOnlyNumbers() {
            //  CPF ou CELULAR
            if self.cleanText.isValidCPF() {
                //  CPF VALIDO
                cpfValidation()
            } else if self.cleanText.isValidPhone() {
                //  CELULAR VALIDO
                phoneValidation()
            } else {
                //  CPF E CELULAR INVALIDOS
                print("LOG >> NEM CPF | NEM CPNJ")
            }
        } else if self.cleanText.count == 14 && self.cleanText.hasOnlyNumbers() {
            if self.cleanText.isValidCNPJ() {
                //  CNPJ
                cnpjValidation()
            } else {
                //  "CNPJ INVALIDO"
                print("LOG >> CNPJ INVALIDO")
            }
        } else if self.cleanText.count == 32 {
            //  CHAVE ALEATORIA
            chaveAleatoriaValidation(text)
        } else {
            //  "CHAVE INVALIDA"
            chaveInvalidaValidation()
        }
    }
    
    private func emailValidation(_ text: String) {
        print("LOG >> EMAIL")
        if text.isValidEmail() {
            print("LOG >> EMAIL VALIDO")
        } else {
            print("LOG >> EMAIL INVALIDO")
        }
    }
    
    private func cpfValidation() {
        print("LOG >> CPF")
        if self.cleanText.isCPF() {
            self.setMask(self.cleanText.toCPFmask())
        } else {
            print("LOG >> CPF INVALIDO")
        }
    }
    
    private func cnpjValidation() {
        print("LOG >> CNPJ")
        self.setMask(self.cleanText.toCNPJmask())
    }
    
    private func phoneValidation() {
        print("LOG >> CELULAR")
        self.setMask(self.cleanText.toPhoneMask())
    }
    
    private func chaveAleatoriaValidation(_ text: String) {
        print("LOG >> CHAVE ALEATORIA")
        if text.isValidChaveAleatoria() {
            self.setMask(self.cleanText)
        } else {
            //  "Chave aleatória invalida"
            print("LOG >> CHAVE ALEATORIA INVALIDA")
        }
    }
    
    private func chaveInvalidaValidation() {
        print("LOG >> CHAVE INVALIDA")
        self.cleanText = self.cleanText.removeAllFormatting()
        self.nameField.text = self.cleanText
    }
    
    private func setMask(_ text: String) {
        print("setMask: \(text)")
        self.nameField.text = text
    }
    
    @objc func textFieldDidChange(_ text: UITextField) {
        self.onTextChanged(text.text ?? "")
    }
}
