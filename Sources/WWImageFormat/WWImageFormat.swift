//
//  WWImageFormat.swift
//  WWImageFormat
//
//  Created by William.Weng on 2025/6/23.
//

import UIKit

// MARK: - 解析圖片資料格式
open class WWImageFormat {
    
    public static let shared = WWImageFormat()
}

// MARK: - 公開函式
public extension WWImageFormat {
    
    /// 解析圖片格式 + 是否為動畫
    /// - Parameter data: 圖片資料
    /// - Returns: WWImageFormat.ImageDataFormat?
    func parseData(_ data: Data?) -> WWImageFormat.ImageDataFormat? {
        return data?._imageDataFormat()
    }
}
