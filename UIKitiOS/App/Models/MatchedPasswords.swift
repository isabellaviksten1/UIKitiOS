//
//  MatchingPassword.swift
//  UIKitiOS
//
//  Created by Isabella Viksten on 2026-04-24.
//

import Foundation

struct MatchedPasswords {
    let value: String
    init(_ password: String, _ confirmation: String) throws {
        guard password == confirmation else {
            throw ValidationError.passwordMismatch
        }
        self.value = password
    }
}
