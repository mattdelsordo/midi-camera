SndBuf gerb => dac;
me.dir() + "/audio/gerbil.wav" => gerb.read;
// set their pointers to end, to make no sound
gerb.samples() => gerb.pos;
[0,1,0,1] @=> int gerbil_ptrn[];
136 => float BPM; //defined BPM
(60/BPM)::second => dur quarter; //duration of a "beat"

while(true){
    0 => int beat;
    while (beat < gerbil_ptrn.cap()){
        if (gerbil_ptrn[beat]){
            0.4 => gerb.gain;
            0 => gerb.pos;
        }
        quarter => now;
        beat++;
    }
}