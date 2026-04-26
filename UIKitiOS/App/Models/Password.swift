//
//  Password.swift
//  UIKitiOS
//
//  Created by Isabella Viksten on 2026-04-24.
//

struct Password {
    let value: String
    init(_ string: String, minimum: Int) throws {
        guard string.count >= minimum else {
            throw ValidationError.invalidPassword
        }
        self.value = string
    }
}
