//
//  ViewModel.swift
//  MyWeather
//
//  Created by Benjamin Simpson on 12/16/24.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var weather: WeatherResponse?
    @Published var errorMessage: String?
    
    let storage = SavedCities()
    
    func loadSavedCityWeather() async {
        if let city = storage.loadCity() {
            await fetchWeather(for: city)
        }
    }
    
    func fetchWeather(for city: String) async {
        do {
            let response = try await WeatherService.shared.fetchWeather(for: city)
            DispatchQueue.main.async {
                self.weather = response
                self.storage.saveCity(city)
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Failed to load weather."
            }
        }
    }
}
