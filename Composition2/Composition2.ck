// Composer: Aman Panda
// Date: 5/3/16

// Sending drum samples to dac
SndBuf kick => Pan2 kickPan => dac;
SndBuf hihat => NRev hihatRev => Pan2 hihatPan => dac;
SndBuf openHihat => NRev openHihatRev => Pan2 openHihatPan => dac;
SndBuf crash => PRCRev crashRev => Pan2 crashPan => dac;
SndBuf snare => JCRev snareRev => Pan2 snarePan => dac;

// Sending guitar chord samples to dac.
// Recording on Native Instruments Guitar Rig
// 800 and AC are just the names of 2 different presets
SndBuf First800 => Pan2 First800Pan => dac;
SndBuf Second800 => Pan2 Second800Pan => dac;
SndBuf Third800 => Pan2 Third800Pan => dac;
SndBuf FirstAC => Pan2 FirstACPan => dac;
SndBuf SecondAC => Pan2 SecondACPan => dac;
SndBuf ThirdAC => Pan2 ThirdACPan => dac;

// Triangle oscilators
TriOsc melody => Pan2 melodyPan => dac;
TriOsc bass => dac;

// Directories for samples
me.dir() + "pandaaAudio/kick.wav" => kick.read;
me.dir() + "pandaaAudio/hihat.wav" => hihat.read;
me.dir() + "pandaaAudio/openHihat.wav" => openHihat.read;
me.dir() + "pandaaAudio/crash.wav" => crash.read;
me.dir() + "pandaaAudio/snare.wav" => snare.read;
me.dir() + "pandaaAudio/1st800.wav" => First800.read;
me.dir() + "pandaaAudio/2nd800.wav" => Second800.read;
me.dir() + "pandaaAudio/3rd800.wav" => Third800.read;
me.dir() + "pandaaAudio/1stAC.wav" => FirstAC.read;
me.dir() + "pandaaAudio/2ndAC.wav" => SecondAC.read;
me.dir() + "pandaaAudio/3rdAC.wav" => ThirdAC.read;

// Initializing gain
0 => kick.gain => hihat.gain => openHihat.gain => crash.gain => snare.gain;
0 => First800.gain => Second800.gain => Third800.gain;
0 => FirstAC.gain => SecondAC.gain => ThirdAC.gain;

// Initializing reverb
0.3 => hihatRev.mix;
0.3 => crashRev.mix;
0.1 => snareRev.mix;

//Initializing oscillator gains
0 => bass.gain;
0 => melody.gain;

// Initializing counters
0 => int counter;
0 => int measure;

// ifStartMelody used as a integer boolean
0 => int ifStartMelody;

