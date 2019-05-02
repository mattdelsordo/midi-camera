SndBuf gerb => dac;
me.dir(-1) + "/audio/gerbil.wav" => gerb.read;
// set their pointers to end, to make no sound
gerb.samples() => gerb.pos;
[1,1,1,0,0,1,1,0] @=> int gerbil_ptrn[];

BPM tempo;

0.2 => gerb.gain;

while(true){
    0 => int beat;
    while (beat < gerbil_ptrn.cap()){
        if (gerbil_ptrn[beat]){
            0 => gerb.pos;
        }
        tempo.quarterNote/2 => now;
        beat++;
    }
}