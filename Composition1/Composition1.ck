// Aman Panda 
// 4/14/16 
 
 
//Setting up the soundchain
SndBuf hihat => dac;
SndBuf snare => dac;
SndBuf kick => dac;
SndBuf crash => dac;

//triWave is the main oscillator. Used for intro, midsection and end melody, and the bass root for the final chord.
TriOsc triWave => dac;

//triWave2 is used as a harmony in the intro, bass in the midsection, harmony for the end, and the root of the final chord.
TriOsc triWave2 => dac;

//These waves are simply used to construct the final chord (Emin9) of the song.
TriOsc triWave3 => dac; // minor 3rd
TriOsc triWave4 => dac; // flat 7
TriOsc triWave5 => dac; // 9

//Directories for drum samples
me.dir() + "pandaaAudio/hihat.wav" => hihat.read;
me.dir() + "pandaaAudio/snare.wav" => snare.read;
me.dir() + "pandaaAudio/kick.wav" => kick.read;
me.dir() + "pandaaAudio/crash.wav" => crash.read;

//Set initial volume to 0 (gain)
0 => hihat.gain => snare.gain => kick.gain => crash.gain;
0 => triWave.gain => triWave2.gain => triWave3.gain => triWave4.gain => triWave5.gain;
//Initialize the measure counter
int measure;
1 => measure;

// Measures 1-8
while(measure < 9){
    
    //Beat 1
    0.08 => triWave.gain;
    659.25 => triWave.freq;
    0 => hihat.pos;
    .3 => hihat.gain;
    if(measure%2==0){
        0 => kick.pos;
        0.5 => kick.gain;
    }
    if(measure==3 || measure == 4 || measure == 7 || measure ==8){
        0.08 => triWave2.gain;
        783.99 => triWave2.freq;
    }
    if(measure ==5){
        0 => triWave2.gain;
    }
    .1::second => now;
    
    //Beat 2 
    .1::second => now;
    
    //Beat 3  
    0.08 => triWave.gain;
    587.33 => triWave.freq;
    0 => hihat.pos;
    .3 => hihat.gain;
    if(measure==3 || measure == 4 || measure == 7 || measure ==8){
        0.08 => triWave2.gain;
        739.99 => triWave2.freq;
    }
    .1::second => now;
    
    //Beat 4
    .1::second => now;
    
    //Beat 5
    0.08 => triWave.gain;
    493.88 => triWave.freq;
    0 => snare.pos;
    0.6 => snare.gain;
    0 => hihat.pos;
    .3 => hihat.gain;
    if(measure==3 || measure == 4 || measure == 7 || measure ==8){
        0.08 => triWave2.gain;
        587.33 => triWave2.freq;
    }
    .1::second => now;
    
    //Beat 6
    .1::second => now;
    
    //Beat 7 
    0.08 => triWave.gain;
    329.63 => triWave.freq;
    0 => hihat.pos;
    .3 => hihat.gain;
    if(measure==3 || measure == 4 || measure == 7 || measure ==8){
        0.08 => triWave2.gain;
        493.88 => triWave2.freq;
    }
    .1::second => now;
    
    //Beat 8
    .1::second => now;
    
    //Beat 9
    if(measure==3 || measure == 4 || measure == 7 || measure ==8){
        0.08 => triWave.gain;
        659.25 => triWave.freq;
        0.08 => triWave2.gain;
        783.99 => triWave2.freq;
    }
    0 => hihat.pos;
    .3 => hihat.gain;
    .1::second => now;
    
    //Beat 10
    .1::second => now;
    
    //Beat 11
    if(measure==3 || measure == 4 || measure == 7 || measure ==8){
        0.08 => triWave.gain;
        587.33 => triWave.freq;
        0.08 => triWave2.gain;
        739.99 => triWave2.freq;
    }
    0 => hihat.pos;
    .3 => hihat.gain;
    if(measure%2==0){
        0 => kick.pos;
        0.5 => kick.gain;
    }
    .1::second => now;
    
    //Beat 12
    .1::second => now;
    
    //Beat 13
    if(measure==3 || measure == 4 || measure == 7 || measure ==8){
        0.08 => triWave.gain;
        493.88 => triWave.freq;
        0.08 => triWave2.gain;
        587.33 => triWave2.freq;
    }
    0 => snare.pos;
    0.6 => snare.gain;
    0 => hihat.pos;
    .3 => hihat.gain;
    if(measure%2==0){
        0 => crash.pos;
        0.2 => crash.gain;
    }
    .1::second => now;
    
    //Beat 14
    .1::second => now;
    
    //Beat 15
    if(measure==3 || measure == 4 || measure == 7 || measure ==8){
        0.08 => triWave.gain;
        329.63 => triWave.freq;
        0.08 => triWave2.gain;
        493.88 => triWave2.freq;
    }
    0 => hihat.pos;
    .3 => hihat.gain;
    if(measure%2!=0){
        0 => kick.pos;
        0.5 => kick.gain;
    }
    .1::second => now;
    
    //Beat 16
    .1::second => now;
    measure+1 => measure;
}

