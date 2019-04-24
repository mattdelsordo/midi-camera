SndBuf wasabi => dac;
me.dir(-1) + "/audio/djwasabi.wav" => wasabi.read;
// set their pointers to end, to make no sound
wasabi.samples() => wasabi.pos;
[0,1,0,1, 0,0, 0, 0] @=> int wasabi_ptrn[];

BPM tempo;

while(true){
    0 => int beat;
    while (beat < wasabi_ptrn.cap()){
        if (wasabi_ptrn[beat]){
            0.5 => wasabi.gain;
            0 => wasabi.pos;
        }
        tempo.quarterNote => now;
        beat++;
    }
}