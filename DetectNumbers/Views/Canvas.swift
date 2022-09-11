//
//  Canvas.swift
//  DetectNumbers
//
//  Created by Vadim Turko on 8/16/22.
//

import Foundation
import RxSwift
import UIKit

typealias CanvasController = BehaviorSubject<CanvasState>

class Canvas: UIView {
    let controller: CanvasController
    var lines = [[CGPoint]]()
    
    init(controller: CanvasController) {
        self.controller = controller
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        backgroundColor = .black
        clipsToBounds = true
        layer.cornerRadius = kCornerRadius
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.setStrokeColor(UIColor.white.cgColor)
        context.setLineWidth(16)
        context.setLineCap(.round)
        
        lines.forEach {
            l in for (i, p) in l.enumerated() {
                if (i == 0) {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
        }
        
        context.strokePath()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]())
        controller.onNext(CanvasState(hasLines: true))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else { return }
        guard var lastLine = lines.popLast() else { return }
        lastLine.append(point)
        lines.append(lastLine)
        
        setNeedsDisplay()
    }
    
    func clear() {
        lines.removeAll()
        controller.onNext(CanvasState(hasLines: false))
        setNeedsDisplay()
    }
}
