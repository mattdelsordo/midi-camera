SndBuf bass => dac;
me.dir(-1) + "/audio/bass.wav" => bass.read;
// set their pointers to end, to make no sound
bass.samples() => bass.pos;
[1,0,1,1,1,0,1,0] @=> int bass_ptrn[];
136 => float BPM; //defined BPM
(60/BPM)::second => dur quarter; //duration of a "beat"

while(true){
    0 => int beat;
    while (beat < bass_ptrn.cap()){
        if (bass_ptrn[beat]){
            0.2 => bass.gain;
            0 => bass.pos;
        }
        quarter => now;
        beat++;
    }
}