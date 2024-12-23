//
//  SearchBar.swift
//  MyWeather
//
//  Created by Benjamin Simpson on 12/17/24.
//

import SwiftUI

struct SearchBarView: View {
    //@State private var searchQuery = ""
    @State private var matchedCities: [(name: String, region: String, country: String, temp: String, icon: String)] = [] // Holds city search results
    @State private var isLoading = false // Indicates whether the search is in progress
    @State private var errorMessage: String? // Holds any error messages
    @ObservedObject var viewModel: HomeViewModel // The ViewModel to fetch weather data
    @Binding var isTyping: Bool
    @Binding var searchQuery: String
    
    var body: some View {
        VStack {
            // Search Bar
            HStack {
                TextField("Search for a city...", text: $searchQuery)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onChange(of: searchQuery) {
                        isTyping = !searchQuery.isEmpty // Show search results when typing
                        Task {
                            await performCitySearch()
                        }
                    }
                    .padding(.vertical, 8)
                
                Button(action: {
                    Task {
                        await performCitySearch()
                    }
                }) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .shadow(radius: 2)
            
            // Loading Indicator
            if isLoading {
                ProgressView("Searching...")
                    .padding()
            }
            
            // Error Message
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            
            // Search Results
            if isTyping {
                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(matchedCities, id: \.name) { city in
                            Button(action: {
                                Task {
                                    await viewModel.fetchWeather(for: city.name)
                                    searchQuery = "" // Clear the search bar
                                    isTyping = false // Hide search results
                                }
                            }) {
                                HStack {
                                    // City Details
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(city.name)
                                            .font(.largeTitle)
                                            .foregroundColor(.black)
                                        Text("\(city.region), \(city.country)")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                        Text("\(city.temp)")
                                            .font(.largeTitle)
                                            .foregroundColor(.black)
                                    }
                                    Spacer()
                                    
                                    // Weather Icon
                                    AsyncImage(url: URL(string: city.icon)) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 40, height: 40)
                                            .cornerRadius(8)
                                    } placeholder: {
                                        ProgressView()
                                            .frame(width: 40, height: 40)
                                    }
                                }
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                            }
                        }
                    }
                    .padding()
                }
                .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.5)
            }
        }
    }
    
    
    // Perform city search using the Weather API
    private func performCitySearch() async {
        guard !searchQuery.isEmpty else {
            matchedCities = []
            return
        }

        isLoading = true
        errorMessage = nil

        defer { isLoading = false }

        do {
            // Mocked API integration for city search (replace with actual API call)
            let response = try await WeatherService().fetchCitySuggestions(query: searchQuery)
            matchedCities = response
        } catch {
            errorMessage = "Failed to fetch city suggestions. Please try again."
        }
    }
}
