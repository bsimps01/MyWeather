//
//  HTTPClient.swift
//  MyWeather
//
//  Created by Benjamin Simpson on 12/19/24.
//

import Foundation

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint,
                                   responseModel: T.Type,
                                   session: URLSession) async -> Result<T, RequestError>
}

extension HTTPClient {
    
    func sendRequest<T: Decodable>(endpoint: Endpoint,
                                   responseModel: T.Type,
                                   session: URLSession = .shared) async -> Result<T, RequestError> {
        do {
            let request = try endpoint.makeURLRequest()
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }

            switch httpResponse.statusCode {
            case 200...299:
                do {
                    let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                    return .success(decodedResponse)
                } catch {
                    return .failure(.decodingError)  // This should trigger decoding error
                }
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown(error))
        }
    }

}
