SndBuf dance => dac;
me.dir(-1) + "/audio/hamsterDance.wav" => dance.read;
// set their pointers to end, to make no sound
dance.samples() => dance.pos;

// Adjust track tempo
BPM tempo;
136. => float TRACK_TEMPO;
tempo.BPM / TRACK_TEMPO => dance.rate;

while (true){
    0.2 => dance.gain; //plays entire hamster dance on loop until turned off
    0 => dance.pos;
    dance.samples()::samp => now; //advance time
}