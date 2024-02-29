import SwiftUI

struct FeedItem: View {
	var post: Post
	var expanded: Bool = false

	var text: String {
		if expanded { return post.text }

		return post.text.prefix(240) + (post.text.count > 240 ? "..." : "")
	}

	var timeSincePublished: String {
		let timeInterval = Date().timeIntervalSince(post.date)

		if timeInterval < 60 {
			return "now"
		} else if timeInterval < 3600 {
			return "\(Int(timeInterval / 60))m"
		} else if timeInterval < 86400 {
			return "\(Int(timeInterval / 3600))h"
		} else {
			return "\(Int(timeInterval / 86400))d"
		}
	}

	var body: some View {
		VStack(alignment: .leading, spacing: 10) {
			Text(text)
				.foregroundStyle(.primary)
				.bold()

			HStack {
				Text("@\(post.username)") + Text(" – ") + Text(timeSincePublished)
			}.foregroundStyle(.secondary)
		}.frame(maxWidth: .infinity, alignment: .leading)
	}
}

#Preview {
	FeedItem(post: Post(text: "just setting up my twttr", username: "jack", dateString: Date().ISO8601Format()))
		.previewLayout(.sizeThatFits)
}
