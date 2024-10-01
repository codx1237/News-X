//
//  SecondView.swift
//  NewsX
//
//  Created by Fırat Ören on 25.09.2024.
//

import SwiftUI

enum Tab {
    case home
    case explore
    case favorite
    case profile
}


struct MainView: View {
    @State private var selectedTab: Tab = .explore
    
    var body: some View {
        VStack {
           // Spacer()

            switch selectedTab {
            case .home:
                HomeView()
            case .explore:
                ExploreView()
            case .favorite:
                FavoriteView()
            case .profile:
                ProfileView()
            }
            Spacer()
            CustomTab(selectedTab: $selectedTab)

        }
    }
}


struct CustomTab: View {
    @Binding var selectedTab: Tab
    var body: some View {
        VStack {
            HStack{
                Spacer()
                TabbarButton(icon: "house", tab: .home, iconText: "Home", selectedTab: $selectedTab)
                Spacer()
                TabbarButton(icon: "globe", tab: .explore, iconText: "Explore", selectedTab: $selectedTab)
                Spacer()
                TabbarButton(icon: "heart.fill", tab: .favorite, iconText: "Favorite", selectedTab: $selectedTab)
                Spacer()
                TabbarButton(icon: "person.fill", tab: .profile, iconText: "Profile", selectedTab: $selectedTab)
                Spacer()
            }
             .frame(maxWidth: .infinity)
             .background(Color.black)
             .cornerRadius(12)
             .shadow(radius: 10)
             .padding(.horizontal)


        }
    }
}

struct TabbarButton: View {
    let icon: String
    let tab: Tab
    let iconText: String
    @Binding var selectedTab: Tab
    var body: some View {
        Button {
            selectedTab = tab
        } label: {
            HStack{
                Image(systemName: icon)
                    .font(.system(size: 20))
                Text(selectedTab == tab ? "\(iconText)" : "")
                    .font(.system(size: 14))
            }
            .bold()
            .padding()
            .foregroundStyle(selectedTab == tab ? Color.black : Color.white)
            .background(selectedTab == tab ? Color.white : Color.black)
            .cornerRadius(selectedTab == tab ? 12 : 1)

        }
    }
}


#Preview {
    MainView()
}
