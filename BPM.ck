// Controls the tempo of the piece
public class BPM {
    static dur quarterNote;
    static float BPM;

    fun void tempo(float beats) {
        beats => BPM;
        1::minute/beats => quarterNote;
    }
}
