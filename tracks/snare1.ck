SndBuf snare => dac;
me.dir(-1) + "/audio/snare1.wav" => snare.read;
// set their pointers to end, to make no sound
snare.samples() => snare.pos;
[1,0,0,0,1,1,0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 1, 1, 0, 1] @=> int snare1_ptrn[];

BPM tempo;

0.7 => snare.gain;

while(true){
    0 => int beat;
    while (beat < snare1_ptrn.cap()){
        if (snare1_ptrn[beat]){
            0 => snare.pos;
        }
        tempo.quarterNote/4 => now;
        beat++;
    }
}