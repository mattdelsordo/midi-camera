SndBuf clap => dac;
me.dir(-1) + "/audio/clap.wav" => clap.read;
// set their pointers to end, to make no sound
clap.samples() => clap.pos;
[1,1,1,1,1,0,1,0] @=> int clap_ptrn[];
136 => float BPM; //defined BPM
(60/BPM)::second => dur quarter; //duration of a "beat"

while(true){
    0 => int beat;
    while (beat < clap_ptrn.cap()){
        if (clap_ptrn[beat]){
            0.4 => clap.gain;
            0 => clap.pos;
        }
        quarter => now;
        beat++;
    }
}