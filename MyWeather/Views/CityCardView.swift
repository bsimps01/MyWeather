//
//  CityCardView.swift
//  MyWeather
//
//  Created by Benjamin Simpson on 12/22/24.
//
import SwiftUI

struct CityCardView: View {
    let city: String
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            Text(city)
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .shadow(radius: 2)
        }
    }
}
