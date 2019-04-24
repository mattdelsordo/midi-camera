SndBuf eat => dac;
me.dir() + "/audio/eating.wav" => eat.read;
// set their pointers to end, to make no sound
eat.samples() => eat.pos;
[0,1,1,0,0,0,1,0] @=> int eating_ptrn[];
136 => float BPM; //defined BPM
(60/BPM)::second => dur quarter; //duration of a "beat"

while(true){
    0 => int beat;
    while (beat < eating_ptrn.cap()){
        if (eating_ptrn[beat]){
            0.8 => eat.gain;
            0 => eat.pos;
        }
        quarter => now;
        beat++;
    }
}