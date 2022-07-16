//
//  NetworkService.swift
//  DeliveryDisplay
//
//  Created by 顏莘慈 on 2022/7/16.
//

import Foundation

enum ErrorModel: Error {
    case requestFail(Error)
    case invalidJSON
    case invalidURL
    case invalidData
    case invalidResponse
}

protocol NetworkServiceProtocol {
    func request<T: Decodable>(urlString: String, requestParams: [String: Any]?, model: T.Type, completionHandler: @escaping (Result<T, ErrorModel>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    func request<T: Decodable>(urlString: String, requestParams: [String: Any]?, model: T.Type, completionHandler: @escaping (Result<T, ErrorModel>) -> Void) {
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completionHandler(.failure(.requestFail(error)))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                      completionHandler(.failure(.invalidResponse))
                      return
                  }
            guard let data = data else {
                completionHandler(.failure(.invalidData))
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(model.self, from: data)
                completionHandler(.success(decodedData))
            } catch {
                completionHandler(.failure(.invalidJSON))
            }
        }
        task.resume()
    }
}
