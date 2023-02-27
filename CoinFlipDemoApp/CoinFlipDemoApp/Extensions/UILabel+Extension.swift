//
//  UILabel+Extension.swift
//  CoinFlipDemoApp
//
//  Created by Ashish Singh on 2/26/23.
//

import UIKit

/*===================================================================================
 should be developed as reusable framework
 =====================================================================================*/

enum CoinFlipUIStyle {
    case small(color: UIColor = .white)
    case normal(color: UIColor = .white)
    case large(color: UIColor = .white)
}

extension UILabel {
    static func create(with title: String, style: CoinFlipUIStyle) -> UILabel {
        let label = UILabel()
        label.text = title
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        switch style {
        case .small(let color):
            label.textColor = color
            label.font = .systemFont(ofSize: 20)
        case .normal(let color):
            label.textColor = color
            label.font = .systemFont(ofSize: 25)
        case .large(let color):
            label.textColor = color
            label.font = .systemFont(ofSize: 30)
        }
        return label
    }
}

