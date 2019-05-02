// Rudimentary MIDI output for testing the python script

0 => int DEBUG;
if (me.arg(0) == "debug") 1 => DEBUG;

MidiIn min;

0 => int port;

if (!min.open(port)) {
    <<< "Error: Could not open MIDI port ", port >>>;
    me.exit();
}

MidiMsg msg;
Rhodey piano => dac;
while (true) {
    min => now; // advance time when midi message is recieved

    while(min.recv(msg)) {
        if (DEBUG) <<< "Got", msg.data1, msg.data2, msg.data3 >>>;

        if (msg.data1 == 144) { // Channel 1 note On
            Std.mtof(msg.data2) => piano.freq;
            msg.data3 / 127.0 => piano.gain;
            1 => piano.noteOn;
        } else {
            1 => piano.noteOff;
        }
    }
}