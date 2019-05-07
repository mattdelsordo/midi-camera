SndBuf wheel => Pan2 p => dac;
me.dir(-1) + "/audio/wheelRun.wav" => wheel.read;
// set their pointers to end, to make no sound
wheel.samples() => wheel.pos;
[1,0,0,0,1,0,0,0] @=> int wheel_ptrn[];

BPM tempo;
0.6 => wheel.gain;
-0.4 => p.pan;

while(true){
    0 => int beat;
    while (beat < wheel_ptrn.cap()){
        if (wheel_ptrn[beat]){
            0 => wheel.pos;
        }
        tempo.quarterNote/2 => now;
        beat++;
    }
}