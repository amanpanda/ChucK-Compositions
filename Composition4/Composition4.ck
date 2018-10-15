// Author: Aman Panda
// Date: 6/6/16

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
if( !hi.openKeyboard( device ) ) me.exit();
<<< "keyboard '" + hi.name() + "' ready", "" >>>;

// Drum samples used (Free online samples)
SndBuf kick => Pan2 kickPan => dac;
SndBuf hihat => Pan2 hihatPan => dac;
SndBuf snare => Pan2 snarePan => dac;
SndBuf clap => Pan2 clapPan => dac;

// vg is verse guitar. Numbers represent order of melody
// Recorded on Native Instruments Guitar Rig
// I recorded myself playing the melody at ~10 BPM, then sped it up by ~1350% on audacity, which resulted with a cool effect (violin sounding)
SndBuf vg1 => Pan2 vg1Pan => NRev vg1Rev => dac;
SndBuf vg2 => Pan2 vg2Pan => NRev vg2Rev => dac;
SndBuf vg3 => Pan2 vg3Pan => NRev vg3Rev => dac;
SndBuf vg4 => Pan2 vg4Pan => NRev vg4Rev => dac;

// jv stands for jazzy vamp (on C sharp minor 7 chord)
// Recorded on Native Instruments Guitar Rig
SndBuf jv => Pan2 jvPan => NRev jvRev => dac;
// jornmanet stands for jazzy ornamentation
SndBuf jornament => Pan2 jornamentPan => NRev jornamentRev => dac;

// arp stands for arpeggio, one/two/etc. stands for order of chords.
// r/l stands for left/right ear
// Recorded on Native Instruments Guitar Rig
SndBuf arponer => Pan2 arponerPan => dac;
SndBuf arptwor => Pan2 arptworPan => dac;
SndBuf arpthreer => Pan2 arpthreerPan => dac;
SndBuf arpfourr => Pan2 arpfourrPan => dac;
SndBuf arponel => Pan2 arponelPan => dac;
SndBuf arptwol => Pan2 arptwolPan => dac;
SndBuf arpthreel => Pan2 arpthreelPan => dac;
SndBuf arpfourl => Pan2 arpfourlPan => dac;

// cm stands for chorus melody. Numbers stand for order.
// Once again, I played at 10 BPM and sped up the recordings resulting in this cool violin sounding effect
SndBuf cm1 => Pan2 cm1Pan => NRev cm1Rev => dac;
SndBuf cm2 => Pan2 cm2Pan => NRev cm2Rev => dac;
SndBuf cm3 => Pan2 cm3Pan => NRev cm3Rev => dac;
SndBuf cm4 => Pan2 cm4Pan => NRev cm4Rev => dac;
SndBuf cm5 => Pan2 cm5Pan => NRev cm5Rev => dac;

// Directories for sound files used.
me.dir() + "pandaaAudio/kick.wav" => kick.read;
me.dir() + "pandaaAudio/vg1.wav" => vg1.read;
me.dir() + "pandaaAudio/vg2.wav" => vg2.read;
me.dir() + "pandaaAudio/vg3.wav" => vg3.read;
me.dir() + "pandaaAudio/vg4.wav" => vg4.read;
me.dir() + "pandaaAudio/jv.wav" => jv.read;
me.dir() + "pandaaAudio/jornament.wav" => jornament.read;
me.dir() + "pandaaAudio/arponer.wav" => arponer.read;
me.dir() + "pandaaAudio/arptwor.wav" => arptwor.read;
me.dir() + "pandaaAudio/arpthreer.wav" => arpthreer.read;
me.dir() + "pandaaAudio/arpfourr.wav" => arpfourr.read;
me.dir() + "pandaaAudio/arponel.wav" => arponel.read;
me.dir() + "pandaaAudio/arptwol.wav" => arptwol.read;
me.dir() + "pandaaAudio/arpthreel.wav" => arpthreel.read;
me.dir() + "pandaaAudio/arpfourl.wav" => arpfourl.read;
me.dir() + "pandaaAudio/cm1.wav" => cm1.read;
me.dir() + "pandaaAudio/cm2.wav" => cm2.read;
me.dir() + "pandaaAudio/cm3.wav" => cm3.read;
me.dir() + "pandaaAudio/cm4.wav" => cm4.read;
me.dir() + "pandaaAudio/cm5.wav" => cm5.read;
me.dir() + "pandaaAudio/snare.wav" => snare.read;
me.dir() + "pandaaAudio/hihat.wav" => hihat.read;
me.dir() + "pandaaAudio/clap.wav" => clap.read;

