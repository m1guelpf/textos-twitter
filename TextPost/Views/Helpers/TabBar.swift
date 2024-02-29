import SwiftUI

struct TabBar<Tab, Content>: View where
	Content: View,
	Tab.RawValue == String,
	Tab.AllCases: RandomAccessCollection,
	Tab: Hashable & CaseIterable & RawRepresentable
{
	@Binding var selectedTab: Tab
	let extraContent: Content

	init(selectedTab: Binding<Tab>, @ViewBuilder extraContent: () -> Content) {
		_selectedTab = selectedTab
		self.extraContent = extraContent()
	}

	init(selectedTab: Binding<Tab>) where Content == EmptyView {
		self.init(selectedTab: selectedTab) {
			EmptyView()
		}
	}

	private var scrollBinding: Binding<Tab?> {
		Binding(
			get: { selectedTab },
			set: {
				guard let tab = $0 else { return }

				withAnimation {
					selectedTab = tab
				}
			}
		)
	}

	private var scrollOffset: CGFloat {
		switch Tab.allCases.count {
			case 2: return 280
			case 4: return 300
			default: fatalError("Unsupported number of tabs")
		}
	}

	var body: some View {
		HStack {
			ScrollView(.horizontal, showsIndicators: false) {
				HStack {
					ForEach(Tab.allCases, id: \.self) { tab in
						Button(action: { withAnimation { selectedTab = tab } }) {
							Text(tab.rawValue).id(tab)
						}
						.buttonStyle(FlatButtonStyle())
						.foregroundStyle(selectedTab == tab ? .primary : .secondary)
					}

					Spacer(minLength: scrollOffset)
				}.scrollTargetLayout()
			}
			.scrollTargetBehavior(.viewAligned)
			.scrollPosition(id: scrollBinding)
			.safeAreaPadding(.horizontal)

			Spacer()
		}.overlay {
			HStack {
				Spacer()

				HStack {
					extraContent
				}
			}
		}.padding(.trailing)
	}
}

private struct TabBar_PreviewWithState: View {
	@State private var selectedTab: AppTab = .home

	var body: some View {
		TabBar(selectedTab: $selectedTab)
	}
}

#Preview {
	TabBar(selectedTab: .constant(AppTab.home))
		.previewLayout(.sizeThatFits)
}

#Preview("Home") {
	TabBar(selectedTab: .constant(FeedType.forYou))
		.previewLayout(.sizeThatFits)
}

#Preview("With State") {
	TabBar_PreviewWithState()
		.previewLayout(.sizeThatFits)
}
