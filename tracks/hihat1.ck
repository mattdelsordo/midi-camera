SndBuf hihat1 => dac;
me.dir(-1) + "/audio/hihat1.wav" => hihat1.read;
// set their pointers to end, to make no sound
hihat1.samples() => hihat1.pos;
[1,0,1, 0, 0, 1, 1, 1] @=> int hihat1_ptrn[];

BPM tempo;
0.6 => hihat1.gain;

while(true){
    0 => int beat;
    while (beat < hihat1_ptrn.cap()){
        if (hihat1_ptrn[beat]){
            0 => hihat1.pos;
        }
        tempo.quarterNote/2 => now;
        beat++;
    }
}