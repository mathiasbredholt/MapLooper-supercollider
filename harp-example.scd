(
fork {
	Mapper.enable;
	// Wait 2 seconds for libmapper initialization
	2.wait;
	{
		var index, scale, freqCtl, freq, amp, src, trig;
		// Create buffer with pentatonic minor scale
		scale = 36.collect{ |i|
			Scale.minorPentatonic.degreeToFreq(i, 50, 0);
		}.as(LocalBuf);
		// libmapper input signals
		freq = MapIn.kr(name: \freq, min: 50, max: 2000).lincurve(50, 2000, 50, 2000, 4);
		amp = MapIn.kr(name: \amp, min: 0, max: 1);
		// Quantize frequency to pitch
		freq = Index.kr(bufnum: scale, in: IndexInBetween.kr(scale, freq));
		// Trigger the string on change
		trig = Changed.kr(freq);
		// Karplus-Strong string model
		src = Pluck.ar(in: PinkNoise.ar, trig: K2A.ar(trig), delaytime: 1 / freq, decaytime: 10, coef: 0.2);
		src = src * 0.5 * amp.lincurve;
		SelectX.ar(0.08, [src, JPverb.ar(src, 8, 0.6)]);
	}.play;
}
)