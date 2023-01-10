//
//  ConnectivityStateModel.swift
//  WatchConnectivitySample
//
//  Created by N. M on 2023/01/09.
//

import Foundation
import WatchConnectivity

struct ConnectivityStateModel {
    private(set) var isPaired = false
    private(set) var isReachable = false
    private(set) var isComplicationEnabled = false
    private(set) var isWatchAppInstalled = false
    private(set) var wcSessionState:  WCSessionActivationState = .inactive
    
    mutating func changeParied(state: Bool) {
        isPaired = state
    }
    
    mutating func changeReachable(state: Bool) {
        isReachable = state
    }
    
    mutating func changeComplicationEnabled(state: Bool) {
        isComplicationEnabled = state
    }
    
    mutating func changeWatchAppInstalled(state: Bool) {
        isWatchAppInstalled = state
    }
    
    mutating func changeWCSession(state: WCSessionActivationState) {
        wcSessionState = state
    }
}
