import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            // Breaking Bad View
            Tab("Breaking Bad", systemImage: "tortoise"){
                QuoteView(show: "Breaking Bad")
                    .toolbarBackground(.visible, for: .tabBar)
            }
            
            // Better Call Saul View
            Tab("Better Call Saul", systemImage: "briefcase"){
                QuoteView(show: "Better Call Saul")
                    .toolbarBackground(.visible, for: .tabBar)
                
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
