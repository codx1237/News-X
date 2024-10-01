//
//  HomeView.swift
//  NewsX
//
//  Created by Fırat Ören on 25.09.2024.
//

import SwiftUI
import NukeUI



struct HomeView: View {
    @State var search = ""
    @StateObject var vm = NewsManager()
    @StateObject var wheatherService = WheatherApiService()
    @State var greeting = ""
    @State var greetingImg = ""

    func updateGreeting() {
        let currentHour = Calendar.current.component(.hour, from: Date())

        switch currentHour {
        case 6..<12:
            greeting = "Good Morning"
            greetingImg = "☀️"
        case 12..<17:
            greeting = "Good Afternoon"
            greetingImg = "🌤️"
        case 17..<21:
            greeting = "Good Evening"
            greetingImg = "🌓"
        default:
            greeting = "Good Night"
            greetingImg = "🌑"
        }
    }


    var body: some View {
        NavigationView {
            VStack{
                HStack{
                    VStack(alignment:.leading){
                        Text(greeting)
                            .font(.system(size: 16,weight: .light))
                            .foregroundStyle(Color.white)
                        Text(Date().formattedString(style: .medium))
                            .foregroundStyle(Color.white).bold()
                    }
                    Spacer()
                    Text("\(greetingImg) \(wheatherService.currentTemp.roundToInt())°C").font(.system(size: 19,weight: .light))
                        .foregroundStyle(Color.white)
                }.ignoresSafeArea()
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity,maxHeight: 100)
                    .background(Color.black)
                
                
                ScrollView {
                    ForEach(vm.articles) { article in
                        NavigationLink {
                            NewsDetailView(article: article)
                        } label: {
                            VStack(alignment:.leading) {
                                LazyImage(url: URL(string: article.image!)) { state in
                                    if let image = state.image {
                                        image.resizable().frame(maxWidth: .infinity,maxHeight: 200)


                                    } else if state.error != nil {
                                        ProgressView("Loading")
                                            .frame(maxWidth: .infinity,maxHeight: 200)
                                    } else {
                                        ProgressView("Loading")
                                            .frame(maxWidth: .infinity,maxHeight: 200)
                                    }
                                }

                                Text(article.title).font(.system(size: 18,weight: .bold)).multilineTextAlignment(.leading)
                                HStack{
                                    Text(article.source.name)
                                    Circle().fill(Color.blue).frame(width: 10,height: 10)
                                    Spacer()
                                }.padding(.vertical,5)


                                Text(article.content ?? "")
                                    .font(.system(size: 15,weight: .light)).multilineTextAlignment(.leading)
                                Divider()
                            }.frame(maxWidth: .infinity,maxHeight: 400).clipShape(RoundedRectangle(cornerSize: CGSize(width: 12, height: 12)))
                                .padding(.horizontal).foregroundStyle(Color.black)
                        }


                    }
                }
                
                

                
            }
        }.task {
            await vm.fetchNews(tag: "general")
            await wheatherService.fetchWheather()
        }
        .onAppear {
            updateGreeting()
        }


    }
}

#Preview {
    HomeView()
}

