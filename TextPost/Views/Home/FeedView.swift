import UIKit
import SwiftUI

struct FeedView: View {
	var feedType: FeedType
	@Environment(\.colorScheme) var colorScheme

	@State private var progress = CGFloat.zero

	var shadowColor: Color {
		colorScheme == .dark ? .black : .white
	}

	var body: some View {
		ProgressAwareScrollView(progress: $progress) {
			LazyVStack(spacing: 35) {
				ForEach(posts) { post in
					NavigationLink {
						VStack(alignment: .leading) {
							FeedItem(post: post, expanded: true)

							Spacer()
						}
						.padding()
					} label: {
						FeedItem(post: post)
					}.buttonStyle(.plain)
				}
			}.padding(.horizontal)
		}
		.overlay {
			VStack {
				Rectangle()
					.fill(.linearGradient(colors: [shadowColor.opacity(0), shadowColor.opacity(0.5), shadowColor], startPoint: .bottom, endPoint: .top))
					.opacity(progress > 0 ? 1 : 0)
					.animation(.easeInOut, value: progress)
					.frame(height: 50)

				Spacer()

				Rectangle()
					.fill(.linearGradient(colors: [shadowColor.opacity(0), shadowColor.opacity(0.5), shadowColor], startPoint: .top, endPoint: .bottom))
					.opacity(progress < 0.95 ? 1 : 0)
					.animation(.default, value: progress)
					.frame(height: 50)
			}
		}
	}
}

#Preview {
	NavigationStack {
		FeedView(feedType: .forYou)
	}
}
