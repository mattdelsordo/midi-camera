SndBuf water => Pan2 p => dac;
me.dir(-1) + "/audio/drinkingWater.wav" => water.read;
// set their pointers to end, to make no sound
water.samples() => water.pos;
[1,0,0,0,0,1,0,1] @=> int water_ptrn[];

BPM tempo;

-0.7 => p.pan;

0.8 => water.gain;

while(true){
    0 => int beat;
    while (beat < water_ptrn.cap()){
        if (water_ptrn[beat]){
            0 => water.pos;
        }
        tempo.quarterNote/4 => now;
        beat++;
    }
}