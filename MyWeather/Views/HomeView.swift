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

    var body: some View {
        NavigationView {
            VStack {
                // Persistent Search Bar
                SearchBarView(searchQuery: $searchQuery, onSearch: {
                    Task {
                        await viewModel.fetchWeather(for: searchQuery)
                    }
                })
                .padding(.top)
            
                Spacer()
                
                if let weather = viewModel.weather {
                    // Main weather UI
                    VStack {
                        AsyncImage(url: URL(string: "https:\(weather.current.condition.icon)")) { image in
                            image
                        Text(weather.location.name).font(.title)
                        Text("\(Int(weather.current.temp_f))°F").font(.largeTitle)
                        Text(weather.current.condition.text)
                        } placeholder: {
                            ProgressView() // Show a loading indicator while the image is loading
                        }

                        WeatherDetailsView(feelsLike: "\(Int(weather.current.feelslike_f))",
                                             humidity: "\(weather.current.humidity)",
                                             uvIndex: "\(weather.current.uv)")
                    }
                } else {
                    // Show PlaceholderView when no weather data is available
                    PlaceholderView()
                }
                Spacer()
            }
            .padding(.horizontal)
            .navigationTitle("MyWeather")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await viewModel.loadSavedCityWeather()
            }
        }
    }
}

