import UIKit
import SwiftUI

struct FeedView: View {
	var feedType: FeedType

	@State private var progress = CGFloat.zero

	var body: some View {
		ProgressAwareScrollView(progress: $progress) {
			LazyVStack(spacing: 35) {
				ForEach(posts) { post in
					NavigationLink(destination: FeedItem(post: post, expanded: true)) {
						FeedItem(post: post)
					}.buttonStyle(.plain)
				}
			}.padding(.horizontal)
		}
		.overlay {
			VStack {
				Rectangle()
					.fill(.linearGradient(colors: [.black.opacity(0), .black.opacity(0.5), .black], startPoint: .bottom, endPoint: .top))
					.opacity(progress > 0.1 ? 1 : 0)
					.animation(.default, value: progress)
					.frame(height: 50)

				Spacer()

				Rectangle()
					.fill(.linearGradient(colors: [.black.opacity(0), .black.opacity(0.5), .black], startPoint: .top, endPoint: .bottom))
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
