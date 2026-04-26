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

struct SignupValidationOutcome {
    let errors: [ValidationError]

    var canSignUp: Bool { errors.isEmpty }
    var canEnterConfirmPassword: Bool { !errors.contains(.invalidPassword) }
}

struct SignupValidator {
    let minimumPasswordLength: Int = 8

    func validate(email: String, password: String, passwordConfirmation: String) -> SignupValidationOutcome {
        var errors: [ValidationError] = []
        if (try? Email(email)) == nil                                              { errors.append(.invalidEmail) }
        if (try? Password(password, minimum: minimumPasswordLength)) == nil        { errors.append(.invalidPassword) }
        if (try? MatchedPasswords(password, passwordConfirmation)) == nil          { errors.append(.passwordMismatch) }
        return SignupValidationOutcome(errors: errors)
    }
}
