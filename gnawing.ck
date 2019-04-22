SndBuf gnaw => dac;
me.dir() + "/audio/gnawing.wav" => gnaw.read;
// set their pointers to end, to make no sound
gnaw.samples() => gnaw.pos;
[0,1,1,0,0,0,1,0] @=> int gnawing_ptrn[];

while (true){
    for (0 => int beats; beats < gnawing_ptrn.cap(); beats++){
        if (gnawing_ptrn[beats]){
            0.5 => gnaw.gain;
            0 => gnaw.pos;
            1::second => now; //advance time
        }
    }
}