while(counter<112){
    // 7/8 meter (2 measures at a time)
    counter % 14 => int beat;
    
    
    if(beat == 0){
        
        // Hit hihat
        0 => hihat.pos;
        Math.random2f(.4,.5) => hihat.gain;
        Math.random2f(-0.3,-0.2) => hihatPan.pan;
        
        if(measure%2==0){
            
            //Ring chord
            0 => ThirdAC.gain;
            0 => Third800.gain;
            0 => FirstAC.pos;
            0 => First800.pos;
            110 => bass.freq;
            Math.random2f(0.5,0.6) => FirstAC.gain;
            Math.random2f(-1,-.8) => FirstACPan.pan;
            Math.random2f(0.5,0.6) => First800.gain;
            Math.random2f(0.8,1) => First800Pan.pan;
            
            //Hit crash
            0 => crash.pos;
            Math.random2f(0.6,0.8) => crash.rate;
            Math.random2f(0.2,0.4) => crash.gain;
            Math.random2f(-0.7,-0.3) => crashPan.pan;
        }
        else{
            0 => SecondAC.pos;
            0 => Second800.pos;
            130.81 => bass.freq;
            Math.random2f(0.5,0.6) => SecondAC.gain;
            Math.random2f(-1,-.8) => SecondACPan.pan;
            Math.random2f(0.5,0.6) => Second800.gain;
            Math.random2f(0.8,1) => Second800Pan.pan;
        }
        
        //Start the bass when condition is met
        if(measure > 3){
            0.15 => bass.gain;
        }
    }
    
    if(beat == 1){
        0 => hihat.pos;
        Math.random2f(.05,.15) => hihat.gain;
        Math.random2f(-0.3,-0.2) => hihatPan.pan;
    }
    
    if(beat == 2){
        0 => hihat.pos;
        Math.random2f(.4,.5) => hihat.gain;
        Math.random2f(-0.3,-0.2) => hihatPan.pan;
    }
    
    if(beat == 3){
        0 => hihat.pos;
        Math.random2f(.05,.15) => hihat.gain;
        Math.random2f(-0.3,-0.2) => hihatPan.pan;
    }
    
    if(beat == 4){
        0 => hihat.pos;
        Math.random2f(.4,.5) => hihat.gain;
        Math.random2f(-0.3,-0.2) => hihatPan.pan;
    }
    
    if(beat == 5){
        0 => hihat.pos;
        Math.random2f(.05,.15) => hihat.gain;
        Math.random2f(-0.3,-0.2) => hihatPan.pan;
    }
    
    if(beat == 6){
        0 => hihat.pos;
        Math.random2f(.05,.15) => hihat.gain;
        Math.random2f(-0.3,-0.2) => hihatPan.pan;
    }
    
    if(beat == 7){
        0 => hihat.pos;
        Math.random2f(.4,.5) => hihat.gain;
        Math.random2f(-0.3,-0.2) => hihatPan.pan;
        if(measure%2==1){
            // Ring chord
            0 => SecondAC.gain;
            0 => Second800.gain;
            0 => ThirdAC.pos;
            0 => Third800.pos;
            98 => bass.freq;
            Math.random2f(0.3,0.4) => ThirdAC.gain;
            Math.random2f(-1.0,-0.8) => ThirdACPan.pan;
            Math.random2f(0.3,0.4) => Third800.gain;
            Math.random2f(0.8,1) => Third800Pan.pan;
        }
    }
    
    if(beat == 8){
        0 => hihat.pos;
        Math.random2f(.05,.15) => hihat.gain;
        Math.random2f(-0.3,-0.2) => hihatPan.pan;
    }
    
    if(beat == 9){
        0 => hihat.pos;
        Math.random2f(.4,.5) => hihat.gain;
        Math.random2f(-0.3,-0.2) => hihatPan.pan;
    }
    
    if(beat == 10){
        0 => hihat.pos;
        Math.random2f(.05,.15) => hihat.gain;
        Math.random2f(-0.3,-0.2) => hihatPan.pan;
    }
    
    if(beat == 11){
        0 => hihat.pos;
        Math.random2f(.4,.5) => hihat.gain;
        Math.random2f(-0.3,-0.2) => hihatPan.pan;
    }
    
    if(beat == 12){
        0 => hihat.pos;
        Math.random2f(.05,.15) => hihat.gain;
        Math.random2f(-0.3,-0.2) => hihatPan.pan;
    }
    
    if(beat == 13){
        0 => hihat.pos;
        Math.random2f(.05,.15) => hihat.gain;
        Math.random2f(-0.3,-0.2) => hihatPan.pan;
        // Keep track of measures
        measure++;
    }
    
    // Increment counter
    counter++;
    
    // Move time forward
    200::ms => now;
}

