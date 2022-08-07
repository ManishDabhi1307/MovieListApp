//
//  NetworkManager.swift
//  MoviesListApp
//
//  Created by Manish Dabhi on 05/08/22.
//

import Foundation

protocol NetworkManager {
    func sendRequest<T: Codable>(endpoint: HttpRouter, responseModel: T.Type, completion: @escaping (Result<T, RequestError>) -> ())
}

extension NetworkManager {
    func sendRequest<T: Codable>(endpoint: HttpRouter, responseModel: T.Type, completion: @escaping (Result<T, RequestError>) -> ()) {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        
        var queryItems = [URLQueryItem(name: "api_key", value: ApiConstant.apiKey),
                          URLQueryItem(name: "language", value: "en-US")]
        if let params = endpoint.urlParameter {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        NetworkLogger.log(request: request)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse, let data = data else {
                completion(.failure(.noResponse))
                return
            }
            switch response.statusCode {
            case 200...299:
                do {
                    let decodedResponse = try JSONDecoder().decode(responseModel, from: data)
                    NetworkLogger.log(response: data)
                    completion(.success(decodedResponse))
                } catch {
                    print("Error -> \(error.localizedDescription)")
                    completion(.failure(.decode))
                }
            case 401:
                completion(.failure(.unauthorized))
            default:
                completion(.failure(.unexpectedStatusCode))
            }
        }.resume()
    }
}
