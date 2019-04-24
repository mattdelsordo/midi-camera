SndBuf cage => dac;
me.dir(-1) + "/audio/cageBars.wav" => cage.read;
// set their pointers to end, to make no sound
cage.samples() => cage.pos;
[1,1,0,1] @=> int cage_ptrn[];
136 => float BPM; //defined BPM
(60/BPM)::second => dur quarter; //duration of a "beat"

while(true){
    0 => int beat;
    while (beat < cage_ptrn.cap()){
        if (cage_ptrn[beat]){
            0.9 => cage.gain;
            0 => cage.pos;
        }
        quarter => now;
        beat++;
    }
}