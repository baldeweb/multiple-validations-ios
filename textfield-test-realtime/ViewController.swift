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
    private var isDeleting = false
    private var isRunning = false
    private var shouldNotValidation = false
    
    @IBOutlet weak var nameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            UIWindow.init().overrideUserInterfaceStyle = .light
        }
        //self.nameField.addTarget(self, action: #selector(beforeTextFieldDidChange(_:)), for: .editingDidBegin)
        self.nameField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    func beforeTextChanged(_ text: String?) {
        self.isDeleting = self.filledText.count > (text?.count ?? 0)
        print("beforeTextChanged >> isDeleting: \(isDeleting) | text?.count: \(text?.count ?? 0) | filledText?.count: \(self.filledText.count ?? 0)")
        if text != nil {
            self.shouldNotValidation = (text?.count ?? 0) < 10
        }
    }
    
    func onTextChanged(_ text: String?) {
        print(" ")
        print("onTextChanged: \(text ?? "")")
        //beforeTextChanged(text)
        self.cleanText = self.getOnlyNumbers(text ?? "")
        print("getOnlyNumbers: \(self.getOnlyNumbers(text ?? ""))")

        //  Controle de thread
        print("isDeleting: \(isDeleting)")
        if self.isDeleting {
            print("self.cleanTex: \(self.cleanText)")
            self.setMask(self.cleanText)
            return
        }
        
        print("isRunning: \(self.isRunning)")
        if self.isRunning {
            return
        }
        
        print("shouldNotValidation: \(self.shouldNotValidation)")
        if self.shouldNotValidation {
            if self.cleanText.count != text?.count {
                self.setMask(self.cleanText)
            }
            return
        }

        self.isRunning = true
        
        print("cleanText: \(cleanText)")
        print("cleanText.count: \(cleanText.count)")
        print("hasOnlyNumbers(self.cleanText)t: \(self.hasOnlyNumbers(self.cleanText))")
        if self.cleanText.count == 11 && self.hasOnlyNumbers(self.cleanText) {
            //  CPF ou CELULAR
            if CPFMask().isCPF(self.cleanText) {
                //  CPF
                print("LOG >> CPF")
                self.filledText = CPFMask().mask(self.cleanText)
                self.setMask(self.filledText)
            } else if PhoneMask().isPhone(self.cleanText) {
                //  CELULAR
                print("LOG >> CELULAR")
                self.filledText = PhoneMask().mask(self.cleanText)
                self.setMask(self.filledText)
            }
        } else if self.cleanText.count == 12 {
            self.setMask(self.cleanText)
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
        } else if self.cleanText.count == 15 {
            self.setMask(self.cleanText)
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
        isRunning = false;
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
        self.beforeTextChanged(text.text ?? "")
    }
}
