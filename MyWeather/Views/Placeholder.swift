//
//  Placeholder.swift
//  MyWeather
//
//  Created by Benjamin Simpson on 12/16/24.
//

import SwiftUI

struct PlaceholderView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "magnifyingglass.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
                .opacity(0.7)
            
            Text("No City Selected")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.gray)
            
            Text("Search for a city to view its weather.")
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
