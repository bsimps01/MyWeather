//
//  HomeView.swift
//  MyWeather
//
//  Created by Benjamin Simpson on 12/16/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    @State private var searchQuery = ""
    @State private var selectedCity: String? = nil // Holds the selected city
    @State private var weatherDetails: WeatherResponse? // Holds weather data
    @State private var isLoadingWeather = false // Weather loading state
    @State private var isTyping = false // Tracks whether the user is typing
    
    var body: some View {
        NavigationView {
            
            VStack {
                // Search Bar at the Top
                SearchBarView(viewModel: viewModel,
                              isTyping: $isTyping,
                              searchQuery: $searchQuery)
                .padding(.top)
                
                if isTyping {
                    // Show search results over the home content when typing
                    ScrollView {
                        VStack(spacing: 8) {
                            ForEach(viewModel.matchedCities, id: \.name) { city in
                                Button(action: {
                                    Task {
                                        await viewModel.fetchWeather(for: city.name)
                                        searchQuery = "" // Clear the search bar
                                        isTyping = false // Hide search results
                                    }}) {
                                    HStack {
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(city.name)
                                                .font(.headline)
                                            
                                            Text("\(city.region), \(city.country)")
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                            
                                            Text("\(city.temp)")
                                                .font(.subheadline)
                                                .foregroundColor(.black)
                                        }
                                        Spacer()
                                        AsyncImage(url: URL(string: city.icon)) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 40, height: 40)
                                                .cornerRadius(8)
                                        } placeholder: {
                                            ProgressView()
                                                .frame(width: 50, height: 50)
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
                } else if let weather = viewModel.weather {
                    // Main weather UI
                    VStack {
                        AsyncImage(url: URL(string: "https:\(weather.current.condition.icon)")) { image in
                            image
                            Text(weather.location.name)
                                .font(.title)
                            Text("\(Int(weather.current.temp_f))°")
                                .font(.system(size: 90))
                            Text(weather.current.condition.text)
                        } placeholder: {
                            ProgressView() // Show a loading indicator while the image is loading
                        }
                        
                        WeatherDetailsView(feelsLike: "\(Int(weather.current.feelslike_f))",
                                           humidity: "\(weather.current.humidity)",
                                           uvIndex: "\(weather.current.uv)")
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.5, alignment: .center)
                }
                else {
                    // Show PlaceholderView when no weather data is available
                    PlaceholderView()
                }
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical)
            .navigationTitle("MyWeather")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await viewModel.loadSavedCityWeather()
            }
        }
    }
}



