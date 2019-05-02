SndBuf hamtaro => Pan2 p => dac;
me.dir(-1) + "/audio/hamtaroTheme3.wav" => hamtaro.read;
// set their pointers to end, to make no sound
hamtaro.samples() => hamtaro.pos;
0.3 => p.pan;

// Adjust track tempo
BPM tempo;
126. => float TRACK_TEMPO;
tempo.BPM / TRACK_TEMPO => hamtaro.rate;
0.5 => hamtaro.gain; //plays entire hamtaro theme on loop until turned off

while (true){
    0 => hamtaro.pos;
    hamtaro.samples()::samp => now; //advance time
}