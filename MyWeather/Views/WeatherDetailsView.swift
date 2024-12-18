//
//  WeatherDetailsView.swift
//  MyWeather
//
//  Created by Benjamin Simpson on 12/17/24.
//

import SwiftUI

struct WeatherDetailsView: View {
    var feelsLike: String
    var humidity: String
    var uvIndex: String

    var body: some View {
        HStack(spacing: 40) {
            // Humidity Section
            VStack {
                Text("Humidity")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text("\(humidity)%")
                    .font(.title3)
                    .bold()
            }

            // UV Index Section
            VStack {
                Text("UV Index")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(uvIndex)
                    .font(.title3)
                    .bold()
            }
            // Feels Like Section
            VStack {
                Text("Feels Like")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text("\(feelsLike)°F")
                    .font(.title3)
                    .bold()
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}
