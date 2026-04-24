//
//  Email.swift
//  UIKitiOS
//
//  Created by Isabella Viksten on 2026-04-24.
//

import Foundation

struct Email {
    let value: String
    init(_ string: String) throws {
        let regex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        guard NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: string) else {
            throw ValidationError.invalidEmail
    }
        self.value = string
    }
}