//Initializations
0 => kick.gain;
0 => vg1.gain => vg2.gain => vg3.gain => vg4.gain => jv.gain => jornament.gain;
0 => arponer.gain => arptwor.gain => arpthreer.gain => arpfourr.gain => arponel.gain => arptwol.gain => arpthreel.gain => arpfourl.gain;
0 => cm1.gain => cm2.gain => cm3.gain => cm4.gain => cm5.gain;
0.2 => vg1Rev.mix => vg2Rev.mix => vg3Rev.mix => vg4Rev.mix;
0.1 => jvRev.mix => jornamentRev.mix;
0.1 => cm1Rev.mix => cm2Rev.mix => cm3Rev.mix => cm4Rev.mix => cm5Rev.mix;
-0.3 => vg1Pan.pan => vg2Pan.pan => vg3Pan.pan => vg4Pan.pan => cm1Pan.pan => cm2Pan.pan => cm3Pan.pan => cm4Pan.pan => cm5Pan.pan;
0.3 => arponelPan.pan => arptwolPan.pan => arpthreelPan.pan => arpfourlPan.pan;
-0.3 => arponerPan.pan => arptworPan.pan => arpthreerPan.pan => arpfourrPan.pan;
0 => clap.gain => hihat.gain => snare.gain;

// Sporking Shreds
spork ~ beat();
spork ~ controlledGuitar();
spork ~ bass();

// Keep running parent shred
while(true){
    1::second => now;
}

// Function that contains the drum beat
fun void beat(){
    // Initialization of first counter
    0 => int counterOne;
    // Metrenome like bass drum on every quarter note.
    while(counterOne<96){
        0.6 => kick.gain;
        0 => kick.pos;
        // Increment counter
        counterOne++;
        // Move time forward
        430::ms => now;
    }
    //Initialization of second counter
    0 => int counterTwo;
    // Half time feel kick and clap beat
    while(counterTwo<24){
        0.6 => kick.gain;
        0 => kick.pos;
        // Move time forward
        860::ms => now;
        0.4 => clap.gain;
        0 => clap.pos;
        // Move time forward
        860::ms => now;
        // Increment counter
        counterTwo++;
    }
    // Initialization of third counter
    0 => int counterThree => int beat;
    // Simple rock beat
    while(counterThree < 192){
        counterThree % 8 => beat;
        // Note that the hihat has a slight element of randomness to it with regards to panning.
        if(beat == 0){ Math.random2f(-0.3,-0.2) => hihatPan.pan; 0 => hihat.pos; 0.1 => hihat.gain; 0 => kick.pos; 0.6 => kick.gain;}
        if(beat == 1){ Math.random2f(-0.3,-0.2) => hihatPan.pan; 0 => hihat.pos; 0.1 => hihat.gain; }
        if(beat == 2){ Math.random2f(-0.3,-0.2) => hihatPan.pan; 0 => hihat.pos; 0.1 => hihat.gain; 0 => snare.pos; 0.2 => snare.gain; }
        if(beat == 3){ Math.random2f(-0.3,-0.2) => hihatPan.pan; 0 => hihat.pos; 0.1 => hihat.gain; }
        if(beat == 4){ Math.random2f(-0.3,-0.2) => hihatPan.pan; 0 => hihat.pos; 0.1 => hihat.gain; }
        if(beat == 5){ Math.random2f(-0.3,-0.2) => hihatPan.pan; 0 => hihat.pos; 0.1 => hihat.gain; 0 => kick.pos; 0.6 => kick.gain; }
        if(beat == 6){ Math.random2f(-0.3,-0.2) => hihatPan.pan; 0 => hihat.pos; 0.1 => hihat.gain; 0 => snare.pos; 0.2 => snare.gain; }
        if(beat == 7){ Math.random2f(-0.3,-0.2) => hihatPan.pan; 0 => hihat.pos; 0.1 => hihat.gain; }
        // Increment counter
        counterThree++;
        // Move time forward
        215::ms => now;
    }
}

