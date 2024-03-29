/*
    "Beats by Hammy"
    Fayth Kim && Matt DelSordo
*/

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
me.dir() + "/tracks" => string trackDir;
trackDir + "/gerb.ck" => string gerbPath; //paths for sporking
trackDir + "/gnawing.ck" => string gnawPath;
trackDir + "/wheelRun.ck" => string wheelPath;
trackDir + "/hamtaro.ck" => string hamtaroPath;
trackDir + "/dance.ck" => string dancePath;
trackDir + "/snare1.ck" => string snare1Path;
trackDir + "/kick1.ck" => string kick1Path;
trackDir + "/hihat1.ck" => string hihat1Path;
trackDir + "/squirrel.ck" => string squirrelPath;
trackDir + "/clap.ck" => string clapPath;
trackDir + "/eating.ck" => string eatPath;
trackDir + "/drinkingWater.ck" => string waterPath;
trackDir + "/burrow.ck" => string burrowPath;
trackDir + "/cageBars.ck" => string cagePath;
trackDir + "/bass.ck" => string bassPath;
trackDir + "/wasabi.ck" => string wasabiPath;

// Store the paths and machine IDs in arrays for easier access
[gerbPath, gnawPath, wheelPath, hamtaroPath, dancePath, snare1Path, kick1Path, hihat1Path, squirrelPath, wasabiPath, clapPath, eatPath, waterPath, burrowPath, cagePath, bassPath] @=> string paths[];
int IDs[paths.cap()];
int chuckQueue[paths.cap()];

// Listen for MIDI input, add recieved messages to queue
fun void listen() {
    while(true){
        //advance time when receiving midi messages
        min => now;
        while(min.recv(msg)){
            // <<< msg.data1, msg.data2, msg.data3 >>>;
            if (msg.data2 >= paths.cap()){ continue; }
            //if note on
            if(msg.data1 == 144){
                true => chuckQueue[msg.data2];
            }if (msg.data1 == 128){
                false => chuckQueue[msg.data2];
            }
        }
    }
}

// TODO: make a tempo controller somewhere else
BPM tempo;
tempo.tempo(136);

// Only chuck new shreds at a given interval
fun void chuck() {
    while(true){
        for (0 => int i; i < chuckQueue.cap(); i++) {
            // chuck if shred is in the queue and not chucked
            if (chuckQueue[i] && IDs[i] == 0) {
                Machine.add(paths[i]) => IDs[i];
            }
            // unchuck if shred is not in the queue and is chucked
            else if (!chuckQueue[i] && IDs[i] > 0) {
                Machine.remove(IDs[i]);
                0 => IDs[i];
            }
        }
        
        // wait
        tempo.quarterNote => now;
    }
}

// Start listener and shred chucking process
spork ~ listen();
spork ~ chuck();
while(true) {1::minute => now;} // infinite loop of doom
