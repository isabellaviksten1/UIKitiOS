//
//  UILabel+ErrorLabel.swift
//  UIKitiOS
//
//  Created by Isabella Viksten on 2026-04-24.
//

import Foundation
import UIKit

extension UILabel {
    static func makeErrorLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .systemRed
        label.font = .preferredFont(forTextStyle: .caption1)
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
