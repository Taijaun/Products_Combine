//
//  NetworkManager.swift
//  Products_Combine
//
//  Created by Taijaun Pitt on 28/06/2023.
//

import Foundation
import Combine

protocol Networkable {
    func getPlanetsFromApi<T:Decodable>(url: URL, type: T.Type) -> AnyPublisher<T, Error>
}


class NetworkManager: Networkable {
    func getPlanetsFromApi<T>(url: URL, type: T.Type) -> AnyPublisher<T, Error> where T : Decodable {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ (data: Data, response: URLResponse) in
                guard let httpResponse = response as? HTTPURLResponse, 200...209 ~= httpResponse.statusCode else {
                    throw NetworkError.responseError
                }
                return data
            })
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError{ error in
                return error
            }
            .eraseToAnyPublisher()
    }
    
    
}
