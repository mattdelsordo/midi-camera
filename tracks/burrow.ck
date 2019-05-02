SndBuf burrow => Pan2 p => dac;
me.dir(-1) + "/audio/burrowing.wav" => burrow.read;
// set their pointers to end, to make no sound
burrow.samples() => burrow.pos;
[1,0,1,0,0,1,0,1] @=> int burrow_ptrn[];

BPM tempo;
0.4 => p.pan;

while(true){
    0 => int beat;
    while (beat < burrow_ptrn.cap()){
        if (burrow_ptrn[beat]){
            0 => burrow.pos;
        }
        tempo.quarterNote/2 => now;
        beat++;
    }
}