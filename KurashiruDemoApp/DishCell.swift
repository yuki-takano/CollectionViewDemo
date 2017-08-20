//
//  DishCell.swift
//  KurashiruDemoApp
//
//  Created by TakanoYuki on 2017/08/19.
//  Copyright © 2017年 TakanoYuki. All rights reserved.
//

import UIKit
import SDWebImage

class DishCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleHeightConstraint: NSLayoutConstraint!
    // 文字列とセルの左右、下部とのマージン
    let kSpaceMargen: CGFloat = 8.0
    let kOneLineHeight: CGFloat = 15
    let kLineSpace: CGFloat = 4.0
    
    func setData(title: String, url: String) {
        imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "no_image"))
        titleLabel.textAlignment = .justified
        
        let font = UIFont(name: "HiraKakuProN-W6", size: 13)
        let lineNum = self.getSuitLineNum(title, font: font!)
        let titleHeight = self.getSuitLineHeight(lineNum: lineNum)
        titleHeightConstraint.constant = titleHeight

        let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.lineSpacing = lineNum > 1 ? kLineSpace : 0
        let attributeDic: [String: Any]? = [NSParagraphStyleAttributeName: paragraphStyle]
        
        titleLabel.attributedText = NSAttributedString(
            string: title, attributes: attributeDic)
    }
    
    private func getSuitLineNum(_ text: String, font: UIFont) -> Int {
        let width = self.frame.size.width - kSpaceMargen * 2
        // 様々な方法を模索した結果、NSStringのメソッドを使うと正しい結果を得られる事がわかったため、あえてNSStringを使いました。。
        let suitSize = (text as NSString).size(attributes: [NSFontAttributeName: font])
        return Int(suitSize.width / width) + 1
    }
    
    // 3行以上になる場合、2行以降は表示しないようにするためのメソッド
    private func getSuitLineHeight(lineNum: Int) -> CGFloat {
        if lineNum <= 2 {
            return CGFloat(lineNum) * kOneLineHeight + kLineSpace
        }
        return 2 * kOneLineHeight + kLineSpace
    }
}

