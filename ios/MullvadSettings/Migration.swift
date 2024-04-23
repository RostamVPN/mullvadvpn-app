//
//  Migration.swift
//  MullvadVPN
//
//  Created by Sajad Vishkai on 2022-11-18.
//  Copyright © 2022 Rostam VPN AB. All rights reserved.
//

import Foundation

public protocol Migration {
    func migrate(
        with store: SettingsStore,
        parser: SettingsParser,
        completion: @escaping (Error?) -> Void
    )
}
