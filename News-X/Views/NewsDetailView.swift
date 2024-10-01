//
//  NewsDetailView.swift
//  NewsX
//
//  Created by Fırat Ören on 26.09.2024.
//

import SwiftUI
import NukeUI

struct NewsDetailView: View {
    @Environment(\.dismiss) var dismiss
    let article: NewsArticle
    @StateObject var fvm = FavoriteNewsManager()

    @State var likedTapped = false
    @State var isDialogShow = false
    @State var isError = false
    var body: some View {

        ZStack {
            VStack{
                HStack(spacing: 25){
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrowshape.backward").foregroundStyle(Color.black)
                    }
                    Spacer()
                    Button {
                        isDialogShow.toggle()
                    } label: {
                        Image(systemName: "square.and.arrow.down").foregroundStyle(Color.black)
                    }

                    ShareLink(item: URL(string: article.url)!) {
                        Label("", systemImage: "square.and.arrow.up")
                            .foregroundStyle(Color.black)
                    }
                    
                }.padding(.horizontal).font(.title2)
                
                ScrollView {
                    VStack {
                        LazyImage(url: URL(string: article.image!)) { state in
                            if let image = state.image {
                                image.resizable().frame(maxWidth: .infinity,maxHeight: 250)
                                
                                
                            } else if state.error != nil {
                                ProgressView("Loading")
                                    .frame(maxWidth: .infinity,maxHeight: 250)
                            } else {
                                ProgressView("Loading")
                                    .frame(maxWidth: .infinity,maxHeight: 250)
                            }
                        }
                        Text(article.description ?? "").font(.system(size: 17,weight: .semibold)).padding(.horizontal, 5)
                        
                        HStack{
                            Image("stevejobs")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30)
                                .clipShape(Circle())
                            Text(article.source.name)
                            Spacer()
                            Text(article.publishedAt.toDate())
                        }.padding(.horizontal, 5)
                        
                        Text(article.content ?? "").padding(.horizontal, 5).font(.system(size: 16,weight: .light)).padding(.top)
                    }
                }
                
                
                
                Spacer()
            }
            if likedTapped {
                RoundedRectangle(cornerSize: CGSize(width: 12, height: 12))
                    .fill(Color.black.opacity(0.5))
                    .frame(width: 200,height: 120)
                    .overlay {
                        VStack{
                            Text("Added 👍🏻" )
                                .foregroundStyle(Color.white)
                                .font(.system(size: 30))
                        }

                    }
            }



        }.navigationBarBackButtonHidden()
            .alert("The Item is already on favorite list", isPresented: $isError, actions: {
                Button("cancel", role: .cancel) {}
            })
            .confirmationDialog("", isPresented: $isDialogShow) {
                Button("Add to Favorites"){
                    withAnimation {
                        if (fvm.favoriteArticles.first(where: {$0.id == article.id}) != nil) {
                            isError.toggle()
                        } else {
                            fvm.addFavoriteToStorage(article: article)
                            self.likedTapped = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                self.likedTapped = false
                            }
                        }

                    }
                }
                Button("tapped2"){

                }
                Button("tapped3"){

                }
            }






    }
}

#Preview {
    NewsDetailView(article: NewsArticle(title: "Google's Pixel 7 and 7 Pro’s design gets revealed even more with fresh crisp renders", description: "Now we have a complete image of what the next Google flagship phones will look like. All that's left now is to welcome them during their October announcement!", content: "Google’s highly anticipated upcoming Pixel 7 series is just around the corner, scheduled to be announced on October 6, 2022, at 10 am EDT during the Made by Google event. Well, not that there is any lack of images showing the two new Google phones, b... [1419 chars]", url: "https://www.phonearena.com/news/google-pixel-7-and-pro-design-revealed-even-more-fresh-renders_id142800", image: "https://m-cdn.phonearena.com/images/article/142800-wide-two_1200/Googles-Pixel-7-and-7-Pros-design-gets-revealed-even-more-with-fresh-crisp-renders.jpg", publishedAt: "2022-09-28T08:14:24Z", source: Source(name: "PhoneArena")))
}
