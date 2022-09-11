//
//  ClearButton.swift
//  DetectNumbers
//
//  Created by Vadim Turko on 9/7/22.
//

import Foundation
import UIKit

class ClearButton: UIButton {
    public convenience init() {
        self.init(type: .system)
        backgroundColor = kPrimaryColor
        layer.cornerRadius = kCornerRadius
        setImage(
            UIImage(systemName: "trash")?.withTintColor(.white, renderingMode: .alwaysOriginal),
            for: .normal
        )
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
