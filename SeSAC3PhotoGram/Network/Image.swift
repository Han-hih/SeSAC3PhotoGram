//
//  Image.swift
//  SeSAC3PhotoGram
//
//  Created by 황인호 on 2023/08/30.
//


import Foundation

// MARK: - Image
struct Image: Codable {
    let total, totalPages: Int
    let results: [Result]
    
    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - Result
struct Result: Codable {
    let urls: URLS
}
    enum CodingKeys: CodingKey {
        case urls
    }
    
    
    struct URLS: Codable {
        let regular: String
    }


