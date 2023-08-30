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


// MARK: - Result
struct Result: Codable {
    let id: Int
    let urls: URLS

    enum CodingKeys: String, CodingKey {
        case id
        case urls = "urls"
    }
}
    
    struct URLS: Codable {
        let raw: String
        let full: String
        let regular: String
        let small: String
        let thumb: String
        let small_s3: String
    }
}

