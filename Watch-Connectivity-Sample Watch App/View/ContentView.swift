//
//  ContentView.swift
//  WatchConnectivitySample Watch App
//
//  Created by N. M on 2023/01/09.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: AppConnectivityViewModel

    var body: some View {
        TabView() {
            animalPage()
            fruitlPage()
            weatherPage()
            imagePage()
        }
    }
    
    @ViewBuilder
    private func animalPage() -> some View {
        VStack() {
            Text("Selected Animal")
            Text("\(viewModel.selectedAnimal)")
                .padding()
            Form {
                Picker("Select Emoji", selection: $viewModel.selectedAnimal) {
                    Text("🐱").tag("🐱")
                    Text("🐶").tag("🐶")
                    Text("🐰").tag("🐰")
                }
            }
            Button(action: {
                viewModel.sendMessage(animal: viewModel.selectedAnimal)
            }) {
                Text("Send")
            }
        }
    }
    
    @ViewBuilder
    private func fruitlPage() -> some View {
        VStack() {
            Text("Selected Fruit")
            Text("\(viewModel.selectedFruit)")
                .padding()
            Form {
                Picker("Select Emoji", selection: $viewModel.selectedFruit) {
                    Text("🍎").tag("🍎")
                    Text("🍊").tag("🍊")
                    Text("🍈").tag("🍈")
                }
            }
            Button(action: {
                viewModel.updateApplicationContext(fruit: viewModel.selectedFruit)
            }) {
                Text("Send")
            }
        }
    }
    
    @ViewBuilder
    private func weatherPage() -> some View {
        VStack() {
            Text("Selected Weather")
            Text("\(viewModel.selectedWeather)")
                .padding()
            Form {
                Picker("Select Weather", selection: $viewModel.selectedWeather) {
                    Text("☀️").tag("☀️")
                    Text("☔️").tag("☔️")
                    Text("❄️").tag("❄️")
                }
            }
            Button(action: {
                viewModel.transferUserInfo(weather: viewModel.selectedWeather)
            }) {
                Text("Send")
            }
        }
    }
    
    @ViewBuilder
    private func imagePage() -> some View {
        VStack() {
            Text("Selected Image")
            if let image = viewModel.selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                Text("No Image")
            }
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

