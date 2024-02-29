#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

// https://en.wikipedia.org/wiki/Ordered_dithering
constant half4x4 bayerMatrix = {
	{00.0/16.0, 12.0/16.0, 03.0/16.0, 15.0/16.0},
	{08.0/16.0, 04.0/16.0, 11.0/16.0, 07.0/16.0},
	{02.0/16.0, 14.0/16.0, 01.0/16.0, 13.0/16.0},
	{10.0/16.0, 06.0/16.0, 09.0/16.0, 05.0/16.0}
};

/// Photoshop's Luminosity Method
constant half3 grayscaleCoefficients = {0.299, 0.587, 0.114};

[[ stitchable ]] half4 dithering(float2 position, SwiftUI::Layer layer, float strength, float pixel_size, float useGrayscale) {
	half4 original_color = layer.sample(position);

	// apply gamma correction
	original_color = half4(pow(original_color.rgb, half3(2.2)) - 0.004, original_color.a);

	// calculate luminance
	float luminance = dot(original_color.rgb, grayscaleCoefficients);
	half3 grayscale_color = half3(luminance);

	// apply grayscale effect if `useGrayscale` is 1 (better perf than an if statement)
	original_color.rgb = mix(original_color.rgb, grayscale_color, useGrayscale);


	int size = int(pixel_size);

	// find bayer matrix entry based on position
	float bayerValue = bayerMatrix[int(position.x) % size][int(position.y) % size];

	float r = original_color.r;
	float g = original_color.g;
	float b = original_color.b;


	// apply effect
	half4 effect = half4(step(bayerValue,r), step(bayerValue,g), step(bayerValue,b), original_color.a);

	// mix original color (or grayscale) with effect based on strength
	return mix(original_color, effect, strength);
}
