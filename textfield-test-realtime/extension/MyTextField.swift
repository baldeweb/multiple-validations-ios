//
//  MyTextField.swift
//  textfield-test-realtime
//
//  Created by Wallace on 14/09/21.
//

import Foundation
import UIKit

class MyTextField: UITextField {
    var textTyped: (String) -> Void?
    
    init(textType: (String) -> Void?) {
        self.textTyped = textTyped
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func deleteBackward() {
        self.textTyped(text ?? "")
        super.deleteBackward()
    }
}
