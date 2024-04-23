//
//  TermsOfServicePage.swift
//  MullvadVPNUITests
//
//  Created by Niklas Berglund on 2024-01-10.
//  Copyright © 2024 Rostam VPN AB. All rights reserved.
//

import Foundation
import XCTest

class TermsOfServicePage: Page {
    @discardableResult override init(_ app: XCUIApplication) {
        super.init(app)

        self.pageAccessibilityIdentifier = .termsOfServiceView
        waitForPageToBeShown()
    }

    @discardableResult func tapAgreeButton() -> Self {
        app.buttons[AccessibilityIdentifier.agreeButton].tap()
        return self
    }
}
