//
//  IncreasedHitButton.swift
//  MullvadVPN
//
//  Created by Mojgan on 2023-05-16.
//  Copyright © 2023 Rostam VPN AB. All rights reserved.
//

import UIKit

final class IncreasedHitButton: UIButton {
    private let defaultSize = UIMetrics.Button.barButtonSize

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let width = bounds.width
        let height = bounds.height
        let dx = (max(defaultSize, width) - width) * 0.5
        let dy = (max(defaultSize, height) - height) * 0.5
        return bounds.insetBy(dx: -dx, dy: -dy).contains(point)
    }
}
