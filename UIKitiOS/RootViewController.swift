//
//  RootViewController.swift
//  UIKitiOS
//
//  Created by Alexander Cyon on 2026-04-23.
//

import UIKit

// MARK: RootViewController
final class RootViewController: UIViewController {
  
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = String(localized: .signupWelcomeLabel)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var button: UIButton = {
        let button = UIButton.init(type: .roundedRect)
        button.setTitle(String(localized: .signupButtonTitle), for: .normal)
        button.addAction(UIAction{ [weak self] _ in self?.didTapSignupButton()}, for: .touchUpInside)
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var emailTextField = UITextField.make(
        placeholderL10NKey: .signupEmailPlaceholder,
        keyboardType: .emailAddress,
        isSecureTextEntry: false,
        onEditingDidBegin: { [weak self] field in self?.endEditedFields.remove(field); self?.configureSubviews() },
        onEditingChanged: { [weak self] _ in self?.configureSubviews() },
        onEndEditing: { [weak self] field, _ in self?.endEditedFields.insert(field); self?.configureSubviews() }
    )

    private lazy var passwordTextField = UITextField.make(
        placeholderL10NKey: .signupPasswordPlaceholder,
        onEditingDidBegin: { [weak self] field in self?.endEditedFields.remove(field); self?.configureSubviews() },
        onEditingChanged: { [weak self] _ in self?.configureSubviews() },
        onEndEditing: { [weak self] field, _ in self?.endEditedFields.insert(field); self?.configureSubviews() }
    )

    private lazy var passwordConfirmationTextField = UITextField.make(
        placeholderL10NKey: .signupPasswordPlaceholder,
        onEditingDidBegin: { [weak self] field in self?.endEditedFields.remove(field); self?.configureSubviews() },
        onEditingChanged: { [weak self] _ in self?.configureSubviews() },
        onEndEditing: { [weak self] field, _ in self?.endEditedFields.insert(field); self?.configureSubviews() }
    )

    private lazy var emailErrorLabel = UILabel.makeErrorLabel()
    private lazy var passwordErrorLabel = UILabel.makeErrorLabel()
    private lazy var passwordConfirmationErrorLabel = UILabel.makeErrorLabel()

    private var endEditedFields: Set<UITextField> = []
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                label,
                emailErrorLabel,
                emailTextField,
                passwordErrorLabel,
                passwordTextField,
                passwordConfirmationErrorLabel,
                passwordConfirmationTextField,
                button,
                .spacer
            ]
        )
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInsetAdjustmentBehavior = .automatic
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
}

// MARK: Override
extension RootViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        scrollView.addSubview(stackView)
        view.addSubview(scrollView)

        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing)))

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor),

            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
        ])
    }
}

// MARK: Private
private extension RootViewController {
    
    private func didTapSignupButton() {
        print("Tapped!")
    }

    func configureSubviews() {
        var validator = SignupValidator()
        validator.email = emailTextField.text ?? ""
        validator.password = passwordTextField.text ?? ""
        validator.passwordConfirmation = passwordConfirmationTextField.text ?? ""

        button.isEnabled = validator.canSignUp
        passwordConfirmationTextField.isEnabled = validator.canEnterConfirmPassword

        let errors = validator.errors

        emailErrorLabel.text = ValidationError.invalidEmail.message
        passwordErrorLabel.text = ValidationError.invalidPassword.message
        passwordConfirmationErrorLabel.text = ValidationError.passwordMismatch.message

        emailErrorLabel.isHidden = !endEditedFields.contains(emailTextField) || !errors.contains(.invalidEmail)
        passwordErrorLabel.isHidden = !endEditedFields.contains(passwordTextField) || !errors.contains(.invalidPassword)
        passwordConfirmationErrorLabel.isHidden = !endEditedFields.contains(passwordConfirmationTextField) || !errors.contains(.passwordMismatch)

        for error in errors {
            log.debug("\(error.message)")
        }
    }
}
