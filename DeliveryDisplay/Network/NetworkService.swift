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
    func request<T: Decodable>(urlString: String, requestParams: [String: Any]?, model: T.Type, handler: @escaping (Result<T, ErrorModel>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    func request<T: Decodable>(urlString: String, requestParams: [String: Any]?, model: T.Type, handler: @escaping (Result<T, ErrorModel>) -> Void) {
        guard let url = URL(string: urlString) else {
            handler(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        do {
            let bodyData = try JSONSerialization.data(withJSONObject: requestParams ?? [:], options: [])
            request.httpBody = bodyData
        } catch {
            handler(.failure(.invalidData))
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                handler(.failure(.requestFail(error)))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                      handler(.failure(.invalidResponse))
                      return
                  }
            guard let data = data else {
                handler(.failure(.invalidData))
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(model.self, from: data)
                handler(.success(decodedData))
            } catch {
                handler(.failure(.invalidJSON))
            }
        }
        task.resume()
    }
}
