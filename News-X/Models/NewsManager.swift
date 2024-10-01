//
//  NewsManager.swift
//  NewsX
//
//  Created by Fırat Ören on 26.09.2024.
//

import Foundation

@MainActor
class NewsManager: ObservableObject {

    @Published var articles: [NewsArticle] = []
    @Published var favoriteArticles: [NewsArticle] = []
    private let apiKey = "9cf28d0bad1ac55b65605afc0c3f1b48"
    private let cacheKey = "cachedArticles"
    


    func fetchNews(tag: String) async {
        if let cachedArticles = loadFromCache() {
            self.articles = cachedArticles
            print("loaded from cache")
        } else {
            await fetchNewsFromApi(tag: tag)
        }
    }

    


    private func loadFromCache() -> [NewsArticle]? {
        if let savedData = UserDefaults.standard.data(forKey: cacheKey),
           let decodedArticles = try? JSONDecoder().decode([NewsArticle].self, from: savedData) {
            return decodedArticles
        }
        return nil
    }


    private func saveToCache(articles: [NewsArticle]) {
        if let encoded = try? JSONEncoder().encode(articles) {
            UserDefaults.standard.set(encoded, forKey: cacheKey)
        }
    }


    private func fetchNewsFromApi(tag: String) async {
        let urlString = "https://gnews.io/api/v4/top-headlines?category=\(tag)&lang=en&country=us&max=10&apikey=\(apiKey)"

        guard let url = URL(string: urlString) else {
           print("Invalid Url")
            return
        }

        do {
            let (data,response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Bad HttpRequest")
                return
            }

            guard let decodedResponse = try? JSONDecoder().decode(NewsResponse.self, from: data) else {
                print("Decode Error")
                return
            }
            self.articles = decodedResponse.articles
            saveToCache(articles: decodedResponse.articles)
        } catch {
            print("failed to fetch news. \(error.localizedDescription)")
        }

    }




}


enum NetworkError: Error {
    case badUrl
    case badRequest
    case decodingError
}