while(counter<448){
    
    // 7/8 meter (2 measures at a time)
    counter % 14 => int beat;
    
    // Once condition is met, the melody may begin
    if(measure > 15){
        1 => ifStartMelody;
    }
    
    if(beat == 0){
        0 => kick.pos;
        Math.random2f(0.5,0.6) => kick.gain;
        
        if(measure%2==0){
            0 => ThirdAC.gain;
            0 => Third800.gain;
            0 => FirstAC.pos;
            0 => First800.pos;
            110 => bass.freq;
            Math.random2f(0.5,0.6) => FirstAC.gain;
            Math.random2f(-1,-.8) => FirstACPan.pan;
            Math.random2f(0.5,0.6) => First800.gain;
            Math.random2f(0.8,1) => First800Pan.pan;
            0 => crash.pos;
            Math.random2f(0.6,0.8) => crash.rate;
            Math.random2f(0.2,0.4) => crash.gain;
            Math.random2f(-0.7,-0.3) => crashPan.pan;
            if(ifStartMelody==1){
                0.08 => melody.gain;
                Math.random2f(0.3,0.5) => melodyPan.pan;
                440 => melody.freq;
            }
        }
        if(measure%2==1){
            0 => SecondAC.pos;
            0 => Second800.pos;
            0.15 => bass.gain;
            130.81 => bass.freq;
            Math.random2f(0.5,0.6) => SecondAC.gain;
            Math.random2f(-1,-.8) => SecondACPan.pan;
            Math.random2f(0.5,0.6) => Second800.gain;
            Math.random2f(0.8,1) => Second800Pan.pan;
            if(ifStartMelody==1){
                0.1 => melody.gain;
                Math.random2f(0.3,0.5) => melodyPan.pan;
                523.25 => melody.freq;
            }
        }   
    }
    
    if(beat == 1){
        0 => hihat.pos;
        Math.random2f(.4,.5) => hihat.gain;
        Math.random2f(-0.3,-0.2) => hihatPan.pan;
        if(measure%2==0){
            0 => bass.gain;
            if(ifStartMelody==1){
                Math.random2f(0.3,0.5) => melodyPan.pan;
                0 => melody.gain;
            }
        }
        if(measure%2==1){
            0 => bass.gain;
            if(ifStartMelody==1){
                Math.random2f(0.3,0.5) => melodyPan.pan;
                0 => melody.gain;
                523.25 => melody.freq;
            }
        }
    }
    
    if(beat == 2){
        0 => kick.pos;
        Math.random2f(0.5,0.6) => kick.gain;
        if(measure%2==0){
            0.15 => bass.gain;
            if(ifStartMelody==1){
                Math.random2f(0.3,0.5) => melodyPan.pan;
                440 => melody.freq;
                0.08 => melody.gain;
            }
        }
        if(measure%2==1){
            130.81 => bass.freq;
            0.15 => bass.gain;
            if(ifStartMelody==1){
                Math.random2f(0.3,0.5) => melodyPan.pan;
                0.08 => melody.gain;
                523.25 => melody.freq;
            }
        }
    }
    
    if(beat == 3){
        0 => hihat.pos;
        Math.random2f(.4,.5) => hihat.gain;
        Math.random2f(-0.3,-0.2) => hihatPan.pan;
        if(measure%2==0){
            0 => bass.gain;
            if(ifStartMelody==1){
                Math.random2f(0.3,0.5) => melodyPan.pan;
                0 => melody.gain;
            }
        }
        if(measure%2==1){
            0 => bass.gain;
            if(ifStartMelody==1){
                Math.random2f(0.3,0.5) => melodyPan.pan;
                0 => melody.gain;
                523.25 => melody.freq;
            }
        }
    }
    
    if(beat == 4){
        0 => snare.pos;
        Math.random2f(0.3,0.4) => snare.gain;
        Math.random2f(0.2,0.3) => snarePan.pan;
        Math.random2f(0.8,1.2) => snare.rate;
        if(measure%2==0){
            196 => bass.freq;
            0.15 => bass.gain;
            if(ifStartMelody==1){
                Math.random2f(0.3,0.5) => melodyPan.pan;
                0.08 => melody.gain;
                440 => melody.freq;
            }
        }
        if(measure%2==1){
            261.63 => bass.freq;
            0.15 => bass.gain;
            if(ifStartMelody==1){
                Math.random2f(0.3,0.5) => melodyPan.pan;
                0.08 => melody.gain;
                523.25 => melody.freq;
            }
        }
    }
    
    if(beat == 5){
        0 => hihat.pos;
        Math.random2f(.4,.5) => hihat.gain;
        Math.random2f(-0.3,-0.2) => hihatPan.pan;
        if(measure%2==0){
            207.65 => bass.freq;
            0.15 => bass.gain;
            if(ifStartMelody==1){
                Math.random2f(0.3,0.5) => melodyPan.pan;
                0.08 => melody.gain;
                493.88 => melody.freq;
            }
        }
        if(measure%2==1){
            293.66 => bass.freq;
            0.15 => bass.gain;
            if(ifStartMelody==1){
                Math.random2f(0.3,0.5) => melodyPan.pan;
                0.08 => melody.gain;
                587.33 => melody.freq;
            }
        }
    }
    
    if(beat == 6){
        0 => hihat.pos;
        Math.random2f(.4,.5) => hihat.gain;
        Math.random2f(-0.3,-0.2) => hihatPan.pan;
        if(measure%2==0){
            220 => bass.freq;
            0.15 => bass.gain;
            if(ifStartMelody==1){
                Math.random2f(0.3,0.5) => melodyPan.pan;
                0.08 => melody.gain;
                392 => melody.freq;
            }
        }
        if(measure%2==1){
            246.94 => bass.freq;
            0.15 => bass.gain;
            if(ifStartMelody==1){
                Math.random2f(0.3,0.5) => melodyPan.pan;
                0.08 => melody.gain;
                440 => melody.freq;
            }
        }
    }
    
    if(beat == 7){
        0 => kick.pos;
        Math.random2f(0.5,0.6) => kick.gain;
        if(measure%2==1){
            0 => SecondAC.gain;
            0 => Second800.gain;
            0 => ThirdAC.pos;
            0 => Third800.pos;
            98 => bass.freq;
            Math.random2f(0.3,0.4) => ThirdAC.gain;
            Math.random2f(-1.0,-0.8) => ThirdACPan.pan;
            Math.random2f(0.3,0.4) => Third800.gain;
            Math.random2f(0.8,1) => Third800Pan.pan;
        }
        if(measure%2==0){
            110 => bass.freq;
            0.15 => bass.gain;
            if(ifStartMelody==1){
                Math.random2f(0.3,0.5) => melodyPan.pan;
                0.08 => melody.gain;
                440 => melody.freq;
            }
        }
        if(measure%2==1){
            98 => bass.freq;
            0.15 => bass.gain;
            if(ifStartMelody==1){
                Math.random2f(0.3,0.5) => melodyPan.pan;
                0.08 => melody.gain;
                493.88 => melody.freq;
            }
        }
    }
    
    if(beat == 8){
        0 => hihat.pos;
        Math.random2f(.4,.5) => hihat.gain;
        Math.random2f(-0.3,-0.2) => hihatPan.pan;
        if(measure%2==0){
            0 => bass.gain;
            if(ifStartMelody==1){
                Math.random2f(0.3,0.5) => melodyPan.pan;
                0 => melody.gain;
            }
        }
        if(measure%2==1){
            0 => bass.gain;
            if(ifStartMelody==1){
                Math.random2f(0.3,0.5) => melodyPan.pan;
                0 => melody.gain;
                523.25 => melody.freq;
            }
        }
    }
    
    if(beat == 9){
        0 => kick.pos;
        Math.random2f(0.5,0.6) => kick.gain;
        if(measure%2==0){
            110 => bass.freq;
            0.15 => bass.gain;
            if(ifStartMelody==1){
                Math.random2f(0.3,0.5) => melodyPan.pan;
                0.08 => melody.gain;
                329.63 => melody.freq;
            }
        }
        if(measure%2==1){
            98=> bass.freq;
            0.15 => bass.gain;
            if(ifStartMelody==1){
                Math.random2f(0.3,0.5) => melodyPan.pan;
                0.08 => melody.gain;
                493.88 => melody.freq;
            }
        }
    }
    
    if(beat == 10){
        0 => hihat.pos;
        Math.random2f(.4,.5) => hihat.gain;
        Math.random2f(-0.3,-0.2) => hihatPan.pan;
        if(measure%2==0){
            0 => bass.gain;
            if(ifStartMelody==1){
                Math.random2f(0.3,0.5) => melodyPan.pan;
                0 => melody.gain;
            }
        }
        if(measure%2==1){
            0 => bass.gain;
            if(ifStartMelody==1){
                Math.random2f(0.3,0.5) => melodyPan.pan;
                0 => melody.gain;
                493.88 => melody.freq;
            }
        }
    }
    
    if(beat == 11){
        0 => snare.pos;
        Math.random2f(0.3,0.4) => snare.gain;
        Math.random2f(0.2,0.3) => snarePan.pan;
        Math.random2f(0.8,1.2) => snare.rate;
        if(measure%2==0){
            220 => bass.freq;
            0.15 => bass.gain;
            if(ifStartMelody==1){
                Math.random2f(0.3,0.5) => melodyPan.pan;
                0.1 => melody.gain;
                392 => melody.freq;
            }
        }
        if(measure%2==1){
            261.63 => bass.freq;
            0.15 => bass.gain;
            if(ifStartMelody==1){
                Math.random2f(0.3,0.5) => melodyPan.pan;
                0.08 => melody.gain;
                523.25 => melody.freq;
            }
        }
    }
    
    if(beat == 12){
        0 => hihat.pos;
        Math.random2f(.4,.5) => hihat.gain;
        Math.random2f(-0.3,-0.2) => hihatPan.pan;
        if(measure%2==1){
            246.94 => bass.freq;
            0.15 => bass.gain;
            if(ifStartMelody==1){
                Math.random2f(0.3,0.5) => melodyPan.pan;
                0.08 => melody.gain;
                493.88 => melody.freq;
            }
        }
        if(measure%2==0){
            if(ifStartMelody==1){
                Math.random2f(0.3,0.5) => melodyPan.pan;
                0 => melody.gain;
            }
        }
    }
    
    if(beat == 13){
        0 => hihat.pos;
        Math.random2f(.4,.5) => hihat.gain;
        Math.random2f(-0.3,-0.2) => hihatPan.pan;
        if(measure%2==0){
            0 => bass.gain;
        }
        if(measure%2==1){
            196 => bass.freq;
            0.15 => bass.gain;
            if(ifStartMelody==1){
                Math.random2f(0.3,0.5) => melodyPan.pan;
                0.08 => melody.gain;
                392 => melody.freq;
            }
        }
        // Keep track of how many measures have passed
        measure++;
    }
    
    // Increment counter
    counter++;
    
    // Movie time forward
    200::ms => now;
}

