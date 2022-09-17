//
//  CompressCanvas.swift
//  DetectNumbers
//
//  Created by Vadim Turko on 9/17/22.
//

import Foundation

extension Canvas {
    func compress(targetSize: (rows: Int, columns: Int)) -> [Double] {
        let pixels = self.bitmap()
        //
        // `Core` needs less resolution, than canvas provides. So we have to determine
        // the bigget possible size.
        //
        // Example:
        // let canvasSize = (358, 358)
        // let coreInputSize = (16, 16)
        // let maxSize = (352, 352)
        //
        let chunkRows = Int(pixels.rows / targetSize.rows)
        let maxResultRows: Int = chunkRows * targetSize.rows
        let rowsOffset = Int((pixels.rows - maxResultRows) / 2)
        
        let chunkColumns = Int(pixels.rows / targetSize.columns)
        let maxResultColumns: Int = chunkColumns * targetSize.columns
        let columnsOffset = Int((pixels.columns - maxResultColumns) / 2)
        
        let cropped = pixels[rowsOffset..<(maxResultRows + rowsOffset)]
            .transposed()[columnsOffset..<(maxResultColumns + columnsOffset)]
            .transposed()
        
        var compressed: [Double] = []
        for row in 0..<targetSize.rows {
            let rowsChunkStart = row * chunkRows
            let uncompressedRow: [Double] = cropped[rowsChunkStart..<(rowsChunkStart + chunkRows)].transposed().values
            let chunks = uncompressedRow.chunked(into: chunkRows * chunkColumns)
            
            for chunk in chunks {
                let reduced = chunk.reduce(0, +) / Double(chunk.endIndex)
                compressed.append(reduced)
            }
        }
        return compressed
    }
}
