//
//  ExploreView.swift
//  NewsX
//
//  Created by Fırat Ören on 25.09.2024.
//

import SwiftUI
import NukeUI

struct ExploreView: View {

    var categories = ["general","world","nation","science","health","business","technology","entertainment","sports"]

    @State var selectedCategory = ""
    @StateObject var vm = NewsManager()



    var body: some View {
        NavigationView {
            ScrollView {
                VStack{
                    VStack(alignment:.leading) {
                        Text("Popular Tags")
                            .font(.system(size: 24,weight: .semibold))
                        
                        HStack{
                            ForEach(0..<5) { i in
                                NavigationLink {
                                    NewsBasedOnTagsView(tag: categories[i])
                                } label: {
                                        Text("#\(categories[i])")
                                            .padding(10)
                                            .background(Color.gray.opacity(0.1))
                                            .foregroundStyle(Color.black)
                                            .font(.system(size: 10,weight: .light))
                                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))

                                }

                            }
                        }
                        HStack{
                            ForEach(5..<9) { i in
                                NavigationLink {
                                    NewsBasedOnTagsView(tag: categories[i])
                                } label: {
                                        Text("#\(categories[i])")
                                            .padding(10)
                                            .background(Color.gray.opacity(0.1))
                                            .foregroundStyle(Color.black)
                                            .font(.system(size: 10,weight: .light))
                                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))

                                }
                            }
                        }
                    }.frame(maxWidth: .infinity,alignment:.leading)
                        .padding()
                    Divider()
                    HStack{
                        Text("Latest News")
                            .bold()
                        Spacer()
                        Button {
                            
                        } label: {
                            Text("View all")
                                .font(.system(size: 14,weight: .bold))
                                .foregroundStyle(Color.blue)
                        }
                        
                    }.padding()
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(vm.articles) { article in
                                NavigationLink {
                                    NewsDetailView(article: article)
                                } label: {
                                    VStack(alignment:.leading,spacing: 8){
                                        LazyImage(url: URL(string: article.image!)) { state in
                                            if let image = state.image {
                                                image.resizable().frame(width: 250,height: 150)
                                                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 12, height: 12)))

                                            } else if state.error != nil {
                                                ProgressView("Loading")
                                                    .frame(width: 250, height: 150)
                                                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 12, height: 12)))
                                            } else {
                                                ProgressView("Loading")
                                                    .frame(width: 250, height: 150)
                                                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 12, height: 12)))
                                            }
                                        }

                                        Text(article.title)
                                            .multilineTextAlignment(.leading)
                                        HStack{
                                            Text(article.source.name)
                                                .foregroundStyle(Color.blue)
                                                .font(.system(size: 16))
                                            Text("\(article.publishedAt.toDate())")
                                                .font(.system(size: 12))
                                        }


                                    }.frame(width: 250,height: 250).padding(.horizontal).foregroundStyle(Color.black)
                                }


                            }
                        }
                    }.scrollIndicators(.hidden)
                    Divider()
                    
                    HStack{
                        Text("Recomendation Topic")
                            .font(.system(size: 18,weight: .bold))
                        Spacer()
                        Button {
                            
                        } label: {
                            Text("View all")
                                .font(.system(size: 14,weight: .bold))
                                .foregroundStyle(Color.blue)
                        }
                        
                    }.padding()
                    
                    ForEach(vm.articles) { article in
                        NavigationLink {
                            NewsDetailView(article: article)
                        } label: {
                            VStack{
                                HStack{
                                    VStack(alignment:.leading,spacing: 10){
                                        Text(article.title)
                                            .multilineTextAlignment(.leading)
                                        HStack{
                                            Text(article.source.name)
                                                .foregroundStyle(Color.blue)
                                                .font(.system(size: 16))
                                            Text("\(article.publishedAt.toDate())")
                                                .font(.system(size: 12))
                                        }
                                    }
                                    Spacer()
                                    LazyImage(url: URL(string: article.image!)) { state in
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
                                }.padding(.horizontal)
                            }.foregroundStyle(Color.black)
                        }
                    }
                    
                    Spacer()
                }
            }.task{
                await vm.fetchNews(tag: "general")
            }
           
        }




    }
}

#Preview {
    ExploreView()
}



