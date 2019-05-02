SndBuf dance => Pan2 p => dac;
me.dir(-1) + "/audio/hamsterDance4.wav" => dance.read;
// set their pointers to end, to make no sound
dance.samples() => dance.pos;
0.3 => dance.gain;
-0.3 => p.pan;

// Adjust track tempo
BPM tempo;
136. => float TRACK_TEMPO;
tempo.BPM / TRACK_TEMPO => dance.rate;
1 => dance.gain;

while (true){
    // start track AFTER the pickup note
    0 => dance.pos;
    dance.samples()::samp => now; //advance time
}