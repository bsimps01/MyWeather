//
//  SavedCities.swift
//  MyWeather
//
//  Created by Benjamin Simpson on 12/16/24.
//
import Foundation

class SavedCities {
    private let key = "SavedCity"
    
    func saveCity(_ city: String) {
        UserDefaults.standard.set(city, forKey: key)
    }
    
    func loadCity() -> String? {
        UserDefaults.standard.string(forKey: key)
    }
}
