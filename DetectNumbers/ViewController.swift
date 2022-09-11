//
//  ViewController.swift
//  DetectNumbers
//
//  Created by Vadim Turko on 8/16/22.
//

import UIKit

class ViewController: UIViewController {
    
    let canvas: Canvas = Canvas()
    
    let clearButton: ClearButton = {
        let button  = ClearButton()
        button.addTarget(self, action: #selector(clear), for: .touchDown)
        button.widthAnchor.constraint(equalToConstant: 48).isActive = true
        return button
    }()
    
    @objc fileprivate func clear(_ sender: UIButton!) {
        canvas.clear()
        sender.isUserInteractionEnabled = false
    }
    
    let analyzeButton: UIButton = {
        let button  = UIButton(type: .roundedRect)
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 16
        button.setTitle("Analyze", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return button
    }()
    
    let fullLayout: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stack.spacing = 16
        return stack
    }()
    
    let actionsLayout: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.heightAnchor.constraint(equalToConstant: 48).isActive = true
        return stack
    }()
    
    let spacer: UIView = {
        let stretchingView = UIView()
        stretchingView.backgroundColor = UIColor.clear
        return stretchingView
    }()
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        view.addSubview(fullLayout)
        
        canvas.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        actionsLayout.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        spacer.setContentHuggingPriority(UILayoutPriority(0), for: .vertical)
        
        fullLayout.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.frame.width, height: view.safeAreaLayoutGuide.layoutFrame.height)
        canvas.heightAnchor.constraint(equalToConstant: view.frame.width - fullLayout.layoutMargins.left - fullLayout.layoutMargins.right).isActive = true
        
        fullLayout.addArrangedSubview(canvas)
        fullLayout.addArrangedSubview(actionsLayout)
        fullLayout.addArrangedSubview(spacer)
        
        actionsLayout.addArrangedSubview(analyzeButton)
        actionsLayout.addArrangedSubview(clearButton)
    }
}

