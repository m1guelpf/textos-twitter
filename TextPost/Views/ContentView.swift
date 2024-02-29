import SwiftUI

enum AppTab: String, Hashable, CaseIterable {
	case home
	case profile
	case new
	case chat
}

struct ContentView: View {
	@State private var selectedTab: AppTab = .home

	var body: some View {
		VStack {
			NavigationStack {
				switch selectedTab {
					case .home:
						HomeView()
					case .profile:
						ProfileView()
					case .new:
						NewView()
					case .chat:
						ChatView()
				}
			}

			Spacer()

			TabBar(selectedTab: $selectedTab) {
				Text("write")
			}
		}
		.padding()
		.tint(.primary)
	}
}

#Preview {
	ContentView()
}
