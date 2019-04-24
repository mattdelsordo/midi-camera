SndBuf wheel => dac;
me.dir(-1) + "/audio/wheelRun.wav" => wheel.read;
// set their pointers to end, to make no sound
wheel.samples() => wheel.pos;
[1,0,0,0,1,0,0,0] @=> int wheel_ptrn[];

BPM tempo;

while(true){
    0 => int beat;
    while (beat < wheel_ptrn.cap()){
        if (wheel_ptrn[beat]){
            0.4 => wheel.gain;
            0 => wheel.pos;
        }
        tempo.quarterNote => now;
        beat++;
    }
}