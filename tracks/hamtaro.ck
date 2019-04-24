SndBuf hamtaro => dac;
me.dir(-1) + "/audio/hamtaroTheme.wav" => hamtaro.read;
// set their pointers to end, to make no sound
hamtaro.samples() => hamtaro.pos;

// Adjust track tempo
BPM tempo;
126. => float TRACK_TEMPO;
tempo.BPM / TRACK_TEMPO => hamtaro.rate;

while (true){
    0.2 => hamtaro.gain; //plays entire hamtaro theme on loop until turned off
    0 => hamtaro.pos;
    hamtaro.samples()::samp => now; //advance time
    <<<hamtaro.samples()>>>;
}