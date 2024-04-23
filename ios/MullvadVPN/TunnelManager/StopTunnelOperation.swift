//
//  StopTunnelOperation.swift
//  MullvadVPN
//
//  Created by pronebird on 15/12/2021.
//  Copyright © 2021 Rostam VPN AB. All rights reserved.
//

import Foundation
import Operations

class StopTunnelOperation: ResultOperation<Void> {
    private let interactor: TunnelInteractor

    init(
        dispatchQueue: DispatchQueue,
        interactor: TunnelInteractor,
        completionHandler: @escaping CompletionHandler
    ) {
        self.interactor = interactor

        super.init(
            dispatchQueue: dispatchQueue,
            completionQueue: dispatchQueue,
            completionHandler: completionHandler
        )
    }

    override func main() {
        switch interactor.tunnelStatus.state {
        case .disconnecting(.reconnect):
            interactor.updateTunnelStatus { tunnelStatus in
                tunnelStatus.state = .disconnecting(.nothing)
            }

            finish(result: .success(()))

        case .connected, .connecting, .reconnecting, .waitingForConnectivity(.noConnection), .error:
            doShutDownTunnel()

        #if DEBUG
        case .negotiatingKey:
            doShutDownTunnel()
        #endif

        case .disconnected, .disconnecting, .pendingReconnect, .waitingForConnectivity(.noNetwork):
            finish(result: .success(()))
        }
    }

    private func doShutDownTunnel() {
        guard let tunnel = interactor.tunnel else {
            finish(result: .failure(UnsetTunnelError()))
            return
        }

        // Disable on-demand when stopping the tunnel to prevent it from coming back up
        tunnel.isOnDemandEnabled = false

        tunnel.saveToPreferences { error in
            self.dispatchQueue.async {
                if let error {
                    self.finish(result: .failure(error))
                } else {
                    tunnel.stop()
                    self.finish(result: .success(()))
                }
            }
        }
    }
}
