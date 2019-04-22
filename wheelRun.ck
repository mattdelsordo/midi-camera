SndBuf wheel => dac;
me.dir() + "/audio/wheelRun.wav" => wheel.read;
// set their pointers to end, to make no sound
wheel.samples() => wheel.pos;
[1,0,1,0,1,0,1,0] @=> int wheel_ptrn[];

while (true){
    for (0 => int beats; beats < wheel_ptrn.cap(); beats++){
        if (wheel_ptrn[beats]){
            0.5 => wheel.gain;
            0 => wheel.pos;
            0.5::second => now; //advance time
        }
    }
}