import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
BeatDetect beat;
BeatListener bl;

int x = 0, y = 0, spacing = 50, index =0, vertexLength = 50, patternNum = 2;
boolean scroll = false, looping = true;
RandomPattern pattern;


void setup() {
	size(600, 600);
	//size(displayWidth, displayHeight);
	background(255);
	pattern = new RandomPattern(vertexLength);

	minim = new Minim(this);  
	song = minim.loadFile("jsicn.mp3", 2048);
	song.play();
	beat = new BeatDetect(song.bufferSize(), song.sampleRate());
	beat.setSensitivity(300);

	bl = new BeatListener(beat, song); 
}

void draw() {

	pattern.setPattern(x, y, patternNum, index);

	x += spacing;

	if (x > (width + 1*spacing)) {
		x = 0;
		index++;
		if (scroll == true) {
			//noLoop();			
			y = height-vertexLength;
			PImage p = get(0, 0, width, height);
			background(255);
			set(0, -(spacing), p);			
			//delay(1000);
		}
		else {
			y += spacing;
		}		
	}

	//println("height/spacing: " + (height/spacing) + "\t index: " + index + "\t y: " + y);

	if (index == ((height/spacing)) && scroll == false) {
		//background(255);
		PImage p = get(0, 0, width, height);
		background(255);
		set(0, -(spacing), p);
		scroll = true;
		y = height-vertexLength;
	}

	if (beat.isKick() /*&& frameCount%10 == 0*/) {		
		background(255);
		patternNum = int(random(1, 8));
		// println(patternNum);		
		if (frameCount%10 == 0) {
			x = 0 /*int(random(0, width/2))*/;
		}
		else {
			x = int(random(0, width/2));
			//index = 0;
		}
		y = int(random(0, height/1.2));
	}
	// if ( beat.isSnare() ) snareSize = 32;
	// if ( beat.isHat() ) hatSize = 32;
}

void keyPressed() {

	if (key == ' ') {
		if (looping == true) {
			noLoop();
			song.pause();
			looping = false;
		}
		else {
			loop();
			song.loop();
			looping = true;
		}
    }
}

// void mousePressed() {
//   patternNum = int(random(4, 8));
//   println("patternNum: "+patternNum);
// }
