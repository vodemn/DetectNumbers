//
//  ImagePixelData.swift
//  DetectNumbers
//
//  Created by Vadim Turko on 9/13/22.
//

import DetectNumbersCore
import Foundation
import UIKit

extension CGImage {
    func pixelValues() -> [UInt8]
    {
        var pixelValues: [UInt8]
        var intensities = [UInt8](repeating: 0, count: self.height * self.width)
        let contextRef = CGContext(
            data: &intensities,
            width: self.width,
            height: self.height,
            bitsPerComponent: self.bitsPerComponent,
            bytesPerRow: self.width,
            space: CGColorSpaceCreateDeviceGray(),
            bitmapInfo: 0)
        contextRef?.draw(self, in: CGRect(x: 0.0, y: 0.0, width: CGFloat(self.width), height: CGFloat(self.height)))
        pixelValues = intensities
        
        return pixelValues
    }
}
