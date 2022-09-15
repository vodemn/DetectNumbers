//
//  ImagePixelData.swift
//  DetectNumbers
//
//  Created by Vadim Turko on 9/13/22.
//

import DetectNumbersCore
import Foundation
import UIKit

extension UIImage {
    var pixelDataGrayScale: Matrix {
        let bmp = self.cgImage!.dataProvider!.data
        var data: UnsafePointer<UInt8> = CFDataGetBytePtr(bmp)
        var r, g, b: UInt8
        var gs: Double
        var pixels = [Double]()
        for _ in 0 ..< Int(self.size.width) {
            for _ in 0 ..< Int(self.size.height) {
                r = data.pointee
                data = data.advanced(by: 1)
                g = data.pointee
                data = data.advanced(by: 1)
                b = data.pointee
                data = data.advanced(by: 1)
                //a = data.pointee
                data = data.advanced(by: 1)
                gs = (Double(r) + Double(g) + Double(b)) / (3 * 255)
                pixels.append(gs)
            }
        }
        return Matrix(from: pixels, shape: (Int(self.size.height), Int(self.size.width)))
    }
}
