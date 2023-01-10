//
//  ContentView.swift
//  WatchConnectivitySample
//
//  Created by N. M on 2023/01/09.
//

import SwiftUI
import WatchConnectivity

struct ContentView: View {
    @StateObject var viewModel: AppConnectivityViewModel

    var body: some View {
        NavigationView {
            VStack {
                List() {
                    Section(header: Text("Connectivity State")) {
                        LabeledContent("Paird") {
                            Text(viewModel.isPaired ? "YES": "NO")
                        }
                        LabeledContent("Rechable State") {
                            Text(viewModel.isReachable ? "YES": "NO")
                        }
                        LabeledContent("WatchApp Installed") {
                            Text(viewModel.isWatchAppInstalled ? "YES": "NO")
                        }
                        LabeledContent("Complication Enabled") {
                            Text(viewModel.isComplicationEnabled ? "YES": "NO")
                        }
                        LabeledContent("Activate State") {
                            Text(viewModel.wcSessionState.stateStr())
                        }
                    }
                    Section(
                        header: Text("Communicating"),
                        footer: Text("Communicating by sendMessage")) {
                            Picker("Select Animal", selection: $viewModel.selectedAnimal) {
                            Text("🐱").tag("🐱")
                            Text("🐶").tag("🐶")
                            Text("🐰").tag("🐰")
                        }
                        Button(action: {
                            viewModel.sendMessage(animal: viewModel.selectedAnimal)
                        }) {
                            HStack {
                                Spacer()
                                Text("Send")
                                Spacer()
                            }
                        }.buttonStyle(.borderedProminent)
                    }
                    Section(footer: Text("Communicating by updateApplicationContext")) {
                        Picker("Select Fruit", selection: $viewModel.selectedFruit) {
                            Text("🍎").tag("🍎")
                            Text("🍊").tag("🍊")
                            Text("🍈").tag("🍈")
                        }
                        
                        Button(action: {
                            viewModel.updateApplicationContext(fruit: viewModel.selectedFruit)
                        }) {
                            HStack {
                                Spacer()
                                Text("Send")
                                Spacer()
                            }
                        }.buttonStyle(.borderedProminent)
                    }
                    Section(footer: Text("Communicating by transferUserInfo")) {
                        Picker("Select Weather", selection: $viewModel.selectedWeather) {
                            Text("☀️").tag("☀️")
                            Text("☔️").tag("☔️")
                            Text("❄️").tag("❄️")
                        }
                        Button(action: {
                            viewModel.transferUserInfo(weather: viewModel.selectedWeather)
                        }) {
                            HStack {
                                Spacer()
                                Text("Send")
                                Spacer()
                            }
                        }.buttonStyle(.borderedProminent)
                    }
                    Section(footer: Text("Communicating by transferFile")) {
                        LabeledContent(content: {
                            if let img = viewModel.selectedImage {
                                Image(uiImage: img)
                            } else {
                                Text("No selected image.")
                            }
                        }) {
                            Button(action: {
                                viewModel.showingPicker.toggle()
                            }) {
                                Text("Show ImagePicker")
                            }
                            .sheet(isPresented: $viewModel.showingPicker) {
                                ImagePickerView(image: $viewModel.selectedImage)
                            }
                        }
                        Button(action: {
                            viewModel.transferFile()
                        }) {
                            HStack {
                                Spacer()
                                Text("Send")
                                Spacer()
                            }
                        }.buttonStyle(.borderedProminent)
                    }
                }
            }
            .navigationTitle("Connectivity Sample")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: AppConnectivityViewModel(
            stateModel: ConnectivityStateModel(),
            selectedItemModel: SelectedItemModel())
        )
    }
}
