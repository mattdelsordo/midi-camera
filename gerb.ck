SndBuf gerb => dac;
me.dir() + "/audio/gerbil.wav" => gerb.read;
// set their pointers to end, to make no sound
gerb.samples() => gerb.pos;
[1,0,1,0,1,0,0,0] @=> int gerbil_ptrn[];

while (true){
    for (0 => int beats; beats < gerbil_ptrn.cap(); beats++){
        if (gerbil_ptrn[beats]){
            0.5 => gerb.gain;
            0 => gerb.pos;
            1::second => now; //advance time
        }
    }
}