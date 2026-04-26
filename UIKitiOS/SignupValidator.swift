//
//  SignupValidator.swift
//  UIKitiOS
//
//  Created by Isabella Viksten on 2026-04-24.
//

enum ValidationError: Error {
    case invalidEmail
    case invalidPassword
    case passwordMismatch

    var message: String {
        switch self {
        case .invalidEmail:    return String(localized: .validationErrorInvalidEmail)
        case .invalidPassword: return String(localized: .validationErrorInvalidPassword)
        case .passwordMismatch: return String(localized: .validationErrorPasswordMismatch)
        }
    }
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
