import SwiftUI


struct ContentView: View {

    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager
    @State private var selectedTab: Tab = .home
        
        enum Tab {
            case home
            case player
            case settings
        }

    var body: some View {
        TabView(selection: $selectedTab) {
                    HomeView()
                        .tabItem {
                            Image(systemName: "house")
                            Text("Home")
                        }
                        .tag(Tab.home)
                    
                    PlayerView()
                        .tabItem {
                            Image(systemName: "music.note.list")
                            Text("Player")
                        }
                        .tag(Tab.player)
                    
                    ProfileView()
                        .tabItem {
                            Image(systemName: "person")
                            Text("Profile")
                        }
                        .tag(Tab.settings)
                }
        .task {
            try? await Task.sleep(for: Duration.seconds(1))
            self.launchScreenState.dismiss()
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(LaunchScreenStateManager())
    }
}
