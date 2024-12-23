//
//  RequestError.swift
//  MyWeather
//
//  Created by Benjamin Simpson on 12/19/24.
//

enum RequestError: Error, Equatable {
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case decodingError
    case unknown(Error)

    var customMessage: String {
        switch self {
        case .invalidURL: return "Invalid URL."
        case .noResponse: return "No response from the server."
        case .unauthorized: return "Unauthorized request."
        case .unexpectedStatusCode: return "Unexpected status code."
        case .decodingError: return "Failed to decode response."
        case .unknown(let error): return "Unknown error: \(error.localizedDescription)"
        }
    }
    
    static func == (lhs: RequestError, rhs: RequestError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL),
             (.noResponse, .noResponse),
             (.unauthorized, .unauthorized),
             (.unexpectedStatusCode, .unexpectedStatusCode),
             (.decodingError, .decodingError):
            return true
        case (.unknown(let lhsError), .unknown(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}
