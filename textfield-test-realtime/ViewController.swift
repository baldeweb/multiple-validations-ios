//
//  ViewController.swift
//  textfield-test-realtime
//
//  Created by Wallace on 14/09/21.
//

import UIKit

class ViewController: UIViewController {

    private var filledText = ""
    private var cleanText = ""
    
    @IBOutlet weak var nameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    func onTextChanged(_ text: String?) {
        self.cleanText = text?.removeAllFormatting() ?? ""
        
        //  TODO: validar com Regex, se for qualquer numero sequencial, ja dar um return
        
        print(" ")
        print("LOG >> onTextChanged: \(text ?? "")")
        print("LOG >> getOnlyNumbers: \(String(describing: text?.removeAllFormatting()))")
        print("LOG >> cleanText: \(cleanText)")
        print("LOG >> cleanText.count: \(cleanText.count)")
        print("LOG >> hasOnlyNumbers(self.cleanText)t: \(self.cleanText.hasOnlyNumbers())")
        
        if (text ?? "").isEmail() {
            emailValidation(text ?? "")
        } else if self.cleanText.count == 11 && self.cleanText.hasOnlyNumbers() {
            //  CPF ou CELULAR
            if self.cleanText.isValidCPF() {
                cpfValidation()
            } else if self.cleanText.isValidPhone() {
                phoneValidation()
            } else {
                print("LOG >> NEM CPF | NEM CPNJ")
            }
        } else if self.cleanText.count == 14 && self.cleanText.hasOnlyNumbers() {
            if self.cleanText.isValidCNPJ() {
                //  CNPJ
                cnpjValidation()
            } else {
                //  "CNPJ invalido"
                print("LOG >> CNPJ INVALIDO")
            }
        } else if self.cleanText.count == 32 {
            //  CHAVE ALEATORIA
            chaveAleatoriaValidation(text ?? "")
        } else {
            //  "Chave invalida"
            print("LOG >> CHAVE INVALIDA")
            self.cleanText = self.cleanText.removeAllFormatting()
            self.nameField.text = self.cleanText
        }
    }
    
    private func emailValidation(_ text: String?) {
        if (text ?? "").isValidEmail() {
            print("LOG >> EMAIL")
        } else {
            print("LOG >> EMAIL INVALIDO")
        }
    }
    
    private func cpfValidation() {
        print("LOG >> CPF")
        if self.cleanText.isCPF() {
            self.filledText = self.cleanText.toCPFmask()
            self.setMask(self.filledText)
        } else {
            print("LOG >> CPF INVALIDO")
        }
    }
    
    private func cnpjValidation() {
        print("LOG >> CNPJ")
        self.filledText = self.cleanText.toCNPJmask()
        self.setMask(self.filledText)
    }
    
    private func phoneValidation() {
        print("LOG >> CELULAR")
        self.filledText = self.cleanText.toPhoneMask()
        self.setMask(self.filledText)
    }
    
    private func chaveAleatoriaValidation(_ text: String) {
        print("LOG >> CHAVE ALEATORIA")
        if (text).isValidChaveAleatoria() {
            self.filledText = self.cleanText
        } else {
            //  "Chave aleatória invalida"
            print("LOG >> CHAVE ALEATORIA INVALIDA")
        }
    }
    
    private func setMask(_ text: String) {
        print("setMask: \(text)")
        self.nameField.text = text
    }
    
    @objc func textFieldDidChange(_ text: UITextField) {
        self.onTextChanged(text.text ?? "")
    }
}
