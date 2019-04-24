SndBuf kick1 => dac;
me.dir(-1) + "/audio/punchkick.wav" => kick1.read;
// set their pointers to end, to make no sound
kick1.samples() => kick1.pos;
[1,0,1,1, 0, 1, 1, 0] @=> int kick1_ptrn[];
136 => float BPM; //defined BPM
(60/BPM)::second => dur quarter; //duration of a "beat"

while(true){
    0 => int beat;
    while (beat < kick1_ptrn.cap()){
        if (kick1_ptrn[beat]){
            0.4 => kick1.gain;
            0 => kick1.pos;
        }
        quarter => now;
        beat++;
    }
}