SndBuf eat => dac;
me.dir(-1) + "/audio/eating.wav" => eat.read;
// set their pointers to end, to make no sound
eat.samples() => eat.pos;
[0,1,1,0,0,0,1,0] @=> int eating_ptrn[];

BPM tempo;

while(true){
    0 => int beat;
    while (beat < eating_ptrn.cap()){
        if (eating_ptrn[beat]){
            0.8 => eat.gain;
            0 => eat.pos;
        }
        tempo.quarterNote => now;
        beat++;
    }
}