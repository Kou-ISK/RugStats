//
//  BaseModelProtcol.swift
//  RugStats
//
//  Created by 井坂航 on 2024/11/14.
//

import Combine
import Foundation

protocol BaseModelProtcol {
    var scheme: String { get }
    var host: String{ get }
    var basePath: String { get }
    var cancellables: Set<AnyCancellable> { get set}
    
    func parseGetParams(params: [String: Any]) -> [URLQueryItem]
}

extension BaseModelProtcol {
    var scheme: String {"https"}
    
    func resumePublisher<T: Codable>(path: String, method: HTTPMethod, params: [String: Any], responseType: T.Type, headers: [HTTPHeader] = []) -> AnyPublisher<T, Error> {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = NSURLFileScheme
        urlComponents.host = host
        urlComponents.path = basePath + path
        if method == .get{
            urlComponents.queryItems = self.parseGetParams(params: params)
        }
        
        guard let url = urlComponents.url else {
            let error = RequestError.parse(description: "wrong request url")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if method == .post{
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap{
                if let statusCode = ($0.response as? HTTPURLResponse)?.statusCode{
                    if statusCode != 200 && statusCode != 201 && statusCode != 204 {
                        throw RequestError.response(description: "\(statusCode) error")
                    }
                }
                return $0.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func parseGetParams(params: [String: Any])-> [URLQueryItem]{
        return params.map {
            if let value = $0.value as? String {
                return URLQueryItem(name: $0.key, value: value)
            }
            return URLQueryItem(name: $0.key, value: "")
        }
    }
}

enum RequestError: Error{
    case parse(description: String)
    case request(description: String)
    case network(description: String)
    case response(description: String)
}

extension RequestError: LocalizedError{
    var errorDescription: String?{
        switch self {
            case let .parse(description):
                return description
            case let .request(description):
                return description
            case let .network(description):
                return description
            case let .response(description):
                return description
        }
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

struct HTTPHeader {
    let field: String
    let value: String
}
