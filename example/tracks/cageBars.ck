SndBuf cage => dac;
me.dir(-1) + "/audio/cageBars.wav" => cage.read;
// set their pointers to end, to make no sound
cage.samples() => cage.pos;
[1,1,0,1,0,1,0,1] @=> int cage_ptrn[];

BPM tempo;

0.8 => cage.gain;

while(true){
    // 0 => int beat;
    // while (beat < cage_ptrn.cap()){
    //     if (cage_ptrn[beat]){
    //         0 => cage.pos;
    //     }
    //     tempo.quarterNote/8 => now;
    //     beat++;
    // }
    0 => cage.pos;
    cage.samples()::samp => now;
}