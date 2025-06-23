//
//  Constant.swift
//  WWImageFormat
//
//  Created by William.Weng on 2025/6/23.
//

import Foundation

// MARK: - typealias
public extension WWImageFormat {
    
    typealias ImageDataFormat = (format: ImageFormat, isAnimated: Bool)     // 圖片資料類型 (圖片樣式 / 是否為動畫)
}

// MARK: - enum
public extension WWImageFormat {
        
    /// 圖片的Data開頭辨識字元
    enum ImageFormat: CaseIterable {
        
        var header: [UInt8] { return headerMaker() }
        
        case icon
        case png
        case jpeg
        case gif
        case webp
        case bmp
        case heic
        case avif
        case pdf
        
        /// [圖片的文件標頭檔 (要看各圖檔的文件)](https://github.com/MROS/jpeg_tutorial)
        /// - Returns: [UInt8]
        private func headerMaker() -> [UInt8] {
            
            switch self {
            case .icon: return [0x00, 0x00, 0x01, 0x00]
            case .png: return [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A]
            case .jpeg: return [0xFF, 0xD8, 0xFF]
            case .gif: return [0x47, 0x49, 0x46]
            case .webp: return [0x52, 0x49, 0x46, 0x46, 0x00, 0x00, 0x00, 0x00, 0x57, 0x45, 0x42, 0x50]
            case .bmp:  return [0x42, 0x4D]
            case .heic: return [0x00, 0x00, 0x00, 0x00, 0x66, 0x74, 0x79, 0x70, 0x68, 0x65, 0x69, 0x63]
            case .avif: return [0x00, 0x00, 0x00, 0x00, 0x66, 0x74, 0x79, 0x70, 0x61, 0x76, 0x69, 0x66]
            case .pdf: return [0x25, 0x50, 0x44, 0x46]
            }
        }
    }
}
