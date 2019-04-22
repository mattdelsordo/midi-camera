// Setup MIDI input, set a port number
MidiIn min;

// MIDI Port
0 => int port;

// open the port, fail gracefully
if( !min.open(port))
{
    <<< "Error: MIDI port did not open on port: ", port >>>;
    me.exit();
}
// holder for received messages
MidiMsg msg;
me.dir() + "/gerb.ck" => string gerbPath; //paths for sporking
me.dir() + "/gnawing.ck" => string gnawPath;
me.dir() + "/wheelRun.ck" => string wheelPath;

// Store the paths and machine IDs in arrays for easier access
[gerbPath, gnawPath, wheelPath] @=> string paths[];
int IDs[paths.cap()];

//function that will assign music to received midi
fun void tunes(int trackNum, int running){  //tests with 3 - should be top 3 squares 
    // Don't do anything if the incoming track number is a higher
    // number than the actual amount of tracks we have
    if (trackNum >= paths.cap()) return; 
    
    if (running) {
        Machine.add(paths[trackNum]) => IDs[trackNum];
    } else {
        Machine.remove(IDs[trackNum]);
    }
    // if (msg2 == 1){
    //     Machine.add(gerbPath) => int one;
    //     if (running == 0){
    //         Machine.remove(one);
    //     }
    // }if (msg2 == 2){
    //     Machine.add(gnawPath) => int two;
    //     if (running == 0){
    //         Machine.remove(two);
    //     }
    // }if (msg2 == 3){
    //     Machine.add(wheelPath) => int three;
    //     if (running == 0){
    //         Machine.remove(three);
    //     }
    // }
}

while(true){
    //advance time when receiving midi messages
    min => now;
    //0 => int running; //initializes on/off val
    while(min.recv(msg)){
        <<< msg.data1, msg.data2, msg.data3 >>>;
        //if note on
        if(msg.data1 == 144){
            tunes(msg.data2, 1);
            2::second => now; //wait for 2 seconds
            // 1 => running;
            // //put data through function to assign sound/music
            // if (msg.data2 == 1){
            //     tunes(1, running);
            //     2::second => now; //wait for 2 seconds
            // }
            // if (msg.data2 == 2){
            //     tunes(2, running);
            //     2::second => now; //wait for 2 seconds
            // }
            // if (msg.data2 == 3){
            //     tunes(3, running);
            //     2::second => now; //wait for 2 seconds
            // }
        }if (msg.data1 == 128){
            tunes(msg.data2, 0);
            //determine if spork is running
            //remove shred
            // 0 => running;
            // if (msg.data2 == 1){
            //     tunes(1, running);
            // }
            // if (msg.data2 == 2){
            //     tunes(2, running);
            // }
            // if (msg.data2 == 3){
            //     tunes(3, running);
            // }
        }
    }
}