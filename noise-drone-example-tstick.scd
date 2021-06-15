(
Mapper.enable;
)

(
Ndef(\mapper, {
	var index, scale, buffer, amp, freq, density, sig;
	scale = { |i| Scale.hexDorian.degreeToFreq(i, 50, 0) } ! 36;
	buffer = scale.as(LocalBuf);
	freq = MapIn.kr(\freq, 0, 1).lincurve(0, 1, 20, 10e3, 8);
	index = IndexInBetween.kr(buffer, freq);
	freq = Index.kr(buffer, index);
	amp = MapIn.kr(\amp, 0, 1).lincurve(curve: 4);
	density = MapIn.kr(\cutoff, 0, 1).lincurve(0, 1, 0, 1, -4);
	sig = BHiPass4.ar(SelectX.ar(density, [WhiteNoise.ar, Mix(Saw.ar(50 * LFNoise1.kr(0.1).range(0.99, 1.01) ! 2))]), freq, 0.4) * amp;
	sig = sig + (Greyhole.ar(sig, 0.33, 0.1, 0.1, 0.707, 0.8, 0.001, 2) * 0.01);
	sig = sig * 0.25;
	Limiter.ar(SelectX.ar(0.001, [sig, JPverb.ar(sig, 4, 0.6)]));
}).play;
)