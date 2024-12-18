//
//  SearchBar.swift
//  MyWeather
//
//  Created by Benjamin Simpson on 12/17/24.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchQuery: String
    var placeholder: String = "Search for a city..."
    var onSearch: () -> Void

    var body: some View {
        HStack {
            TextField(placeholder, text: $searchQuery)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.vertical, 8)
                .onSubmit {
                    onSearch()
                }
            
            Button(action: onSearch) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.blue)
            }
            .padding(.leading, 8)
        }
        .padding(.horizontal)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}
