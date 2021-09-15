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
        
        //self.nameField.addTarget(self, action: #selector(beforeTextFieldDidChange(_:)), for: .editingDidBegin)
        self.nameField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
//    func beforeTextChanged(_ text: String?) {
//        print("beforeTextChanged >> text?.count: \(text?.count ?? 0) | filledText?.count: \(self.filledText.count ?? 0)")
//    }
    
    func onTextChanged(_ text: String?) {
        self.cleanText = self.getOnlyNumbers(text ?? "")
        
        print(" ")
        print("LOG >> onTextChanged: \(text ?? "")")
        print("LOG >> getOnlyNumbers: \(self.getOnlyNumbers(text ?? ""))")
        print("LOG >> cleanText: \(cleanText)")
        print("LOG >> cleanText.count: \(cleanText.count)")
        print("LOG >> hasOnlyNumbers(self.cleanText)t: \(self.hasOnlyNumbers(self.cleanText))")
        
        if self.cleanText.count == 11 && self.hasOnlyNumbers(self.cleanText) {
            //  CPF ou CELULAR
            if PhoneMask().isPhone(self.cleanText) && PhoneMask().isValidPhone(self.cleanText){
                print("LOG >> CELULAR")
                self.filledText = PhoneMask().mask(self.cleanText)
                self.setMask(self.filledText)
            } else if CPFMask().isCPF(self.cleanText) && CPFMask().isValidCPF(self.cleanText) {
                print("LOG >> CPF")
                self.filledText = CPFMask().mask(self.cleanText)
                self.setMask(self.filledText)
            } else {
                print("LOG >> NEM CPF | NEM CPNJ")
            }
        } else if self.cleanText.count == 14 && self.hasOnlyNumbers(self.cleanText) {
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
            if self.hasLettersOrNumbers(text ?? "") {
                print("LOG >> CHAVE ALEATORIA")
                self.filledText = self.cleanText
            } else {
                //  "Chave aleatória invalida"
                print("LOG >> CHAVE ALEATORIA INVALIDA")
            }
        } else {
            //  "Chave invalida"
            print("LOG >> CHAVE INVALIDA")
            self.cleanText = self.getOnlyNumbers(text ?? "")
            self.nameField.text = self.cleanText
        }
    }
    
    func getOnlyNumbers(_ text: String) -> String {
        var textUnmasked = text.replacingOccurrences(of: ".", with: "")
        textUnmasked = textUnmasked.replacingOccurrences(of: "-", with: "")
        textUnmasked = textUnmasked.replacingOccurrences(of: "/", with: "")
        textUnmasked = textUnmasked.replacingOccurrences(of: "(", with: "")
        textUnmasked = textUnmasked.replacingOccurrences(of: " ", with: "")
        textUnmasked = textUnmasked.replacingOccurrences(of: "+", with: "")
        textUnmasked = textUnmasked.replacingOccurrences(of: ")", with: "")
        return textUnmasked
    }
    
    private func setMask(_ text: String) {
        print("setMask: \(text)")
        self.nameField.text = text
    }
    
    func hasLetters(_ text: String) -> Bool {
        return !text.filter { $0.isLetter }.isEmpty
    }
    
    func hasNumbers(_ text: String) -> Bool {
        return !text.filter { $0.isNumber }.isEmpty
    }
    
    func hasLettersOrNumbers(_ text: String) -> Bool {
        return self.hasLetters(text) || self.hasNumbers(text)
    }
    
    func hasOnlyNumbers(_ text: String) -> Bool {
        return hasNumbers(self.getOnlyNumbers(text))
    }
    
    @objc func textFieldDidChange(_ text: UITextField) {
        //print("DIGITADO: \(text.text ?? "")")
        //self.beforeTextChanged(text.text ?? "")
        self.onTextChanged(text.text ?? "")
    }
    
    @objc func beforeTextFieldDidChange(_ text: UITextField) {
       // self.beforeTextChanged(text.text ?? "")
    }
}
