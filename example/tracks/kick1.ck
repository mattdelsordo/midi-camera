SndBuf kick1 => Pan2 p => dac;
me.dir(-1) + "/audio/punchkick.wav" => kick1.read;
// set their pointers to end, to make no sound
kick1.samples() => kick1.pos;
[1,0,1,1,0,1,0,1] @=> int kick1_ptrn[];

BPM tempo;
0.4 => kick1.gain;
0.15 => p.pan;

while(true){
    0 => int beat;
    while (beat < kick1_ptrn.cap()){
        if (kick1_ptrn[beat]){
            0 => kick1.pos;
        }
        tempo.quarterNote/2 => now;
        beat++;
    }
}