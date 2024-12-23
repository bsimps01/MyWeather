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
    @Published var selectedCity: String = "" // Holds the selected city
    @Published var isLoading: Bool = false // Tracks loading state
    @State var matchedCities: [(name: String, region: String, country: String, temp: String, icon: String)] = []
    
    private let weatherService = WeatherService()
    
    let storage = SavedCities()
    
    func loadSavedCityWeather() async {
        if let city = storage.loadCity() {
            await fetchWeather(for: city)
        }
    }
    
    func fetchWeather(for city: String) async {
        
        await updateState(isLoading: true, errorMessage: nil)
            defer {
            Task { await updateState(isLoading: false) }
        }

        let result = await weatherService.fetchCurrentWeather(city: city)
            switch result {
                case .success(let weather):
                    await updateState(weather: weather, selectedCity: city)
                    storage.saveCity(city)
                case .failure(let error):
                    await updateState(errorMessage: error.customMessage)
        }
    }
    
    // Perform city search using the Weather API
    func performCitySearch(query: String) async {
        guard !query.isEmpty else {
            matchedCities = []
            return
        }

        do {
            matchedCities = try await WeatherService().fetchCitySuggestions(query: query)
        } catch {
            matchedCities = []
            print("Failed to fetch city suggestions: \(error.localizedDescription)")
        }
    }
    
    // Helper method to update state properties on the main thread
    private func updateState(
        weather: WeatherResponse? = nil,
        selectedCity: String? = nil,
        isLoading: Bool? = nil,
        errorMessage: String? = nil
    ) async {
        await MainActor.run {
            if let weather = weather { self.weather = weather }
            if let selectedCity = selectedCity { self.selectedCity = selectedCity }
            if let isLoading = isLoading { self.isLoading = isLoading }
            if let errorMessage = errorMessage { self.errorMessage = errorMessage }
        }
    }
}