// Interactive component. User controlled guitar samples.
// Contains jazzy chords for first section, and two different melodies for the next two sections
fun void controlledGuitar(){
    while(true){
        // Receive message from keyboard
        hi => now;
        while(hi.recv(msg)){
            if(msg.isButtonDown()){
                <<<msg.which>>>;
                // a
                if(msg.which == 4){
                    1.5 => vg1.gain; 0 => vg1.pos => vg2.gain => vg3.gain => vg4.gain;
                    1::ms => now;
                }
                // s
                if(msg.which == 22){
                    1.5 => vg2.gain; 0 => vg2.pos => vg1.gain => vg3.gain => vg4.gain;
                    1::ms => now;
                }
                // d
                if(msg.which == 7){
                    2.0 => vg3.gain; 0 => vg3.pos => vg2.gain => vg1.gain => vg4.gain;
                    1::ms => now;
                }
                // f
                if(msg.which == 9){
                    1.9 => vg4.gain; 0 => vg4.pos => vg2.gain => vg3.gain => vg1.gain;
                    1::ms => now;
                }
                
                // q is jazz vamp, w is jazzy ornamentation
                if(msg.which == 20 || msg.which == 26){
                    0 => jv.pos;
                    1.0 => jvPan.pan;
                    3.0 => jv.gain;
                    if(msg.which == 26){
                        0 => jornament.pos;
                        0 => jv.gain;
                        2.0 => jornament.gain;
                        -0.5=> jornamentPan.pan;
                    }
                    1::ms => now;
                }
                // z
                if(msg.which == 29){
                    0 => cm1.pos; 0.8 => cm1.gain;
                    1::ms => now;
                }
                // x
                if(msg.which == 27){
                    0 => cm2.pos; 0.8 => cm2.gain;
                    1::ms => now;
                }
                //c
                if(msg.which == 6){
                    0 => cm3.pos; 0.8 => cm3.gain;
                    1::ms => now;
                }
                //v
                if(msg.which == 25){
                    0 => cm4.pos; 0.8 => cm4.gain;
                    1::ms => now;
                }
                //b
                if(msg.which == 5){
                    0 => cm5.pos; 0.8 => cm5.gain;
                    1::ms => now;
                }
            }
        }
    }
}

