import SwiftUI

enum AppTab: String, Hashable, CaseIterable {
	case home
	case profile
	case new
	case chat
}

struct ContentView: View {
	@State private var selectedTab: AppTab = .home
	@State private var showWriteView: Bool = false
	@State private var newPost = ""

	@Environment(\.colorScheme) var colorScheme
	@FocusState private var isWriteViewFocused: Bool

	var bgColor: Color {
		colorScheme == .dark ? .black : .white
	}

	var body: some View {
		VStack {
			ZStack {
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

				ZStack {
					bgColor.ignoresSafeArea()

					TextEditor(text: $newPost)
						.focused($isWriteViewFocused)
						.lineLimit(3)
						.padding(.top, 30)
				}.opacity(showWriteView ? 1 : 0)
			}

			Spacer()

			TabBar(selectedTab: $selectedTab, showTabs: !showWriteView) {
				Button(action: toggleWriteView) {
					Text(showWriteView ? "send" : "write")
				}
			}
		}
		.padding()
		.tint(.primary)
	}

	func toggleWriteView() {
		isWriteViewFocused.toggle()

		withAnimation(.bouncy) {
			showWriteView.toggle()
		}
	}
}

#Preview {
	ContentView()
}
