//
//  FavoriteView.swift
//  NewsX
//
//  Created by Fırat Ören on 25.09.2024.
//

import SwiftUI
import NukeUI

struct FavoriteView: View {
    @StateObject var fvm = FavoriteNewsManager()

    var body: some View {

        NavigationView {
            List() {
                ForEach(fvm.favoriteArticles){ favArticle in
                    NavigationLink {
                        NewsDetailView(article: favArticle)
                    } label: {
                        HStack{
                            Text(favArticle.title)
                            LazyImage(url: URL(string: favArticle.image!)) { state in
                                if let image = state.image {
                                    image.resizable().frame(width: 100,height: 80)
                                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 12, height: 12)))
                                    
                                } else if state.error != nil {
                                    ProgressView("Loading")
                                        .frame(width: 100, height: 80)
                                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 12, height: 12)))
                                } else {
                                    ProgressView("Loading")
                                        .frame(width: 100, height: 80)
                                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 12, height: 12)))
                                }
                            }
                        }
                    }
                    
                    
                    
                }.onDelete { IndexSet in
                    fvm.removeAtOffsets(indexSet: IndexSet)
                }
                
            }
            .navigationTitle("Favorite News")
            .onAppear {
                fvm.loadFavoritesFromStorage()
            }
        }
    }
}

#Preview {
    FavoriteView()
}
