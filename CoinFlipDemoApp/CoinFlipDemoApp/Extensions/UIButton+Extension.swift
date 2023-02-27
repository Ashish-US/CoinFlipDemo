//
//  UIButton+Extension.swift
//  CoinFlipDemoApp
//
//  Created by Ashish Singh on 2/26/23.
//

import UIKit

/*===================================================================================
 should be developed as reusable framework
 =====================================================================================*/

extension UIButton {
    static func create(with title: String, style: CoinFlipUIStyle) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)

        switch style {
        case .small:
            button.titleLabel?.font = .systemFont(ofSize: 20)
        case .normal:
            button.titleLabel?.font = .systemFont(ofSize: 25)
        case .large:
            button.titleLabel?.font = .systemFont(ofSize: 30)
        }
        return button
    }
}

