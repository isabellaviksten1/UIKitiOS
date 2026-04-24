//
//  Password.swift
//  UIKitiOS
//
//  Created by Isabella Viksten on 2026-04-24.
//

struct Password {
    let value: String
    init(_ string: String) throws {
        guard string.count >= 8 else {
            throw ValidationError.invalidEmail
        }
        self.value = string
    }
}
