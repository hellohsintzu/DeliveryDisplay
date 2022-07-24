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
    func request<T: Decodable>(urlString: String, model: T.Type, completionHandler: @escaping (Result<T, ErrorModel>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    let successHttpCode: Int = 200
    func request<T: Decodable>(urlString: String, model: T.Type, completionHandler: @escaping (Result<T, ErrorModel>) -> Void) {
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = Constants.APIConstants.get
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                completionHandler(.failure(.requestFail(error)))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == self?.successHttpCode else {
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
