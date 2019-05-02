SndBuf squirrel => Pan2 p => dac;
me.dir(-1) + "/audio/empnewgroove.wav" => squirrel.read;
// set their pointers to end, to make no sound
squirrel.samples() => squirrel.pos;
[1,0,0,0,0,0,1,1] @=> int sqrl_ptrn[];

BPM tempo;
3 => squirrel.gain;
-0.6 => p.pan;

while(true){
    0 => int beat;
    while (beat < sqrl_ptrn.cap()){
        if (sqrl_ptrn[beat]){
            squirrel.samples()/3 => squirrel.pos;
        }
        tempo.quarterNote => now;
        beat++;
    }
}