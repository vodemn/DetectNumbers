//
//  ViewController.swift
//  DetectNumbers
//
//  Created by Vadim Turko on 8/16/22.
//

import UIKit

class ViewController: UIViewController {
    
    let canvas = Canvas()
        
    let clearButton: UIButton = {
        let button  = UIButton(type: .system)
        button.backgroundColor = UIColor.systemBlue
        
        let image = UIImage(systemName: "trash")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 48).isActive = true
        return button
    }()
    
    let analyzeButton: UIButton = {
        let button  = UIButton(type: .roundedRect)
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 16
        button.setTitle("Analyze", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let fullLayout: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    let actionsLayout: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stack.distribution = .fillProportionally
        stack.spacing = 16
        return stack
    }()
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        view.addSubview(fullLayout)
        
        fullLayout.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.frame.width, height: view.safeAreaLayoutGuide.layoutFrame.height)
        actionsLayout.frame = CGRect(x: 0, y: view.frame.width, width: view.frame.width, height: 80)
        
        fullLayout.addSubview(canvas)
        fullLayout.addSubview(actionsLayout)
        actionsLayout.addArrangedSubview(analyzeButton)
        actionsLayout.addArrangedSubview(clearButton)
        
        canvas.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width)
        canvas.backgroundColor = .black
    }
}

