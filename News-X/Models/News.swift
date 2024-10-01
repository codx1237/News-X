//
//  News.swift
//  NewsX
//
//  Created by Fırat Ören on 26.09.2024.
//

import Foundation

struct NewsArticle: Identifiable, Codable {
    var id = UUID()
    let title: String
    let description: String?
    let content: String?
    let url: String
    let image: String?
    let publishedAt: String
    let source: Source
    

    enum CodingKeys: String, CodingKey {
        case title
        case description
        case content
        case url
        case image = "image" // Ensure this matches your API response
        case publishedAt
        case source
        // No CodingKey for isFavorite since it's not in the API
    }
}


struct Source: Codable {
    let name: String
}


struct NewsResponse: Codable {
   // let totalArticles: Int
    let articles: [NewsArticle]
}
