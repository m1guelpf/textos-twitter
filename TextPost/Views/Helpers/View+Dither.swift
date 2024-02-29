import SwiftUI

private struct DitherModifier: ViewModifier {
	var amount: CGFloat = 4.39
	var grayscale: Bool = false

	func body(content: Content) -> some View {
		content
			.drawingGroup()
			.layerEffect(ShaderLibrary.dithering(.float(1), .float(amount), .float(grayscale ? 1 : 0)), maxSampleOffset: .zero)
	}
}

extension View {
	func dither(amount: CGFloat = 4.39, grayscale: Bool = false) -> some View {
		modifier(DitherModifier(amount: amount, grayscale: grayscale))
	}
}
