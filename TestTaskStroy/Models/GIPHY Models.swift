//
//  gif.swift
//  TestTaskStroy
//
//  Created by Сергей on 09.04.2021.
//

import Foundation


struct GIFResponce: Codable {
    let data: GIFObject?
}


struct GIFsResponce: Codable {
    let data: [GIFObject]?
    let pagination: PaginationObject?
}
 
struct PaginationObject: Codable {
    let offset: Int?
    let totalCount: Int?
    let count: Int?
}


struct GIFObject: Codable, Hashable {
    
    let images: Images?
    let title: String?
}

struct Images: Codable, Hashable {
    let fixedHeight: GIFUrl?
    let fixedHeightDownsampled: GIFUrl?
    let fixedHeightSmall: GIFUrl?
    let fixedHeightSmallStill: GIFUrl?
}


struct GIFUrl: Codable, Hashable {
    let url: String?
}



