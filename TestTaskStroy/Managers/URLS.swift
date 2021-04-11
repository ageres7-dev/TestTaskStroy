//
//  URLS.swift
//  TestTaskStroy
//
//  Created by Сергей on 11.04.2021.
//

import Foundation

class URLS {
    static let shared = URLS()
    private init() {}
    
    func buildUrl(searchTerm: String, offset: String) -> URL? {
        guard !searchTerm.isEmpty else { return nil }
        
        let queryItems = [
            URLQueryItem(name: "api_key", value: Constant.key.rawValue),
            URLQueryItem(name: "q", value: searchTerm),
            URLQueryItem(name: "limit", value: "25"),
            URLQueryItem(name: "offset", value: offset),
            URLQueryItem(name: "rating", value: "g"),
            URLQueryItem(name: "lang", value: "en")
        ]
        
        var components = URLComponents(string: Constant.urlSearch.rawValue)
        components?.queryItems = queryItems
        
        return components?.url
    }
}
