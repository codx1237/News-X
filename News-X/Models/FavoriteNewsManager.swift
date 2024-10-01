//
//  FavoriteNewsManager.swift
//  NewsX
//
//  Created by Fırat Ören on 27.09.2024.
//

import Foundation

class FavoriteNewsManager: ObservableObject {

    @Published var favoriteArticles: [NewsArticle] = []
    private let favoriteKey = "favoriteArticles"

    init() {
        loadFavoritesFromStorage()
    }

    func loadFavoritesFromStorage() {
        if let savedData = UserDefaults.standard.data(forKey: favoriteKey),
           let decodedArticles = try? JSONDecoder().decode([NewsArticle].self, from: savedData) {
            favoriteArticles = decodedArticles
        }

    }

    func addFavoriteToStorage(article: NewsArticle) {
        favoriteArticles.removeAll()
        loadFavoritesFromStorage()
        favoriteArticles.append(article)
        if let encoded = try? JSONEncoder().encode(favoriteArticles) {
            UserDefaults.standard.removeObject(forKey: favoriteKey)
            UserDefaults.standard.set(encoded, forKey: favoriteKey)
        }
    }


    func removeAtOffsets(indexSet: IndexSet) {
        favoriteArticles.removeAll()
        loadFavoritesFromStorage()
        favoriteArticles.remove(atOffsets: indexSet)
        if let encoded = try? JSONEncoder().encode(favoriteArticles) {
            UserDefaults.standard.removeObject(forKey: favoriteKey)
            UserDefaults.standard.set(encoded, forKey: favoriteKey)
        }
    }




    
}