//Measure 9-16
while(measure < 17){
    
    //Beat 1
    0 => crash.pos;
    .2 => crash.gain;
    0.08 => triWave.gain;
    164.81*2 => triWave.freq;
    0.09 => triWave2.gain;
    82.41 => triWave2.freq;
    .1::second => now;
    
    //Beat 2
    246.94*2 => triWave.freq;
    .1::second => now;
    
    //Beat 3
    293.66*2 => triWave.freq; 
    146.83 => triWave2.freq; 
    0 => kick.pos;
    .5 => kick.gain;
    .1::second => now;
    
    //Beat 4
    329.63*2 => triWave.freq;
    if(measure%2==0){
        0 => kick.pos;
        .5 => kick.gain;
    }
    .1::second => now;
    
    //Beat 5
    392*2 => triWave.freq;
    164.81 => triWave2.freq; 
    0 => crash.pos;
    .2 => crash.gain;
    0 => snare.pos;
    .6 => snare.gain;
    .1::second => now;
    
    //Beat 6
    329.63*2 => triWave.freq;
    .1::second => now;
    
    //Beat 7
    293.66*2 => triWave.freq;
    82.41 => triWave2.freq; 
    .1::second => now;
    
    //Beat 8
    246.94*2 => triWave.freq;
    .1::second => now;
    
    //Beat 9
    146.81 => triWave2.freq;
    if(measure%2!=0){ 
        293.63*2 => triWave.freq;
    }
    else{
        466.16*2 => triWave.freq;
    }
    0 => kick.pos;
    .5 => kick.gain;
    0 => crash.pos;
    0.2 => crash.gain;
    .1::second => now;
    
    //Beat 10
    164.81 => triWave2.freq;
    if(measure%2!=0){ 
        246.94*2 => triWave.freq;
    }
    else{
        440*2 => triWave.freq;
    }
    0 => kick.pos;
    .5 => kick.gain;
    .1::second => now;
    
    //Beat 11
    82.41 => triWave2.freq;
    if(measure%2!=0){
        220*2 => triWave.freq;
    }
    else{
        392*2 => triWave.freq;
    }
    0 => kick.pos;
    .5 => kick.gain;
    .1::second => now;
    
    //Beat 12
    if(measure%2!=0){
        196*2 => triWave.freq;
        0 => kick.pos;
        .5 => kick.gain;
    }
    else{
        329.63*2 => triWave.freq;
    }
    .1::second => now;
    
    //Beat 13
    146.83 => triWave2.freq;
    if(measure%2!=0){
        164.81*2 => triWave.freq;
    }
    else{
        220*2 => triWave.freq;
    }
    0 => crash.pos;
    .2 => crash.gain;
    0 => snare.pos;
    .6 => snare.gain;
    .1::second => now;
    
    //Beat 14
    if(measure%2==0){
        246.94*2 => triWave.freq;
    }
    .1::second => now;
    
    //Beat 15
    164.81 => triWave2.freq;
    if(measure%2!=0){
        0 => triWave.gain;
    }
    else{
        293.66*2 => triWave.freq;
    }
    0 => kick.pos;
    .5 => kick.gain;
    .1::second => now;
    
    //Beat 16
    if(measure%2==0){
        329.63*2 => triWave.freq;
    }
    .1::second => now;
    measure+1 => measure;
}

//Measure 17
0.08 => triWave2.gain;
493.88 => triWave.freq;
587.33 => triWave2.freq;
0 => kick.pos;
.5 => kick.gain;
0 => hihat.pos;
.3 => hihat.gain;
0.8::second => now;
    
392 => triWave.freq;
493.88  => triWave2.freq;
0 => kick.pos;
.5 => kick.gain;
0 => crash.pos;
.3 => crash.gain;
0.8::second => now;
    
//Measure 18
369.99 => triWave.freq;
440 => triWave2.freq;
0 => kick.pos;
.5 => kick.gain;
0 => hihat.pos;
.3 => hihat.gain;
0.8::second => now;
    
329.63 => triWave.freq;
392 => triWave2.freq;
0 => kick.pos;
.5 => kick.gain;
0 => crash.pos;
.3 => crash.gain;

0.8::second => now;

//Volume tracker for final swell
float volume;
0.1 => volume;

//Initialize volume of final chord
volume  => triWave.gain;
volume  => triWave2.gain;
volume  => triWave3.gain;
volume  => triWave4.gain;
volume  => triWave5.gain;

//Emin9 chord
164.81 => triWave.freq;
329.63 => triWave2.freq;
392 => triWave3.freq;
587.33 => triWave4.freq;
739.99 => triWave5.freq;

//Final hit
0 => kick.pos;
.5 => kick.gain;
0 => crash.pos;
.3 => crash.gain;
0.4::second => now;

//Ring final chord with decreasing volume.
while(volume>0){
    volume - 0.001 => triWave.gain;
    volume - 0.001 => triWave2.gain;
    volume - 0.001 => triWave3.gain;
    volume - 0.001 => triWave4.gain;
    volume - 0.001 => triWave5.gain;
    
    //Note: I realize this is probably not the best way to do this, but I had
    //trouble trying it through other means.
    volume - 0.001 => volume;
    0.05::second => now;
}


    
    

