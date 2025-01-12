//
//  ContentView.swift
//  ChatterBox
//
//  Created by jatin foujdar on 11/01/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            Text("Breaking Bad View")
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem{
                    Label("Breaking Bad", systemImage: "tortoise")
                }
            Text("Better Call Saul View")
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem{
                    Label("Breaking Bad", systemImage: "briefcase")
                }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
