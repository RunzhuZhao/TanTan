//
//  ContentView.swift
//  TanTan
//
//  Created by Run on 2024/3/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var appState = AppState()
    @State var selectedTab: TabItem = .live
    var body: some View {
        VStack {
            switch appState.selectedTab {
            case .home:
                Text("Home")
            case .live:
                Text("Live")
            case .message:
                Text("Message")
            case .profile:
                Text("Profile")
            }
            
            if !appState.isFullScreen {
                Spacer()
                HStack {
                    createTabBarItem(tab: .home, title: "Home")
                    createTabBarItem(tab: .live, title: "Live")
                    createTabBarItem(tab: .message, title: "Message")
                    createTabBarItem(tab: .profile, title: "Profile")
                }
            }
        }
        
    }
    
    func createTabBarItem(tab: TabItem, title: String) -> some View {
        Button {
            appState.selectedTab = tab
        } label: {
            VStack {
                Image(systemName: tab.rawValue)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(appState.selectedTab == tab ? .accentColor : .gray.opacity(0.5))
                    .frame(maxWidth: .infinity)
                Text(title)
                    .font(.system(size: 10))
                    .foregroundColor(appState.selectedTab == tab ? .accentColor : .gray.opacity(0.5))
            }
        }
        
    }
}

enum TabItem: String {
    case home = "rectangle.fill.on.rectangle.fill"
    case live = "play.tv.fill"
    case message = "message.fill"
    case profile = "person.fill"
}

#Preview {
    ContentView()
}
