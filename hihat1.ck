SndBuf hihat1 => dac;
me.dir() + "/audio/hihat1.wav" => hihat1.read;
// set their pointers to end, to make no sound
hihat1.samples() => hihat1.pos;
[1,0,0,0,1,0,1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0] @=> int hihat1_ptrn[];
150 => float BPM; //defined BPM
(60/BPM)::second => dur quarter; //duration of a "beat"
100::ms => dur tempo;

while(true){
    0 => int beat;
    while (beat < hihat1_ptrn.cap()){
        if (hihat1_ptrn[beat]){
            0.6 => hihat1.gain;
            0 => hihat1.pos;
        }
        tempo => now;
        beat++;
    }
}