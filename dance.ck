SndBuf dance => dac;
me.dir() + "/audio/hamsterDance.wav" => dance.read;
// set their pointers to end, to make no sound
dance.samples() => dance.pos;

while (true){
    0.2 => dance.gain; //plays entire hamster dance on loop until turned off
    0 => dance.pos;
    2.5::minute => now; //advance time
}