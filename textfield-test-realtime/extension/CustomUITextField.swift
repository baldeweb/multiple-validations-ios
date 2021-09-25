//
//  CustomUITextField.swift
//  textfield-test-realtime
//
//  Created by Wallace Baldenebre on 24/09/21.
//
import UIKit
import Foundation

class CustomUITextField: UITextField {
    var onDelete: ((String) -> Void)?
    
    override func deleteBackward() {
        self.onDelete!(text ?? "")
        super.deleteBackward()
    }
}
