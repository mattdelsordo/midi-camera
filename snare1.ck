SndBuf snare => dac;
me.dir() + "/audio/snare1.wav" => snare.read;
// set their pointers to end, to make no sound
snare.samples() => snare.pos;
[1,0,0,0,1,0,0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0] @=> int snare1_ptrn[];
150 => float BPM; //defined BPM
(60/BPM)::second => dur quarter; //duration of a "beat"
100::ms => dur tempo;

while(true){
    0 => int beat;
    while (beat < snare1_ptrn.cap()){
        if (snare1_ptrn[beat]){
            0.5 => snare.gain;
            0 => snare.pos;
        }
        tempo => now;
        beat++;
    }
}