SndBuf gnaw => Pan2 p => dac;
me.dir(-1) + "/audio/gnawing.wav" => gnaw.read;
// set their pointers to end, to make no sound
gnaw.samples() => gnaw.pos;
[0,1,1,0,0,0,1,0] @=> int gnawing_ptrn[];

BPM tempo;
-0.1 => p.pan;

while(true){
    0 => int beat;
    while (beat < gnawing_ptrn.cap()){
        if (gnawing_ptrn[beat]){
            0.4 => gnaw.gain;
            0 => gnaw.pos;
        }
        tempo.quarterNote/2 => now;
        beat++;
    }
}