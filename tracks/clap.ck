SndBuf clap => dac;
me.dir(-1) + "/audio/clap.wav" => clap.read;
// set their pointers to end, to make no sound
clap.samples() => clap.pos;
[1,1,1,1,1,0,1,0] @=> int clap_ptrn[];
0.6 => clap.gain;

BPM tempo;

while(true){
    0 => int beat;
    while (beat < clap_ptrn.cap()){
        if (clap_ptrn[beat]){
            0 => clap.pos;
        }
        tempo.quarterNote/2 => now;
        beat++;
    }
}