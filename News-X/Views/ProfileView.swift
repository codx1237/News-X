//
//  ProfileView.swift
//  NewsX
//
//  Created by Fırat Ören on 25.09.2024.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack{
                Text("Profile")
                    .font(.title)
                Spacer()

                VStack{
                    Image("logo")
                        .resizable()
                        .frame(width: 120,height: 120)
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 12, height: 12)))

                    Text("Log In to View your profile")
                        .font(.system(size: 15,weight: .light))
                        .padding()

                    NavigationLink {

                    } label: {
                        Text("Log In")
                            .frame(maxWidth: .infinity,maxHeight: 50)
                            .background(Color.black)
                            .foregroundStyle(Color.white)
                            .font(.system(size: 21))
                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 12, height: 12)))
                            .padding(.horizontal)


                    }

                    NavigationLink {

                    } label: {
                        RoundedRectangle(cornerSize: CGSize(width: 12, height: 12),style: .circular)
                            .stroke(Color.black,lineWidth: 1.0)
                            .frame(maxWidth: .infinity,maxHeight: 45)
                            .padding(.horizontal)
                            .overlay {
                                Text("Sign Up")
                                    .foregroundStyle(Color.black)
                                    .font(.system(size: 21))
                            }
                    }
                }






                Spacer()

                Spacer()
            }
        }

    }
}

#Preview {
    ProfileView()
}
