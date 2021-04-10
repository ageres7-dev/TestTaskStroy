//
//  NetworkManager.swift
//  TestTaskStroy
//
//  Created by Сергей on 11.04.2021.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetchObject<T: Decodable>(_ type: T.Type, from url: String, completion: @escaping (_ object: T)->()) {
        guard let url = URL(string: url) else { return }
//        Result
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            
            do {
                let decode = JSONDecoder()
                decode.keyDecodingStrategy = .convertFromSnakeCase
                let object = try decode.decode(T.self, from: data)
                print(object)
                DispatchQueue.main.async {
                    completion(object)
                }
            } catch let error {
                print("CurrentWeather Error serialization json", error.localizedDescription)
            }
        }.resume()

    }
}
