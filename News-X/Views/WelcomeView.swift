//
//  ContentView.swift
//  NewsX
//
//  Created by Fırat Ören on 25.09.2024.
//

import SwiftUI

struct WelcomeView: View {
    @Binding var isPressed: Bool
    var body: some View {
        ZStack{
            Image("istanbul3")
                .resizable()
               // .aspectRatio(contentMode: .fit)
               // .frame(maxWidth: .infinity,maxHeight: 500)
               // .offset(y: -150)
                .ignoresSafeArea()

            VStack{
                Spacer()
                RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                    .frame(maxWidth: .infinity,maxHeight: 300)
                    .background(Color.black.opacity(0.5))
                    .overlay(alignment: .top, content: {
                        VStack(spacing: 12){
                            Text("Get The Latest News And Updates")
                                .foregroundStyle(Color.white)
                                .font(.title)
                                .multilineTextAlignment(.center)

                            Text("From Politics to Entertainment: Your OneStop Source for Comprehensive Coverage of the Latest News and Developments Across the Glob will be right on your hand.")
                                .padding(.horizontal)
                                .foregroundStyle(Color.white)
                                .multilineTextAlignment(.center)

                            Button {
                                withAnimation {
                                    isPressed.toggle()
                                }
                            } label: {
                                Text("Explore →")
                                    .frame(width: 150,height: 50)
                                    .background(Color.blue)
                                    .foregroundStyle(Color.white)
                                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                                    .font(.system(size: 19,weight: .semibold))
                                    .padding(.top)

                            }

                        }.padding(.top)
                    })


            }.ignoresSafeArea()
        }
    }
}

#Preview {
    WelcomeView(isPressed: .constant(false))
}
