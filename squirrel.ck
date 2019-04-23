SndBuf squirrel => dac;
me.dir() + "/audio/empnewgroove.wav" => squirrel.read;
// set their pointers to end, to make no sound
squirrel.samples() => squirrel.pos;
150 => float BPM; //defined BPM
(60/BPM)::second => dur quarter; //duration of a "beat"

while(true){
    0.4 => squirrel.gain;
    0 => squirrel.pos;
    5::second => now;
}