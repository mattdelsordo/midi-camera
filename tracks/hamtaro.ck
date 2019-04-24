SndBuf hamtaro => dac;
me.dir(-1) + "/audio/hamtaroTheme.wav" => hamtaro.read;
// set their pointers to end, to make no sound
hamtaro.samples() => hamtaro.pos;

while (true){
    0.2 => hamtaro.gain; //plays entire hamtaro theme on loop until turned off
    0 => hamtaro.pos;
    68::second => now; //advance time
}