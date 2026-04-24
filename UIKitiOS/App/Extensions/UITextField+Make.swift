//
//  UITextField+Make.swift
//  UIKitiOS
//
//  Created by Isabella Viksten on 2026-04-24.
//

import Foundation
import UIKit

extension UITextField {
    static func make(
        placeholderL10NKey: LocalizedStringResource,
        keyboardType: UIKeyboardType = .default,
        isSecureTextEntry: Bool = true,
        onEditingDidBegin: @escaping (UITextField) -> Void,
        onEditingChanged: @escaping (String) -> Void,
        onEndEditing: @escaping (UITextField, String) -> Void
    ) -> UITextField {
        let textField = UITextField()
        textField.keyboardType = keyboardType
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = isSecureTextEntry
        textField.placeholder = String(localized: placeholderL10NKey)
        textField.addAction(UIAction { _ in onEditingDidBegin(textField) }, for: .editingDidBegin)
        textField.addAction(UIAction { _ in onEditingChanged(textField.text ?? "") }, for: .editingChanged)
        textField.addAction(UIAction { _ in onEndEditing(textField, textField.text ?? "") }, for: .editingDidEnd)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
}

