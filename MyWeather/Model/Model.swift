//
//  Model.swift
//  MyWeather
//
//  Created by Benjamin Simpson on 12/16/24.
//

import Foundation

struct WeatherResponse: Codable {
    let location: Location
    let current: Current
    
    struct Location: Codable {
        let name: String
    }
    
    struct Current: Codable {
        let temp_f: Double
        let feelslike_f: Double
        let condition: Condition
        let humidity: Int
        let uv: Double
        
        struct Condition: Codable {
            let text: String
            let icon: String
        }
    }
}

struct CitySuggestionsResponse: Codable {
    let id: Int?
    let name: String
    let region: String
    let country: String
    let temp_f: Double?
}
