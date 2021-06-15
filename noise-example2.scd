(
Mapper.enable;
)

(
Ndef(\noise, {
	var index, scale, buffer, freq, sig, fenv, amp;
	freq = MapIn.kr(name: \freq, min: 50, max: 5000).lincurve(50, 5000, 50, 5000, -4);
	amp = MapIn.kr(name: \amp, min: 0, max: 1).lincurve;
	sig = BHiPass4.ar(WhiteNoise.ar, freq, 0.04) * 0.5 * amp;
	SelectX.ar(0.04, [sig, JPverb.ar(sig, 8, 0.6)]);
}).play;
)