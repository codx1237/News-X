//
//  NewsBasedOnTagsView.swift
//  NewsX
//
//  Created by Fırat Ören on 27.09.2024.
//

import SwiftUI
import NukeUI

struct NewsBasedOnTagsView: View {
    let tag: String
    @StateObject var newsManager = NewsManager()
    @Environment(\.dismiss) var dismiss
    var body: some View {

        NavigationView {
            VStack {
                List {
                    ForEach(newsManager.articles) { article in
                        NavigationLink {
                            NewsDetailView(article: article)
                        } label: {
                            HStack{
                                VStack(alignment:.leading){
                                    Text(article.title)
                                    Text(article.source.name)
                                        .foregroundStyle(Color.blue)
                                }
                                Spacer()
                                LazyImage(url: URL(string: article.image!)) { state in
                                    if let image = state.image {
                                        image.resizable().frame(width: 120,height: 100)
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
                        
                        
                    }
                }.listStyle(.grouped)
            }.toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrowshape.backward").foregroundStyle(Color.black)
                    }

                }
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle(tag.capitalizeFirstLetter)
        }.task {
            await newsManager.fetchNews(tag: tag)
        }
        .navigationBarBackButtonHidden()


    }
}

#Preview {
    NewsBasedOnTagsView(tag: "general")
}
