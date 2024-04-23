//
//  AccessMethodViewModelEditing.swift
//  MullvadVPN
//
//  Created by Jon Petersson on 2024-01-23.
//  Copyright © 2024 Rostam VPN AB. All rights reserved.
//

import MullvadSettings

protocol AccessMethodEditing: AnyObject {
    func accessMethodDidSave(_ accessMethod: PersistentAccessMethod)
}
