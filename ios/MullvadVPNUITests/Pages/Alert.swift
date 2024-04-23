//
//  Alert.swift
//  MullvadVPNUITests
//
//  Created by Niklas Berglund on 2024-01-10.
//  Copyright © 2024 Rostam VPN AB. All rights reserved.
//

import Foundation
import XCTest

/// Generic alert "page"
class Alert: Page {
    @discardableResult override init(_ app: XCUIApplication) {
        super.init(app)

        self.pageAccessibilityIdentifier = .alertContainerView
        waitForPageToBeShown()
    }

    @discardableResult func tapOkay() -> Self {
        app.buttons[AccessibilityIdentifier.alertOkButton].tap()
        return self
    }
}
