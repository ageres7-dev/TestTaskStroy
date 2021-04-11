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
    
    /*
    let url = "\(URLS.shared.buildUrl(forTerm: searchText, offset: "0")!)"
    print(url)
    NetworkManager.shared.fetchObject(SearchResponce.self, from: url ) { response in
        GIFs = response.data
        print(GIFs)
    }
    */
    
    func randomGIF(complition: @escaping (GIFObject) -> ()) {
        let url = buildUrlRandomGIF()
        
        fetchObject(RandomResponce.self, from: url ) { response in
            guard let GIFObject = response.data else { return }
            
            complition(GIFObject)
        }
    }
    
    
    func searchGIF(from string: String, offset: Int, complition: @escaping (SearchResponce?) -> ()) {
        let url = buildUrl(searchTerm: string, offset: offset)
        
        fetchObject(SearchResponce.self, from: url ) { response in
//            guard let GIFGIFObjects = response.data else { return }
            
            complition(response)
        }
    }
    
    private func fetchObject<T: Decodable>(_ type: T.Type, from url: URL?, completion: @escaping (_ object: T)->()) {
        
        guard let url = url else { return }
        
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
                print("Error serialization json", error.localizedDescription)
            }
        }.resume()
    }
    
    private func buildUrl(searchTerm: String, offset: Int) -> URL? {
        guard !searchTerm.isEmpty else { return nil }
        
        let queryItems = [
            URLQueryItem(name: "api_key", value: Constant.key.rawValue),
            URLQueryItem(name: "q", value: searchTerm),
            URLQueryItem(name: "limit", value: "25"),
            URLQueryItem(name: "offset", value: String(offset)),
            URLQueryItem(name: "rating", value: "g"),
            URLQueryItem(name: "lang", value: "en")
        ]
        
        var components = URLComponents(string: Constant.urlSearch.rawValue)
        components?.queryItems = queryItems
        
        return components?.url
    }
    
    private func buildUrlRandomGIF() -> URL? {
        let queryItems = [
            URLQueryItem(name: "api_key", value: Constant.key.rawValue),
            URLQueryItem(name: "tag", value: ""),
            URLQueryItem(name: "rating", value: "r")
        ]
        
        var components = URLComponents(string: Constant.urlRandomGig.rawValue)
        components?.queryItems = queryItems
        
        return components?.url
    }
        
        
    /*
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
        
        */
        
    
}
