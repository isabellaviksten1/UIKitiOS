//
//  RootViewController.swift
//  UIKitiOS
//
//  Created by Isabella Viksten on 2026-04-26.
//

import Foundation
import UIKit

final class RootViewController: UINavigationController {}

// MARK: Override
extension RootViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let signupViewController = SignupViewController(
            onSignupCompleted: { [weak self] email in self?.navigateToWelcome(with: email) }
        )
        setViewControllers([signupViewController], animated: false)
    }

}

extension RootViewController {
    
    private func navigateToWelcome(with email: Email) {
        log.debug("Welcoming user with email: \(email)")
        self.pushViewController(
            WelcomeViewController(email: email.value),
            animated: true
        )
    }
}
