// Triggers x amount of midi signals for sound checking
MidiOut mout;
0 => int port;
mout.open(port);

MidiMsg msg;

0.25::second => now; // wait because the other script has to kick in
for(0 => int i; i < 256; i++) {
    144 => msg.data1;
    i => msg.data2;
    mout.send(msg);
}