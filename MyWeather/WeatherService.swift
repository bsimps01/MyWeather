//
//  WeatherService.swift
//  MyWeather
//
//  Created by Benjamin Simpson on 12/16/24.
//
import Foundation

class WeatherService {
    static let shared = WeatherService()
    private let baseURL = "https://api.weatherapi.com/v1/current.json"
    
    func fetchWeather(for city: String) async throws -> WeatherResponse {
        guard let url = URL(string: "\(baseURL)?key=\(apiKey)&q=\(city)") else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(WeatherResponse.self, from: data)
    }
}
