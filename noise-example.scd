(
Mapper.enable;
)

(
Ndef(\noise, {
	var index, scale, buffer, freq, sig, fenv, amp;
	freq = MapIn.kr(name: \freq, min: 20, max: 5000).lincurve(20, 5000, 20, 5000, 2);
	amp = MapIn.kr(name: \amp, min: 0, max: 1).lincurve;
	sig = MoogVCF.ar(PinkNoise.ar, freq, 1) * 0.5;
	SelectX.ar(0.1, [sig, JPverb.ar(sig, 8, 0.6)]);
}).play;
)