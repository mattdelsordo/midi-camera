SndBuf gerb => dac;
me.dir(-1) + "/audio/gerbil.wav" => gerb.read;
// set their pointers to end, to make no sound
gerb.samples() => gerb.pos;
[0,1,0,1] @=> int gerbil_ptrn[];

BPM tempo;

while(true){
    0 => int beat;
    while (beat < gerbil_ptrn.cap()){
        if (gerbil_ptrn[beat]){
            0.4 => gerb.gain;
            0 => gerb.pos;
        }
        tempo.quarterNote => now;
        beat++;
    }
}