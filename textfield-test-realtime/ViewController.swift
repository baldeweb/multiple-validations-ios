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
        self.cleanText = text?.getOnlyNumbers() ?? ""
        
        print(" ")
        print("LOG >> onTextChanged: \(text ?? "")")
        print("LOG >> getOnlyNumbers: \(String(describing: text?.getOnlyNumbers()))")
        print("LOG >> cleanText: \(cleanText)")
        print("LOG >> cleanText.count: \(cleanText.count)")
        print("LOG >> hasOnlyNumbers(self.cleanText)t: \(self.cleanText.hasOnlyNumbers())")
        
        if EmailMask().isEmail(text ?? "") {
            if EmailMask().isValidEmail(text ?? "") {
                print("LOG >> EMAIL")
            } else {
                print("LOG >> EMAIL INVALIDO")
            }
        } else if self.cleanText.count == 11 && self.cleanText.hasOnlyNumbers() {
            //  CPF ou CELULAR
            if CPFMask().isCPF(self.cleanText) && CPFMask().isValidCPF(self.cleanText) {
                print("LOG >> CPF")
                self.filledText = CPFMask().mask(self.cleanText)
                self.setMask(self.filledText)
            } else if PhoneMask().isPhone(self.cleanText) {
                print("LOG >> CELULAR")
                self.filledText = PhoneMask().mask(self.cleanText)
                self.setMask(self.filledText)
            } else {
                print("LOG >> NEM CPF | NEM CPNJ")
            }
        } else if self.cleanText.count == 14 && self.cleanText.hasOnlyNumbers() {
            if CNPJMask().isCNPJ(self.cleanText) {
                //  CNPJ
                print("LOG >> CNPJ")
                self.filledText = CNPJMask().mask(self.cleanText)
                self.setMask(self.filledText)
            } else {
                //  "CNPJ invalido"
                print("LOG >> CNPJ INVALIDO")
            }
        } else if self.cleanText.count == 32 {
            //  CHAVE ALEATORIA
            if ChaveAleatoriaMask().isValid(text ?? "") {
                print("LOG >> CHAVE ALEATORIA")
                self.filledText = self.cleanText
            } else {
                //  "Chave aleatória invalida"
                print("LOG >> CHAVE ALEATORIA INVALIDA")
            }
        } else {
            //  "Chave invalida"
            print("LOG >> CHAVE INVALIDA")
            self.cleanText = self.cleanText.getOnlyNumbers()
            self.nameField.text = self.cleanText
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
