SndBuf squirrel => dac;
me.dir(-1) + "/audio/empnewgroove.wav" => squirrel.read;
// set their pointers to end, to make no sound
squirrel.samples() => squirrel.pos;

while(true){
    0.4 => squirrel.gain;
    0 => squirrel.pos;
    squirrel.samples()::samp => now;
}