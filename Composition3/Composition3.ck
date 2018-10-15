// Composer: Aman Panda

// Used to read from keyboard
Hid hi;
HidMsg msg;

// Take in samples
adc => blackhole;

// which keyboard
0 => int device;
// get from command line
if( me.args() ) me.arg(0) => Std.atoi => device;

// open keyboard (get device number from command line)
//if( !hi.openKeyboard( device ) ) me.exit();
//<<< "keyboard '" + hi.name() + "' ready", "" >>>;

// Send to buffer samples used
SndBuf kick => Pan2 kickPan => dac;
SndBuf hihat => NRev hihatRev => Pan2 hihatPan => dac;
SndBuf openHihat => NRev openHihatRev => Pan2 openHihatPan => dac;
SndBuf crash => PRCRev crashRev => Pan2 crashPan => dac;
SndBuf snare => JCRev snareRev => Pan2 snarePan => dac;
// Guitar samples recorded with Native Instruments Guitar Rig
SndBuf fSharpMinor => Pan2 fSharpMinorPan => dac;
SndBuf bMinor => Pan2 bMinorPan => dac;
SndBuf dFlatMinor => Pan2 dFlatMinorPan => dac;
SndBuf dMajor => Pan2 dMajorPan => dac;
SndBuf eMajor => Pan2 eMajorPan => dac;
// Sound effects for crescendo with rain effect
SndBuf explosion => Pan2 explosionPan => dac;
// Oscillators used
TriOsc bassOsc => dac;
TriOsc improv => Pan2 improvPan => dac;

SndBuf s1 => Pan2 s1pan => dac;
SndBuf s2 => Pan2 s2pan => dac;
SndBuf s3 => Pan2 s3pan => dac;
SndBuf s4 => Pan2 s4pan => dac;
SndBuf s5 => Pan2 s5pan => dac;
SndBuf s6 => Pan2 s6pan => dac;
SndBuf s7 => Pan2 s7pan => dac;
SndBuf s8 => Pan2 s8pan => dac;
SndBuf s9 => Pan2 s9pan => dac;
SndBuf s10 => Pan2 s10pan => dac;
SndBuf s11 => Pan2 s11pan => dac;
SndBuf s12 => Pan2 s12pan => dac;
SndBuf s13 => Pan2 s13pan => dac;
SndBuf s14 => Pan2 s14pan => dac;
SndBuf s15 => Pan2 s15pan => dac;

// Memory location of samples
me.dir() + "pandaaAudio/fSharpMinor.wav" => fSharpMinor.read;
me.dir() + "pandaaAudio/bMinor.wav" => bMinor.read;
me.dir() + "pandaaAudio/DFlatMinor.wav" => dFlatMinor.read;
me.dir() + "pandaaAudio/dMajor.wav" => dMajor.read;
me.dir() + "pandaaAudio/eMajor.wav" => eMajor.read;

me.dir() + "pandaaAudio/kick.wav" => kick.read;
me.dir() + "pandaaAudio/hihat.wav" => hihat.read;
me.dir() + "pandaaAudio/openHihat.wav" => openHihat.read;
me.dir() + "pandaaAudio/crash.wav" => crash.read;
me.dir() + "pandaaAudio/snare.wav" => snare.read;

me.dir() + "pandaaAudio/explosion.wav" => explosion.read;

me.dir() + "pandaaAudio/1.wav" => s1.read;
me.dir() + "pandaaAudio/2.wav" => s2.read;
me.dir() + "pandaaAudio/3.wav" => s3.read;
me.dir() + "pandaaAudio/4.wav" => s4.read;
me.dir() + "pandaaAudio/5.wav" => s5.read;
me.dir() + "pandaaAudio/6.wav" => s6.read;
me.dir() + "pandaaAudio/7.wav" => s7.read;
me.dir() + "pandaaAudio/8.wav" => s8.read;
me.dir() + "pandaaAudio/9.wav" => s9.read;
me.dir() + "pandaaAudio/10.wav" => s10.read;
me.dir() + "pandaaAudio/11.wav" => s11.read;
me.dir() + "pandaaAudio/12.wav" => s12.read;
me.dir() + "pandaaAudio/13.wav" => s13.read;
me.dir() + "pandaaAudio/14.wav" => s14.read;
me.dir() + "pandaaAudio/15.wav" => s15.read;


