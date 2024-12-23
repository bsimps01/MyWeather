//
//  Endpoint.swift
//  MyWeather
//
//  Created by Benjamin Simpson on 12/19/24.
//
import Foundation

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var body: [String: Any]? { get }
}

extension Endpoint {
    var scheme: String { "https" }
    var host: String { "api.weatherapi.com" }
    var headers: [String: String]? { nil }
    var queryItems: [URLQueryItem]? { nil }
    var body: [String: Any]? { nil }
    
    func makeURLRequest() throws -> URLRequest {
        // Create URLComponents
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path

        if let queryItems = queryItems {
            components.queryItems = queryItems
        }

        guard let url = components.url else {
            throw RequestError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let headers = headers {
            request.allHTTPHeaderFields = headers
        }

        if let body = body, method == .post || method == .put {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }

        return request
    }
}

enum WeatherEndpoint: Endpoint {
    case currentWeather(city: String)
    case forecast(city: String, days: Int)
    case citySuggestions(query: String)

    var path: String {
        switch self {
        case .currentWeather:
            return "/v1/current.json"
        case .forecast:
            return "/v1/forecast.json"
        case .citySuggestions:
            return "/v1/search.json"
        }
    }

    var method: HTTPMethod {
        .get
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .currentWeather(let city):
            return [
                URLQueryItem(name: "key", value: apiKey),
                URLQueryItem(name: "q", value: city)
            ]
        case .forecast(let city, let days):
            return [
                URLQueryItem(name: "key", value: apiKey), 
                URLQueryItem(name: "q", value: city),
                URLQueryItem(name: "days", value: "\(days)")
            ]
        case .citySuggestions(let query):
            return [
                URLQueryItem(name: "key", value: apiKey),
                URLQueryItem(name: "q", value: query)
            ]
        }
    }
}
