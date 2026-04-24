//
//  SignupValidator.swift
//  UIKitiOS
//
//  Created by Isabella Viksten on 2026-04-24.
//

enum ValidationError: String, Error {
    case invalidEmail = "HC: Invalid email"
    case invalidPassword = "HC: Invalid password, must be at least 8 characters"
    case passwordMismatch = "HC: Passwords do not match"

    var message: String { rawValue }
}

struct SignupValidator {
    var email: String = ""
    var password: String = ""
    var passwordConfirmation: String = ""

    var errors: [ValidationError] {
        var errors: [ValidationError] = []
        if (try? Email(email)) == nil                                    { errors.append(.invalidEmail) }
        if (try? Password(password)) == nil                              { errors.append(.invalidPassword) }
        if (try? MatchedPasswords(password, passwordConfirmation)) == nil { errors.append(.passwordMismatch) }
        return errors
    }

    var canEnterConfirmPassword: Bool {
        (try? Password(password)) != nil
    }

    var canSignUp: Bool {
        errors.isEmpty
    }
}
