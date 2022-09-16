//
//  ViewController.swift
//  DetectNumbers
//
//  Created by Vadim Turko on 8/16/22.
//

import UIKit
import DetectNumbersCore
import RxSwift

class ViewController: UIViewController {
    
    let core = DetectNumbersCore()
    
    let canvasController = CanvasController(value: CanvasState())
    lazy var canvas: Canvas = Canvas(controller: canvasController)
    let disposer = DisposeBag()
    
    let clearButton: ClearButton = {
        let button  = ClearButton()
        button.addTarget(self, action: #selector(clear), for: .touchDown)
        button.widthAnchor.constraint(equalToConstant: 48).isActive = true
        return button
    }()
    
    @objc fileprivate func clear(_ sender: UIButton!) {
        canvas.clear()
    }
    
    let analyzeButton: TextButton = {
        let button = TextButton(label: "Analyze")
        button.addTarget(self, action: #selector(gitbitmap), for: .touchDown)
        return button
    }()
    
    @objc fileprivate func gitbitmap(_ sender: UIButton!) {
        let pixels = canvas.bitmap()
        //
        // `Core` needs less resolution, than canvas provides. So we have to determine
        // the bigget possible size.
        //
        // Example:
        // let canvasSize = (358, 358)
        // let coreInputSize = (16, 16)
        // let maxSize = (352, 352)
        //
        let chunkRows = Int(pixels.rows / core.inputSize.0)
        let maxResultRows: Int = chunkRows * core.inputSize.0
        let rowsOffset = Int((pixels.rows - maxResultRows) / 2)
        
        let chunkColumns = Int(pixels.rows / core.inputSize.1)
        let maxResultColumns: Int = chunkColumns * core.inputSize.1
        let columnsOffset = Int((pixels.columns - maxResultColumns) / 2)
        
        let cropped = pixels[rowsOffset..<(maxResultRows + rowsOffset)]
            .transposed()[columnsOffset..<(maxResultColumns + columnsOffset)]
            .transposed()
        
        // All fine before compression
        var compressed: [Double] = []
        for row in 0..<core.inputSize.0 {
            let rowsChunkStart = row * core.inputSize.0
            let uncompressedRow: [Double] = cropped[rowsChunkStart..<(rowsChunkStart + chunkRows)].transposed().values
            let chunks = uncompressedRow.chunked(into: chunkRows * chunkColumns)
            
            for chunk in chunks {
                let reduced = chunk.reduce(0, +) / Double(chunk.endIndex)
                compressed.append(reduced)
            }
        }
        print(compressed)
    }
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        canvasController.subscribe(onNext: {state in
            self.analyzeButton.isUserInteractionEnabled = state.hasLines
            self.clearButton.isUserInteractionEnabled = state.hasLines
        }).disposed(by: disposer)
    }
    
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

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
