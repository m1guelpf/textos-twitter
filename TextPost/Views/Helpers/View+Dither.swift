import SwiftUI

private struct DitherModifier: ViewModifier {
	var isEnabled: Bool = true
	var amount: CGFloat = 4.39
	var grayscale: Bool = false

	func body(content: Content) -> some View {
		content
			.drawingGroup()
			.layerEffect(ShaderLibrary.dithering(.float(1), .float(amount), .float(grayscale ? 1 : 0)), maxSampleOffset: .zero, isEnabled: isEnabled)
	}
}

extension View {
	func dither(isEnabled: Bool = true, amount: CGFloat = 4.39, grayscale: Bool = false) -> some View {
		modifier(DitherModifier(isEnabled: isEnabled, amount: amount, grayscale: grayscale))
	}
}
