//
//  ConnectivityViewModel.swift
//  WatchConnectivitySample
//
//  Created by N. M on 2023/01/09.
//

import SwiftUI
import WatchConnectivity

final class AppConnectivityViewModel: NSObject, ObservableObject {
    @Published var stateModel: ConnectivityStateModel
    @Published var selectedItemModel: SelectedItemModel
    @Published var showingPicker = false
    
    private var session: WCSession = .default

    init(stateModel: ConnectivityStateModel, selectedItemModel: SelectedItemModel) {
        self.stateModel = stateModel
        self.selectedItemModel = selectedItemModel
        super.init()
        self.session.delegate = self
        self.session.activate()
    }
    
    var selectedAnimal: String {
        get {
            return selectedItemModel.selectedAnimal
        }
        set {
            selectedItemModel.changeSelected(animal: newValue)
        }
    }
    
    var selectedFruit: String {
        get {
            return selectedItemModel.selectedFruit
        }
        set {
            selectedItemModel.changeSelected(fruit: newValue)
        }
    }
    
    var selectedWeather: String {
        get {
            return selectedItemModel.selectedWeather
        }
        set {
            selectedItemModel.changeSelected(weather: newValue)
        }
    }
    
    var selectedImage: UIImage? {
        get {
            return selectedItemModel.selectedImage
        }
        set {
            selectedItemModel.changeSelected(image: newValue)
        }
    }
    
    var isPaired: Bool {
        get {
            return stateModel.isPaired
        }
        set {
            stateModel.changeParied(state: newValue)
        }
    }
    
    var isReachable: Bool {
        get {
            return stateModel.isReachable
        }
        set {
            stateModel.changeReachable(state: newValue)
        }
    }
    
    var isComplicationEnabled: Bool {
        get {
            return stateModel.isComplicationEnabled
        }
        set {
            stateModel.changeComplicationEnabled(state: newValue)
        }
    }
    
    var isWatchAppInstalled: Bool {
        get {
            return stateModel.isWatchAppInstalled
        }
        set {
            stateModel.changeWatchAppInstalled(state: newValue)
        }
    }
    
    var wcSessionState: WCSessionActivationState {
        get {
            return stateModel.wcSessionState
        }
        set {
            stateModel.changeWCSession(state: newValue)
        }
    }
    
    private func makeUniqueTempFileURL(extension type: String) -> URL {
        let temporaryDirectoryURL = FileManager.default.temporaryDirectory
        let uniqueFilename = ProcessInfo.processInfo.globallyUniqueString
        let urlNoExt = temporaryDirectoryURL.appendingPathComponent(uniqueFilename)
        let url = urlNoExt.appendingPathExtension(type)
        return url
    }
}

extension AppConnectivityViewModel: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
        } else {
            print("The session has completed activation.")
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
    }
    
    func sessionReachabilityDidChange(_ session: WCSession) {
        DispatchQueue.main.async {
            self.stateModel.changeReachable(state: session.isReachable)
        }
    }
    
    func sessionWatchStateDidChange(_ session: WCSession) {
        DispatchQueue.main.async {
            self.stateModel.changeParied(state: session.isPaired)
            self.stateModel.changeReachable(state: session.isReachable)
            self.stateModel.changeComplicationEnabled(state: session.isComplicationEnabled)
            self.stateModel.changeWatchAppInstalled(state: session.isWatchAppInstalled)
        }
    }
    
    func sendMessage(animal: String) {
        let context: [String: Any] = ["animal": animal]
        session.sendMessage(context, replyHandler: nil) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func updateApplicationContext(fruit: String) {
        let context: [String: Any] = ["fruit": fruit]
        do {
            try session.updateApplicationContext(context)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func transferUserInfo(weather: String) {
        let userInfo: [String: Any] = ["weather": weather]
        session.transferUserInfo(userInfo)
    }
    
    func transferFile() {
        if let img = selectedImage {
            let fileURL = makeUniqueTempFileURL(extension: "png")
            let data = img.pngData()
            try? data!.write(to: fileURL)
            session.transferFile(fileURL, metadata: nil)
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async { [self] in
            self.selectedItemModel.changeSelected(animal: message["animal"] as? String ?? "❓")
        }
    }
    
    internal func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        DispatchQueue.main.async { [self] in
            self.selectedItemModel.changeSelected(fruit: applicationContext["fruit"] as? String ?? "❓")
        }
    }
    
    internal func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any]) {
        DispatchQueue.main.async { [self] in
            self.selectedItemModel.changeSelected(weather: userInfo["weather"] as? String ?? "❓")
        }
    }
}