// Initializations
0 => kick.gain => hihat.gain => openHihat.gain => crash.gain => snare.gain;
0 => bassOsc.gain => improv.gain;
0 => explosion.gain;
0 => fSharpMinor.gain => bMinor.gain => dFlatMinor.gain => dMajor.gain => eMajor.gain;
0 => s1.gain => s2.gain => s3.gain => s4.gain => s5.gain => s6.gain => s7.gain => s8.gain => s9.gain => s10.gain => s11.gain => s12.gain => s13.gain => s14.gain => s15.gain;
0.5 => s1pan.pan => s2pan.pan => s3pan.pan => s4pan.pan => s5pan.pan => s6pan.pan=> s7pan.pan=> s8pan.pan => s9pan.pan => s10pan.pan=> s11pan.pan => s12pan.pan => s13pan.pan => s14pan.pan=> s15pan.pan;
-0.5 => fSharpMinorPan.pan => bMinorPan.pan => dFlatMinorPan.pan => dMajorPan.pan => eMajorPan.pan;
-0.3 => hihatPan.pan;
0.3 => snarePan.pan;
0.8 => crashPan.pan;
0 => openHihatRev.mix;
0.00001 => hihatRev.mix;
0.00003 => crashRev.mix;
0.001 => snareRev.mix;

// Spork shreds. 

//spork ~ drumSet();
spork ~ bass();
spork ~ drumMachine();
spork ~ guitar();
spork ~ solo();
//spork ~ soundEffect();

// Parent thread will go on forever.
while(true){
    1::second => now;
}

// Drumset used for creating the drum machine groove. Not actually used in performance
fun void drumSet(){
    while(true){
        hi => now;
        while(hi.recv(msg)){
            if(msg.isButtonDown()){
                <<<msg.which>>>;
                0.1::ms=>now;
                
                // [ p
                if(msg.which == 47 || msg.which == 19){
                    0 => kick.pos;
                    0.7 => kick.gain;
                    0.1::ms => now;
                }
                // ]
                if(msg.which == 48){
                    0 => snare.pos;
                    0.6 => snare.gain;
                    0.1::ms => now;
                }
                //\
                if(msg.which == 49){
                    0 => hihat.pos;
                    0.5 => hihat.gain;
                    0.1::ms => now; 
                }
                // - +
                if(msg.which == 45 || msg.which == 46){
                    0 => crash.pos;
                    0.5 => crash.gain;
                    0.1::ms => now;
                }
            }
        }
    }
}

