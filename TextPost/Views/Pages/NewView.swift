import SwiftUI

struct NewView: View {
	var body: some View {
		VStack {
			Text("New")
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(.teal)
	}
}

#Preview {
	NewView()
}
