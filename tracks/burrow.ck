SndBuf burrow => dac;
me.dir(-1) + "/audio/burrowing.wav" => burrow.read;
// set their pointers to end, to make no sound
burrow.samples() => burrow.pos;
[1,0,1,0,1,1,1,0] @=> int burrow_ptrn[];

BPM tempo;

while(true){
    0 => int beat;
    while (beat < burrow_ptrn.cap()){
        if (burrow_ptrn[beat]){
            0.4 => burrow.gain;
            0 => burrow.pos;
        }
        tempo.quarterNote => now;
        beat++;
    }
}