//
//  WeatherService.swift
//  MyWeather
//
//  Created by Benjamin Simpson on 12/16/24.
//
import Foundation

struct WeatherService: HTTPClient {
    let session: URLSession = .shared
    
    // Fetch current weather for a city
    func fetchCurrentWeather(city: String) async -> Result<WeatherResponse, RequestError> {
        await sendRequest(endpoint: WeatherEndpoint.currentWeather(city: city),
                          responseModel: WeatherResponse.self,
                          session: session)
    }
}

extension WeatherService {
    func fetchCitySuggestions(query: String) async throws -> [(name: String, region: String, country: String, temp: String, icon: String)] {
        let endpoint = WeatherEndpoint.citySuggestions(query: query)
        let result: Result<[CitySuggestionsResponse], RequestError> = await sendRequest(endpoint: endpoint, responseModel: [CitySuggestionsResponse].self)

        switch result {
        case .success(let cities):
            var cityDetails: [(name: String, region: String, country: String, temp: String, icon: String)] = []
            var seenCities: Set<String> = [] // Set to track unique city names

            for city in cities {
                // Check if the city name has already been added
                guard !seenCities.contains(city.name) else { continue }
                seenCities.insert(city.name)

                let weatherResult = await fetchCurrentWeather(city: city.name)
                switch weatherResult {
                case .success(let weather):
                    let temperature = "\(weather.current.temp_f)°"
                    let iconURL = "https:\(weather.current.condition.icon)"
                        cityDetails.append((name: city.name, region: city.region, country: city.country, temp: temperature, icon: iconURL))
                case .failure:
                        cityDetails.append((name: city.name, region: city.region, country: city.country, temp: "N/A", icon: ""))
                }
            }
            return cityDetails

        case .failure(let error):
            throw error
        }
    }
}


