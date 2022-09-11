//
//  TextButton.swift
//  DetectNumbers
//
//  Created by Vadim Turko on 9/11/22.
//

import Foundation
import UIKit

class TextButton: UIButton {
    public convenience init(label: String) {
        self.init(type: .system)
        self.backgroundColor = kPrimaryColor
        self.layer.cornerRadius = kCornerRadius
        self.setTitle(label, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = .boldSystemFont(ofSize: 16)
    }
    
    override open var isUserInteractionEnabled: Bool {
        didSet {
            if isUserInteractionEnabled {
                backgroundColor = kPrimaryColor
            } else {
                backgroundColor = kDisabledColor
            }
        }
    }
}
