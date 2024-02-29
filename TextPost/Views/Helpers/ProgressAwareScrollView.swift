import UIKit
import SwiftUI

struct ProgressAwareScrollView<Content: View>: UIViewRepresentable {
	@Binding var progress: CGFloat
	let content: () -> Content

	class Coordinator: NSObject, UIScrollViewDelegate {
		var parent: ProgressAwareScrollView
		var innerView: UIHostingController<Content>?

		init(parent: ProgressAwareScrollView) {
			self.parent = parent
		}

		func scrollViewDidScroll(_ scrollView: UIScrollView) {
			let offset = scrollView.contentOffset.y
			let totalHeight = scrollView.contentSize.height - scrollView.frame.height

			parent.progress = CGFloat(offset / totalHeight)
		}
	}

	func makeCoordinator() -> Coordinator {
		Coordinator(parent: self)
	}

	func makeUIView(context: Context) -> UIScrollView {
		let scrollView = UIScrollView()
		scrollView.delegate = context.coordinator

		let hostView = UIHostingController(rootView: content())
		context.coordinator.innerView = hostView

		hostView.view.translatesAutoresizingMaskIntoConstraints = false
		scrollView.addSubview(hostView.view)

		NSLayoutConstraint.activate([
			hostView.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
			hostView.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
			hostView.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
			hostView.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
			hostView.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
		])

		return scrollView
	}

	func sizeThatFits(_ proposal: ProposedViewSize, uiView: UIScrollView, context: Context) -> CGSize? {
		let size = uiView.systemLayoutSizeFitting(
			CGSize(
				width: proposal.width ?? UIView.layoutFittingCompressedSize.width,
				height: proposal.height ?? UIView.layoutFittingCompressedSize.height
			),
			withHorizontalFittingPriority: .required,
			verticalFittingPriority: .defaultLow
		)

		let innerSize = context.coordinator.innerView!.sizeThatFits(in: size)
		context.coordinator.innerView!.view.frame = CGRect(origin: .zero, size: innerSize)

		return proposal.replacingUnspecifiedDimensions(by: size)
	}

	func updateUIView(_: UIScrollView, context _: Context) {}
}

#Preview {
	ProgressAwareScrollView(progress: .constant(0)) {
		LazyVStack(alignment: .leading, spacing: 20) {
			ForEach(0..<100) { index in
				Text("Row \(index + 1)")
			}
		}
	}.padding()
}
