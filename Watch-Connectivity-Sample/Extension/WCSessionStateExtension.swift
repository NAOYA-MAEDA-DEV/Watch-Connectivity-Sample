//
//  WCSessionStateExtension.swift
//  WatchConnectivitySample
//
//  Created by N. M on 2023/01/09.
//

import Foundation
import WatchConnectivity

extension WCSessionActivationState {
    func stateStr() -> String {
        switch self {
        case .inactive:
            return "INACTIVE"
        case .activated:
            return "ACTIVE"
        case .notActivated:
            return "NOT ACTIVE"
        @unknown default:
            fatalError("New DEFINED STATE");
        }
    }
}
