// Aman Panda

// Send to dac all the sounds we will use
SndBuf click => Pan2 clickPan => dac;
SndBuf closedHat => Pan2 closedHatPan => dac;
SndBuf kick => Pan2 kickPan => NRev kickRev => dac;
SndBuf kick2 => Pan2 kick2Pan => NRev kick2Rev => dac;
SndBuf openHat => Pan2 openHatPan => NRev openHatRev => dac;
SndBuf shaker => Pan2 shakerPan => dac;
SndBuf snare => Pan2 snarePan => NRev snareRev => dac;

// Directories of files
me.dir() + "audio/click.aiff" => click.read;
me.dir() + "audio/closedHat.aif" => closedHat.read;
me.dir() + "audio/kick.aif" => kick.read;
me.dir() + "audio/kick.aif" => kick2.read;
me.dir() + "audio/openHat.aif" => openHat.read;
me.dir() + "audio/shaker.aif" => shaker.read;
me.dir() + "audio/snare.aif" => snare.read;

// Initial gain set at 0
0 => click.gain => closedHat.gain => kick.gain => kick2.gain 
  => openHat.gain => shaker.gain => snare.gain;
  
// Duration of eighth note
0.2::second => dur eighth;

// Initialize reverb
0.01 => kickRev.mix => kick2Rev.mix => openHatRev.mix => snareRev.mix;

// function to play a certain buffer with a pan, specifying gain, rate and pan
fun void play(SndBuf inst, Pan2 panObj, float gain, float rate, float pan) {
    0 => inst.pos;
    gain => inst.gain;
    rate => inst.rate;
    pan => panObj.pan;
    0.1::ms => now;
}

// First four measures of the song
fun void firstFour() {
    for (0 => int counter; counter < 32; counter++) {
        counter % 16 => int beat;
        
        if (beat == 0 || beat == 3 || beat == 5 
            || beat == 9 || beat == 13) {
            play(kick,kickPan,0.6,1.0,0.0);
        } 
        if (beat == 2 || beat == 6 || beat == 10 || beat == 14) {
            Math.random2f(0.6,0.9) => float panSnare;
            play(snare,snarePan,0.6,1.0,panSnare);
        }
        if (beat == 4 || beat == 12) {
            Math.random2f(-0.9,0.5) => float panClosedHat;
            Math.random2f(0.4,0.8) => float closedHatGain;
            play(closedHat,closedHatPan,closedHatGain,1.0,panClosedHat);
        }
        eighth => now;
    }
}

// Second four measures of the song
fun void secondFour() {
    for (0 => int counter; counter < 32; counter++) {
        counter % 16 => int beat;
        
        if (beat == 0 || beat == 3 || beat == 5 
        || beat == 9 || beat == 12 || beat == 13) {
            play(kick,kickPan,0.6,1.0,0.0);
        } 
        if (beat == 2 || beat == 6 || beat == 10 || beat == 14) {
            Math.random2f(0.6,0.9) => float panSnare;
            play(snare,snarePan,0.6,1.0,panSnare);
        }
        if (beat == 1 || beat == 7 || beat == 13) {
            Math.random2f(-0.9,0.5) => float panClosedHat;
            Math.random2f(0.4,0.8) => float closedHatGain;
            play(closedHat,closedHatPan,closedHatGain,1.0,panClosedHat);
        }
        if (beat == 4 || beat == 10) {
            Math.random2f(0.5,0.9) => float panOpenHat;
            play(openHat,openHatPan, 0.6,1.0,panOpenHat);
        }
        eighth => now;
    }
}

// Third four measures of the sound
fun void thirdFour() {
    for (0 => int counter; counter < 32; counter++) {
        counter % 16 => int beat;
        
        if (beat == 0 || beat == 9 || beat == 12) {
            play(kick,kickPan,0.6,1.0,0.0);
        } 
        if (beat == 2 || beat == 6 || beat == 10 || beat == 14) {
            Math.random2f(0.6,0.9) => float panSnare;
            play(snare,snarePan,0.6,1.0,panSnare);
        }
        if (beat == 1 || beat == 11) {
            Math.random2f(-0.5, 0.5) => float panClick;
            play(click, clickPan, 0.6, 1.0, panClick);
        }
        if (beat == 3) {
            Math.random2f(-0.9,0.5) => float panClosedHat;
            Math.random2f(0.4,0.8) => float closedHatGain;
            play(closedHat,closedHatPan,closedHatGain,1.0,panClosedHat);
        }
        if (beat == 4) {
            Math.random2f(0.5,0.9) => float panOpenHat;
            play(openHat,openHatPan, 0.6,1.0,panOpenHat);
        }
        eighth => now;
    }
}

// Fourth four measure of the song
fun void fourthFour() {
    for (0 => int counter; counter < 64; counter++) {
        counter % 32 => int beat;
        
        if (beat == 2 || beat == 8 || beat == 10 || beat == 14 
            || beat == 18 || beat == 24 || beat == 26) {
            play(kick,kickPan,0.6,1.0,0.0);
        } 
        if (beat == 3 || beat == 9 || beat == 11 || beat == 25) {
            play(kick2,kick2Pan,0.6,1.0,0.0);
        }
        if (beat == 4 || beat == 12 || beat == 20 || beat == 28) {
            Math.random2f(0.6,0.9) => float panSnare;
            play(snare,snarePan,0.6,1.0,panSnare);
        }
        if (beat == 0 || beat == 12 || beat == 26) {
            Math.random2f(-0.9,0.5) => float panClosedHat;
            Math.random2f(0.4,0.8) => float closedHatGain;
            play(closedHat,closedHatPan,closedHatGain,1.0,panClosedHat);
        }
        if (beat == 2 || beat == 14) {
            Math.random2f(0.5,0.9) => float panOpenHat;
            play(openHat,openHatPan, 0.6,1.0,panOpenHat);
        }
        eighth/2 => now;
    }
}

// Main function to call the functions in sequential order
fun void main() {
    firstFour();
    secondFour();
    thirdFour();
    fourthFour();
}

// Play the song
main();


