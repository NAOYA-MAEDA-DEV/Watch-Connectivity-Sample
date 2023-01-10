//
//  SelectedItemModel.swift
//  WatchConnectivitySample
//
//  Created by N. M on 2023/01/09.
//

import Foundation
import UIKit

struct SelectedItemModel {
    private(set) var selectedAnimal: String = "🐱"
    private(set) var selectedFruit: String = "🍎"
    private(set) var selectedWeather: String = "☀️"
    private(set) var selectedImage: UIImage? = nil
    
    mutating func changeSelected(animal: String) {
        selectedAnimal = animal
    }
    
    mutating func changeSelected(fruit: String) {
        selectedFruit = fruit
    }
    
    mutating func changeSelected(weather: String) {
        selectedWeather = weather
    }
    
    mutating func changeSelected(image: UIImage?) {
        selectedImage = image
    }
}
