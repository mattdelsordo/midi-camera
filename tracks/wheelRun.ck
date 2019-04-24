SndBuf wheel => dac;
me.dir(-1) + "/audio/wheelRun.wav" => wheel.read;
// set their pointers to end, to make no sound
wheel.samples() => wheel.pos;
[1,0,0,0,1,0,0,0] @=> int wheel_ptrn[];
136 => float BPM; //defined BPM
(60/BPM)::second => dur quarter; //duration of a "beat"

while(true){
    0 => int beat;
    while (beat < wheel_ptrn.cap()){
        if (wheel_ptrn[beat]){
            0.4 => wheel.gain;
            0 => wheel.pos;
        }
        quarter => now;
        beat++;
    }
}