fun void bass(){
    // Two oscillators make for a strong low frequency/bass driven feel.
    HevyMetl bass => Pan2 bassPan => dac;
    SinOsc fuller => Pan2 fullerPan => dac;
    // Intializations
    0 => fuller.gain;
    -0.2 => bassPan.pan;
    0.2 => fullerPan.pan;
    0 => int pattern => int counter => int beat => int measure => int i => int chordTrigger => int secondEnding;
    // Arrays containing notes for the 3 different sections of the song
    [49,49,44,47,49,49,54,52] @=> int jazzBass[];
    [37,49,42,44,47,49,28,54,52,51,52,51,47,35,51,35,51,52,33,49,33,49,33,49] @=> int buildUp[];
    [33,33,33,33,40,40,40,40,40,40,35,35,35,35,37,37,37,37,37,37,33,33,33,33,40,40,40,40,40,40,35,35,35,35,35,35,35,35] @=> int chorus[];
    
    // Run for 72 measures (length of the song)
    while(measure<72){
        // Divide into beats
        counter % 16 => beat;
        
        // First section of the song: Has a sort of jazzy feel to it
        if(measure<24){
            // Two measure pattern
            if(pattern == 0){
                if(beat == 0) { Std.mtof(jazzBass[i])/2 => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 1) { 0 => bass.noteOff; }
                if(beat == 6) { Std.mtof(jazzBass[i])/2 => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 7) { 0 => bass.noteOff; }
                if(beat == 8) { Std.mtof(jazzBass[i])/2 => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 9) { 0 => bass.noteOff; }
                if(beat == 14) { Std.mtof(jazzBass[i])/2 => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++;}
                if(beat == 15) { 0 => bass.noteOff; 1 => pattern; measure++; }
            }
            else{
                if(beat == 0) { Std.mtof(jazzBass[i])/2 => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 1) { 0 => bass.noteOff; }
                if(beat == 6) { Std.mtof(jazzBass[i])/2 => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 7) { 0 => bass.noteOff; }
                if(beat == 8) { Std.mtof(jazzBass[i])/2 => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 9) { 0 => bass.noteOff; }
                if(beat == 12) { Std.mtof(jazzBass[i])/2 => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 13) { 0 => i => bass.noteOff; }
                if(beat == 15) { 0 => pattern; measure++; }
            }
        }
        // Second section of the song: Has an EDM sort of hook (at least that's what I was attempting to do!)
        else if(measure < 48){
            // Trigger the animated/arpeggiated chord effect after 8 measures
            if(measure > 31) { 1 => chordTrigger; }
            // Four measure pattern
            if(pattern == 0){
                if(beat == 0) { Std.mtof(buildUp[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 0 && chordTrigger == 1) { 0 => arponer.pos => arponel.pos; 0.7 => arponer.gain => arponel.gain; }
                if(beat == 1) { 0 => bass.noteOff; }
                if(beat == 4) { Std.mtof(buildUp[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 5) { 0 => bass.noteOff; }
                if(beat == 8) { Std.mtof(buildUp[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 9) { Std.mtof(buildUp[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 10) { Std.mtof(buildUp[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 11) { Std.mtof(buildUp[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 12) { 0 => bass.noteOff; }
                if(beat == 15) { 1 => pattern; measure++; }
            }
            else if(pattern == 1){
                if(beat == 0) { Std.mtof(buildUp[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 0 && chordTrigger == 1) { 0 => arptwor.pos => arptwol.pos; 0.7 => arptwor.gain => arptwol.gain; }
                if(beat == 1) { 0 => bass.noteOff; }
                if(beat == 2) { Std.mtof(buildUp[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 3) { 0 => bass.noteOff; }
                if(beat == 4) { Std.mtof(buildUp[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 5) { 0 => bass.noteOff; }
                if(beat == 6) { Std.mtof(buildUp[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 7) { 0 => bass.noteOff; }
                if(beat == 8) { Std.mtof(buildUp[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 9) { 0 => bass.noteOff; }
                if(beat == 10) { Std.mtof(buildUp[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 11) { 0 => bass.noteOff; }
                if(beat == 12) { Std.mtof(buildUp[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 13) { 0 => bass.noteOff; }
                if(beat == 15) { 2 => pattern; measure++; }
            }
            else if(pattern == 2){
                if(beat == 0) { Std.mtof(buildUp[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 0 && chordTrigger == 1) { 0 => arpthreer.pos => arpthreel.pos; 0.7 => arpthreer.gain => arpthreel.gain; }
                if(beat == 1) { 0 => bass.noteOff; }
                if(beat == 4) { Std.mtof(buildUp[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 5) { 0 => bass.noteOff; }
                if(beat == 6) { Std.mtof(buildUp[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 7) { 0 => bass.noteOff; }
                if(beat == 8) { Std.mtof(buildUp[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 9) { 0 => bass.noteOff; }
                if(beat == 10) { Std.mtof(buildUp[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 11) { 0 => bass.noteOff; }
                if(beat == 15) { 3 => pattern; measure++; }
            }
            else{
                if(beat == 0) { Std.mtof(buildUp[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 0 && chordTrigger == 1) { 0 => arpfourr.pos => arpfourl.pos; 0.7 => arpfourr.gain => arpfourl.gain; }
                if(beat == 1) { 0 => bass.noteOff; }
                if(beat == 4) { Std.mtof(buildUp[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 5) { 0 => bass.noteOff; }
                if(beat == 8) { Std.mtof(buildUp[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 9) { 0 => bass.noteOff; }
                if(beat == 10) { Std.mtof(buildUp[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 11) { 0 => bass.noteOff; }
                if(beat == 12) { Std.mtof(buildUp[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 13) { 0 => bass.noteOff; }
                if(beat == 14) { Std.mtof(buildUp[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 15) { 0 => bass.noteOff; 0 => pattern => i; measure++; }
            }
        }
        // Third section of the song: Has a simple rock groove with a guitar driven melody. Bass simply plays the root notes of the chord progression here
        else if(measure < 72){
            
            // Eight Measure pattern
            if(pattern == 0){
                0 => arpfourr.gain => arpfourl.gain;
                if(beat == 0) { Std.mtof(chorus[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 1) { 0 => bass.noteOff; }
                if(beat == 4) { Std.mtof(chorus[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 5) { 0 => bass.noteOff; }
                if(beat == 8) { Std.mtof(chorus[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 9) { 0 => bass.noteOff; }
                if(beat == 10) { Std.mtof(chorus[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 11) { 0 => bass.noteOff; }
                if(beat == 15) { 1 => pattern; measure++; }
            }
            else if(pattern == 1){
                if(beat == 0) { Std.mtof(chorus[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 1) { 0 => bass.noteOff; }
                if(beat == 4) { Std.mtof(chorus[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 5) { 0 => bass.noteOff; }
                if(beat == 8) { Std.mtof(chorus[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 9) { 0 => bass.noteOff; }
                if(beat == 10) { Std.mtof(chorus[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 11) { 0 => bass.noteOff; }
                if(beat == 12) { Std.mtof(chorus[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 13) { 0 => bass.noteOff; }
                if(beat == 14) { Std.mtof(chorus[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 15) { 0 => bass.noteOff; 2 => pattern; measure++; }
            }
            else if(pattern == 2){
                if(beat == 0) { Std.mtof(chorus[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 1) { 0 => bass.noteOff; }
                if(beat == 4) { Std.mtof(chorus[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 5) { 0 => bass.noteOff; }
                if(beat == 8) { Std.mtof(chorus[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 9) { 0 => bass.noteOff; }
                if(beat == 10) { Std.mtof(chorus[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 11) { 0 => bass.noteOff; }
                if(beat == 15) { 3 => pattern; measure++; }
            }
            else if(pattern == 3){
                if(beat == 0) { Std.mtof(chorus[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 1) { 0 => bass.noteOff; }
                if(beat == 4) { Std.mtof(chorus[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 5) { 0 => bass.noteOff; }
                if(beat == 8) { Std.mtof(chorus[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 9) { 0 => bass.noteOff; }
                if(beat == 10) { Std.mtof(chorus[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 11) { 0 => bass.noteOff; }
                if(beat == 12) { Std.mtof(chorus[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 13) { 0 => bass.noteOff; }
                if(beat == 14) { Std.mtof(chorus[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 15) { 0 => bass.noteOff; 4 => pattern; measure++; }
            }
            else if(pattern == 4){
                if(beat == 0) { Std.mtof(chorus[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 1) { 0 => bass.noteOff; }
                if(beat == 4) { Std.mtof(chorus[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 5) { 0 => bass.noteOff; }
                if(beat == 8) { Std.mtof(chorus[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 9) { 0 => bass.noteOff; }
                if(beat == 10) { Std.mtof(chorus[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 11) { 0 => bass.noteOff; }
                if(beat == 15) { 5 => pattern; measure++; }
            }
            else if(pattern == 5){
                if(beat == 0) { Std.mtof(chorus[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 1) { 0 => bass.noteOff; }
                if(beat == 4) { Std.mtof(chorus[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 5) { 0 => bass.noteOff; }
                if(beat == 8) { Std.mtof(chorus[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 9) { 0 => bass.noteOff; }
                if(beat == 10) { Std.mtof(chorus[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 11) { 0 => bass.noteOff; }
                if(beat == 12) { Std.mtof(chorus[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 13) { 0 => bass.noteOff; }
                if(beat == 14) { Std.mtof(chorus[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 15) { 0 => bass.noteOff; 6 => pattern; measure++; }
            }
            else if(pattern == 6){
                if(beat == 0) { Std.mtof(chorus[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 1) { 0 => bass.noteOff; }
                if(beat == 4) { Std.mtof(chorus[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 5) { 0 => bass.noteOff; }
                if(beat == 8) { Std.mtof(chorus[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 9) { 0 => bass.noteOff; }
                if(beat == 10) { Std.mtof(chorus[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 11) { 0 => bass.noteOff; }
                if(beat == 15) { 7 => pattern; measure++; }
            }
            else if(pattern == 7){
                if(beat == 0) { Std.mtof(chorus[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 1) { 0 => bass.noteOff; }
                if(beat == 4) { Std.mtof(chorus[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 5) { 0 => bass.noteOff; }
                if(beat == 8) { Std.mtof(chorus[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 9) { 0 => bass.noteOff; }
                if(beat == 10) { Std.mtof(chorus[i]) => bass.freq => fuller.freq; 0.1 => fuller.gain; 0.5 => bass.noteOn; i++; }
                if(beat == 11) { 0 => bass.noteOff; }
                if(beat == 15) { 0 => pattern => i; measure++; }
            }
        }
        // Increment counter
        counter++;
        // Move time forward
        107.5::ms => now;
    }
}

