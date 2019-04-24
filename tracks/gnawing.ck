SndBuf gnaw => dac;
me.dir(-1) + "/audio/gnawing.wav" => gnaw.read;
// set their pointers to end, to make no sound
gnaw.samples() => gnaw.pos;
[0,1,1,0,0,0,1,0] @=> int gnawing_ptrn[];
136 => float BPM; //defined BPM
(60/BPM)::second => dur quarter; //duration of a "beat"

while(true){
    0 => int beat;
    while (beat < gnawing_ptrn.cap()){
        if (gnawing_ptrn[beat]){
            0.4 => gnaw.gain;
            0 => gnaw.pos;
        }
        quarter => now;
        beat++;
    }
}