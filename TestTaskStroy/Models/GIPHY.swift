//
//  gif.swift
//  TestTaskStroy
//
//  Created by Сергей on 09.04.2021.
//

import Foundation


// MARK: - Users

struct RandomEndpoint: Codable {
    let data: GIFObject?
}


struct SearchEndpoint: Codable {
    let data: [GIFObject]?
    let pagination: PaginationObject?
}
 
struct PaginationObject: Codable {
    let offset: Int?
    let totalCount: Int?
    let count: Int?
    
//    enum CodingKeys: String, CodingKey {
//        case offset = "offset"
//        case totalCount = "total_count"
//        case count = "count"
//    }
}



struct GIFObject: Codable, Hashable {
    
    let images: Images?
    let title: String?
}

struct Images: Codable, Hashable {
    let fixedHeight: FixedHeight?
    
//    enum CodingKeys: String, CodingKey {
//        case fixedHeight = "fixed_height"
//    }
}



struct FixedHeight: Codable, Hashable {
    let url: String?
}



