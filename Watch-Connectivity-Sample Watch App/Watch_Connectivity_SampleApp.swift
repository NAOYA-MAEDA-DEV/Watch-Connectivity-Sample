//
//  Watch_Connectivity_SampleApp.swift
//  Watch-Connectivity-Sample Watch App
//
//  Created by N. M on 2023/01/10.
//

import SwiftUI

@main
struct Watch_Connectivity_Sample_Watch_AppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                viewModel: AppConnectivityViewModel(
                    stateModel: ConnectivityStateModel(),
                    selectedItemModel: SelectedItemModel()
                )
            )
        }
    }
}

