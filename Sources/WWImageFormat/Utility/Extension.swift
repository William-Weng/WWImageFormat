//
//  Extension.swift
//  WWImageFormat
//
//  Created by William.Weng on 2025/6/23.
//

import Foundation

// MARK: - Collection (override function)
extension Collection {

    /// [為Array加上安全取值特性 => nil](https://stackoverflow.com/questions/25329186/safe-bounds-checked-array-lookup-in-swift-through-optional-bindings)
    subscript(safe index: Index) -> Element? { return indices.contains(index) ? self[index] : nil }
}

// MARK: - Data (function)
extension Data {
    
    /// 根據ImageHeader找出相對應的圖片Type (jpeg / png / gif) => 一個一個試，找到就結束 => 二進位型圖片
    /// - Parameter data: 圖片資料
    /// - Returns: Constant.ImageDataFormat?
    func _imageFormat() -> WWImageFormat.ImageFormat? {
        
        let imageDataArray = lazy.map({$0})
        let allCases = WWImageFormat.ImageFormat.allCases
        let dataCount = imageDataArray.count
        
        var imageType: WWImageFormat.ImageFormat? = nil
        
        allCases.forEach { (type) in
            
            let imageHeader = type.header
                        
            if (dataCount < imageHeader.count) { imageType = nil; return }
            if (imageType != nil) { return }
            
            for index in 0..<imageHeader.count {
                
                let headerHexNumber = imageHeader[index]
                
                if (headerHexNumber == 0x00) { continue }
                if (imageDataArray[index] != headerHexNumber) { imageType = nil; return }
                imageType = type
            }
        }
        
        return imageType
    }
    
    /// 根據ImageHeader找出相對應的圖片Type (jpeg / png / gif) => 一個一個試，找到就結束 => 二進位型圖片
    /// - Parameter data: 圖片資料
    /// - Returns: Constant.ImageDataFormat?
    func _imageDataFormat() -> WWImageFormat.ImageDataFormat? {
        
        guard let imageType = _imageFormat() else { return nil }
        
        switch imageType {
        case .gif: return (imageType, _isAnimatedGIF())
        case .png: return (imageType, _isAnimatedPNG())
        case .webp: return (imageType, _isAnimatedWebP())
        default: return (imageType, false)
        }
    }
}

// MARK: - Data (private function)
private extension Data {
    
    /// [測試是不是動畫的GIF？ => 搜尋frmae是不是只有一個](https://realnewbie.com/coding/basic-concent/jpg-png-apng-gif-svg/)
    func _isAnimatedGIF() -> Bool {

        let bytes = lazy.map({$0})
        let extensionBlock: UInt8 = 0x21
        
        var frames = 0
        var position = 13

        while position < bytes.count {
            
            if bytes[position] == extensionBlock { frames += 1 }
            position += 1
            if (frames > 1) { return true }
        }
        
        return false
    }
    
    /// [測試是不是apng？ => 搜尋acTL區塊](https://www.silencetime.com/index.php/archives/74/)
    /// - Returns: Bool
    func _isAnimatedPNG() -> Bool {
        
        let acTLBytes: [UInt8] = [0x61, 0x63, 0x54, 0x4C]
        let acTLBytesSize = acTLBytes.count
        let bytes = lazy.map({$0})
        
        if (bytes.count < acTLBytesSize) { return false }
        
        for index in 0..<(bytes.count - acTLBytesSize) {
            
            if let acTLByte0 = acTLBytes[safe: 0], let byte0 = bytes[safe: index + 0] { if (acTLByte0 != byte0) { continue }}
            if let acTLByte1 = acTLBytes[safe: 1], let byte1 = bytes[safe: index + 1] { if (acTLByte1 != byte1) { continue }}
            if let acTLByte2 = acTLBytes[safe: 2], let byte2 = bytes[safe: index + 2] { if (acTLByte2 != byte2) { continue }}
            if let acTLByte3 = acTLBytes[safe: 3], let byte3 = bytes[safe: index + 3] { if (acTLByte3 != byte3) { continue }}
            
            return true
        }

        return false
    }
    
    /// [測試是不是動畫的WebP？ => 搜尋AMIN區塊](https://tw.bandisoft.com/honeycam/webp/webp-pros/)
    func _isAnimatedWebP() -> Bool {
        
        let AMINBytes: [UInt8] = [0x41, 0x4E, 0x49, 0x4D]
        let AMINBytesSize = AMINBytes.count
        let bytes = lazy.map({$0})
        
        if (bytes.count < AMINBytesSize) { return false }
        
        for index in 0..<(bytes.count - AMINBytesSize) {
            
            if let AMINByte0 = AMINBytes[safe: 0], let byte0 = bytes[safe: index + 0] { if (AMINByte0 != byte0) { continue }}
            if let AMINByte1 = AMINBytes[safe: 1], let byte1 = bytes[safe: index + 1] { if (AMINByte1 != byte1) { continue }}
            if let AMINByte2 = AMINBytes[safe: 2], let byte2 = bytes[safe: index + 2] { if (AMINByte2 != byte2) { continue }}
            if let AMINByte3 = AMINBytes[safe: 3], let byte3 = bytes[safe: index + 3] { if (AMINByte3 != byte3) { continue }}
            
            return true
        }

        return false
    }
}
