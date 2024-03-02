import SwiftUI

enum FeedType: String, Hashable, CaseIterable {
	case forYou = "for you"
	case following
}

struct HomeView: View {
	@State private var selectedFeed: FeedType = .forYou

	var body: some View {
		VStack {
			TabBar(selectedTab: $selectedFeed) {
				Button(action: {}) {
					Text("search")
				}.foregroundStyle(.secondary)
			}.padding(.vertical, 10)

			TabView(selection: $selectedFeed) {
				FeedView(feedType: .forYou)
					.tag(FeedType.forYou)

				FeedView(feedType: .following)
					.tag(FeedType.following)
			}
			.tabViewStyle(.page(indexDisplayMode: .never))
		}
	}
}

#Preview {
	NavigationStack {
		HomeView()
	}
}