// Bass part
fun void bass(){
    // Counters necessary for keeping track of positions in song and in arrays
    0 => int counter => int beat => int measure => int i => int j => int k;
    
    // 6 different bass lines in total
    [42,54,47,49,52,49] @=> int bassLine1[];
    [47,49,54,57,47,49,56,56] @=> int bassLine2[];
    [40,42,42,42,52,54,57,66,64,62,61] @=> int bassLine3[];
    [47,49,54,57,47,52,47,52,40,42,47,52] @=> int bassLine4[];
    [42,47,52,40] @=> int bassLine5[];
    [47,47,40,47,47,47,49,57,66,59,57,56] @=> int bassLine6[];
    
    // Length of song = 448 eighth notes
    while(counter < 448){
        counter % 16 => beat;
        
        // Over the "A" section
        if((measure < 16) || (measure > 23 && measure < 48)){
            // Over the F sharp minor chord
            if(measure % 8 < 4){
                if(beat == 0){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine1[i]) => bassOsc.freq;
                    i++;
                } 
                if(beat == 3){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine1[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 4){
                    0 => bassOsc.gain;
                }
                if(beat == 5){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine1[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 6){
                    0 => bassOsc.gain;
                }
                if(beat == 7){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine1[i]) => bassOsc.freq;
                    measure++;
                    i++;
                }
                if(beat == 8){
                    //0 => bassOsc.gain;
                }
                if(beat == 14){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine1[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 15){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine1[i]) => bassOsc.freq;
                    measure++;
                    0 => i;
                }
            }
            // Over the Bminor and D flat minor chords
            else if (measure % 8 < 6){
                if(beat == 0){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine2[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 1){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine2[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 3){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine2[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 4){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine2[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 6){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine2[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 7){
                    measure++;
                }
                if(beat == 8){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine2[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 11){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine2[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 14){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine2[i]) => bassOsc.freq;
                    0 => i;
                }
                if(beat == 15){
                    measure++;
                }
            }
            // Over the return to f sharp minor chord
            else if (measure % 8 > 5){
                if(beat == 0){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine3[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 1){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine3[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 3){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine3[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 7){
                    measure++;
                }
                if(beat == 6){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine3[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 9){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine3[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 10){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine3[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 11){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine3[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 12){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine3[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 13){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine3[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 14){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine3[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 15){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine3[i]) => bassOsc.freq;
                    measure++;
                    0 => i;
                }
            }
        }
        // The "B" section of the song
        else{
            // Over the D major and E major chords
            if(measure % 8 < 2 || measure % 8 < 6){
                if(beat == 0){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine4[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 1){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine4[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 2){
                    
                }
                if(beat == 3){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine4[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 4){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine4[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 5){
                    
                }
                if(beat == 6){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine4[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 7){
                    measure++;
                }
                if(beat == 8){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine4[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 9){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine4[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 10){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine4[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 11){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine4[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 12){
                    
                }
                if(beat == 13){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine4[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 14){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine4[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 15){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine4[i]) => bassOsc.freq;
                    0 => i;
                    measure++;
                }
            }
            // Over the F Sharp minor chord
            else if(measure % 8 < 4){
                if(beat == 0 || beat == 8){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine5[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 1 || beat == 9){
                    0 => bassOsc.gain;
                }
                if(beat == 2 || beat == 10){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine5[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 3 || beat == 11){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine5[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 4 || beat == 12){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine5[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 5 || beat == 13){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine5[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 6 || beat == 14){
                    
                }
                if(beat == 7 || beat == 15){
                    measure++;
                    0 => i;
                }
                
            }
            // Over the B minor chord
            else if(measure % 8 > 5){
                if(beat == 0){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine6[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 1){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine6[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 2){
                    
                }
                if(beat == 3){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine6[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 4){
                    
                }
                if(beat == 5){
                    
                }
                if(beat == 6){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine6[i]) => bassOsc.freq;
                    i++;
                }
                if(beat ==  7){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine6[i]) => bassOsc.freq;
                    i++;
                    measure++;
                }
                if(beat == 8){
                    
                }
                if(beat == 9){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine6[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 10){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine6[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 11){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine6[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 12){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine6[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 13){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine6[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 14){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine6[i]) => bassOsc.freq;
                    i++;
                }
                if(beat == 15){
                    0.13 => bassOsc.gain;
                    Std.mtof(bassLine6[i]) => bassOsc.freq;
                    0 => i;
                    measure++;
                }
            }
        }
        // Increment counter
        counter++;
        // Move time forward
        200::ms => now;
    }
    // End of song means bass should shut off
    0 => bassOsc.gain;
}

// Drum goove
fun void drumMachine(){
    // Counters to keep track of where we are in the song
    0 => int counter => int beat;
    
    while(counter < 448){
        counter % 16 => beat;
        
        if(beat == 0){
            
            0.2 => crash.gain;
            0 => crash.pos;
            
            0.2 => kick.gain;
            0 => kick.pos;
        }
        if(beat == 1){
            
            
        }
        if(beat == 2){
            0.2 => hihat.gain;
            0 => hihat.pos;
        }
        if(beat == 3){
            0.2 => kick.gain;
            0 => kick.pos;
            
        }
        if(beat == 4){
            0.2 => snare.gain;
            0 => snare.pos;
            
            0.2 => openHihat.gain;
            0 => openHihat.pos;
            
        }
        if(beat == 5){
            0.2 => kick.gain;
            0 => kick.pos;
            
            0.2 => hihat.gain;
            0 => hihat.pos;
            
        }
        if(beat == 6){
            0.2 => hihat.gain;
            0 => hihat.pos;
        }
        if(beat == 7){
            0.2 => kick.gain;
            0 => kick.pos;
            
        }
        if(beat == 8){
            0.2 => hihat.gain;
            0 => hihat.pos;
        }
        if(beat == 9){
            
        }
        if(beat == 10){
            0.2 => hihat.gain;
            0 => hihat.pos;
        }
        if(beat == 11){
            
        }
        if(beat == 12){
            0.2 => snare.gain;
            0 => snare.pos;
        }
        if(beat == 13){
            
        }
        if(beat == 14){
            0.2 => hihat.gain;
            0 => hihat.pos;
        }
        if(beat == 15){
            0.2 => hihat.gain;
            0 => hihat.pos;
            
            0.2 => kick.gain;
            0 => kick.pos;
        }
        counter++;
        200::ms => now;
    }
}

// Guitar strumming - used to fill up space
fun void guitar(){
    0 => int measure;
    
    while(measure<56){
        if((measure < 16) || (measure > 23 && measure < 48)){
            if(measure % 8 == 0 || measure % 8 == 6){
                0.3 => fSharpMinor.gain;
                0 => fSharpMinor.pos;
            }
            else if(measure % 8 == 4){
                0.3 => bMinor.gain;
                0 => bMinor.pos;
            }
            else if(measure % 8 == 5){
                0.3 => dFlatMinor.gain;
                0 => dFlatMinor.pos;
            }
        }
        else{
            if(measure % 8 == 0 || measure % 8 == 4){
                0 => fSharpMinor.gain;
                0.3 => dMajor.gain;
                0 => dMajor.pos;
            }
            else if(measure % 8 == 1 || measure % 8 == 5){
                0.3 => eMajor.gain;
                0 => eMajor.pos;
            }
            else if(measure % 8 == 2){
                0.4 => fSharpMinor.gain;
                0 => fSharpMinor.pos;
            }
            else if(measure % 8 == 6 || measure % 8 == 7){
                0.4 => bMinor.gain;
                0 => bMinor.pos;
            }
        }
        measure++;
        1600::ms => now;
        if(measure == 56){
            0.4 => fSharpMinor.gain;
            0 => fSharpMinor.pos;
            5::second => now;
        }
    }
}

// Thunder effect used in crescendo
fun void soundEffect(){
    while(true){
        if(adc.last() > 0.7){
            0.7 => explosion.gain;
            0 => explosion.pos;
            1::second => now;
        }
        1.0::samp => now;
    }
}

// Lets one improvise over the minor pentatonic scale
// Also controls the rain effect
fun void solo(){  
    while(true){
        hi => now;
        // Get message
        while(hi.recv(msg)){
            if(msg.isButtonDown()){
                <<<msg.which>>>;

                // a 
                if(msg.which == 4){
                    0 => s2.gain => s3.gain => s4.gain => s5.gain => s6.gain => s7.gain => s8.gain => s9.gain => s10.gain => s11.gain => s12.gain => s13.gain => s14.gain => s15.gain;
                    0 => s1.pos;
                    0.3 => s1.gain;
                }
                // s
                if(msg.which == 22){
                    0 => s1.gain => s3.gain => s4.gain => s5.gain => s6.gain => s7.gain => s8.gain => s9.gain => s10.gain => s11.gain => s12.gain => s13.gain => s14.gain => s15.gain;
                    0 => s2.pos;
                    0.3 => s2.gain;
                }
                // d
                if(msg.which == 7){
                    0 => s2.gain => s1.gain => s4.gain => s5.gain => s6.gain => s7.gain => s8.gain => s9.gain => s10.gain => s11.gain => s12.gain => s13.gain => s14.gain => s15.gain;
                    0 => s3.pos;
                    0.3 => s3.gain;
                }
                // ...
                if(msg.which == 9){
                    0 => s2.gain => s3.gain => s1.gain => s5.gain => s6.gain => s7.gain => s8.gain => s9.gain => s10.gain => s11.gain => s12.gain => s13.gain => s14.gain => s15.gain;
                    0 => s4.pos;
                    0.3 => s4.gain;
                }
                if(msg.which == 10){
                    0 => s2.gain => s3.gain => s4.gain => s1.gain => s6.gain => s7.gain => s8.gain => s9.gain => s10.gain => s11.gain => s12.gain => s13.gain => s14.gain => s15.gain;
                    0 => s5.pos;
                    0.4 => s5.gain;
                }
                if(msg.which == 11){
                    0 => s2.gain => s3.gain => s4.gain => s5.gain => s1.gain => s7.gain => s8.gain => s9.gain => s10.gain => s11.gain => s12.gain => s13.gain => s14.gain => s15.gain;
                    0 => s6.pos;
                    0.3 => s6.gain;
                }
                if(msg.which == 13){
                    0 => s2.gain => s3.gain => s4.gain => s5.gain => s6.gain => s1.gain => s8.gain => s9.gain => s10.gain => s11.gain => s12.gain => s13.gain => s14.gain => s15.gain;
                    0 => s7.pos;
                    0.3 => s7.gain;
                }
                if(msg.which == 14){
                    0 => s2.gain => s3.gain => s4.gain => s5.gain => s6.gain => s7.gain => s1.gain => s9.gain => s10.gain => s11.gain => s12.gain => s13.gain => s14.gain => s15.gain;
                    0 => s8.pos;
                    0.3 => s8.gain;
                }
                // l
                if(msg.which == 15){
                    0 => s2.gain => s3.gain => s4.gain => s5.gain => s6.gain => s7.gain => s8.gain => s1.gain => s10.gain => s11.gain => s12.gain => s13.gain => s14.gain => s15.gain;
                    0 => s9.pos;
                    0.3 => s9.gain;
                }
                // ;
                if(msg.which == 51){
                    0 => s2.gain => s3.gain => s4.gain => s5.gain => s6.gain => s7.gain => s8.gain => s9.gain => s1.gain => s11.gain => s12.gain => s13.gain => s14.gain => s15.gain;
                    0 => s10.pos;
                    0.3 => s10.gain;
                }
                // ' 
                if(msg.which == 52){
                    0 => s2.gain => s3.gain => s4.gain => s5.gain => s6.gain => s7.gain => s8.gain => s9.gain => s10.gain => s1.gain => s12.gain => s13.gain => s14.gain => s15.gain;
                    0 => s11.pos;
                    0.3 => s11.gain;
                }
                // Enter key
                if(msg.which == 40){
                    0 => s2.gain => s3.gain => s4.gain => s5.gain => s6.gain => s7.gain => s8.gain => s9.gain => s10.gain => s11.gain => s1.gain => s13.gain => s14.gain => s15.gain;
                    0 => s12.pos;
                    0.3 => s12.gain;
                }
                
                // r
                if(msg.which == 54){
                    0 => s2.gain => s3.gain => s4.gain => s5.gain => s6.gain => s7.gain => s8.gain => s9.gain => s10.gain => s11.gain => s12.gain => s1.gain => s14.gain => s15.gain;
                    0 => s13.pos;
                    0.3 => s13.gain;
                }
                if(msg.which == 55){
                    0 => s2.gain => s3.gain => s4.gain => s5.gain => s6.gain => s7.gain => s8.gain => s9.gain => s10.gain => s11.gain => s12.gain => s13.gain => s1.gain => s15.gain;
                    0 => s14.pos;
                    0.3 => s14.gain;
                }
                if(msg.which == 56){
                    0 => s2.gain => s3.gain => s4.gain => s5.gain => s6.gain => s7.gain => s8.gain => s9.gain => s10.gain => s11.gain => s12.gain => s13.gain => s14.gain => s1.gain;
                    0 => s15.pos;
                    0.3 => s15.gain;
                }
            }
        }
    }
}

