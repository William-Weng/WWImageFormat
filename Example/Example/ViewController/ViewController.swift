//
//  ViewController.swift
//  Example
//
//  Created by William.Weng on 2025/6/23.
//

import UIKit
import WWImageFormat

// MARK: - ViewController
final class ViewController: UIViewController {

    @IBOutlet weak var formatLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    private let images = ["ハチワレ.jpg", "bilibili.gif", "うさぎ.png"]
    
    @IBAction func parseImageFormat(_ sender: UIButton) {
        
        guard let url = Bundle.main.url(forResource: images[sender.tag], withExtension: nil),
              let imageData = try? Data.init(contentsOf: url),
              let format = WWImageFormat.shared.parseData(imageData)
        else {
            return
        }
        
        imageView.image = UIImage(data: imageData)
        formatLabel.text = "format: \(format.format), isAnimated: \(format.isAnimated)"
    }
}
