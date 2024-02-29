import Foundation

let isoDate: ISO8601DateFormatter = {
	let formatter = ISO8601DateFormatter()
	formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
	return formatter
}()

struct Post: Identifiable {
	var id: UUID
	var text: String
	var username: String
	var date: Date
	var image: String?

	init(id: UUID = UUID(), text: String, username: String, image: String? = nil, date: Date) {
		self.id = id
		self.text = text
		self.date = date
		self.image = image
		self.username = username
	}

	init(id: UUID = UUID(), text: String, username: String, image: String? = nil, dateString: String) {
		self.init(
			id: id,
			text: text,
			username: username,
			image: image,
			date: isoDate.date(from: dateString)!
		)
	}
}

var posts: [Post] = [
	Post(
		text: "Is YC still a status symbol? A lot of the startups I’ve seen from recent batches are gpt wrappers at best. They don’t seem to be fronting the cutting edge anymore",
		username: "avighnash",
		dateString: "2024-02-29T00:29:04.000Z"
	),
	Post(text: "eeeeeeeeeeeeeee", username: "vivianphung", dateString: "2024-02-29T01:13:19.000Z"),
	Post(
		text: "Anyone who has not heard their Apple Silicon machine's fans has not performed a long ffmpeg conversion",
		username: "ChristianSelig",
		dateString: "2024-02-28T19:22:21.000Z"
	),
	Post(
		text: "will be kinda funny/poetic if after AI-generated blogspam content floods the web, a bunch of netscape navigators and internet explorers rally together in secret to share links to human-made content",
		username: "visakanv",
		dateString: "2024-02-28T15:25:38.000Z"
	),
	Post(
		text: "i like collecting pokemon\n\n(friends that I can see on Find My)",
		username: "DeveloperHarris",
		dateString: "2024-02-28T21:13:07.000Z"
	),
	Post(
		text: "Story about AI bias:\n\nIn 10th grade I wanted to make a fun little interactive exhibit so I riffed on the idea of how smiling actually improves your mood.\n\nI made a raspberry pi powered screen that detected if you're smiling and then counted down for 30 seconds.\n\nBut it was very strange and erratic. It'd work really well with some people and not detect others at all.\n\nThe thing is, the training data I scraped from google of people smiling was like mainly white people. So it turns out I hadn't made a SMILE detector, I'd made a WHITE PERSON detector.\n\nAnd that's when I learnt the value of looking at your training data, not scraping from google images (it's fixed now), and having diverse data sets 😌",
		username: "SarvasvKulpati",
		dateString: "2024-02-28T08:29:02.000Z"
	),
	Post(text: "my body, silicon. my spirit, networked.", username: "ChatGPTapp", dateString: "2024-02-29T01:23:19.000Z"),
	Post(text: "luck is just as relevant to the creative process as it is to every other aspect of life", username: "SHL0MS", dateString: "2024-02-29T00:15:26.000Z"),
	Post(text: "you’re telling me an *object* oriented this programming?", username: "mycoliza", dateString: "2024-02-28T17:17:25.000Z"),
	Post(text: "Rust: Rustaceans\nPython: Pythonistas\nGo: Gophers\nC: Criminals", username: "schteppe", dateString: "2024-02-28T07:27:02.000Z"),
	Post(text: "Meet my concept. I think Browse for Me could work beautifully on the Apple Watch. What do you think?", username: "iamnalimov", image: "arc-on-watch", dateString: "2024-02-28T18:53:08.000Z"),
]
