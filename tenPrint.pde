import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
BeatDetect beat;
BeatListener bl;
FFT fftLin;
float spectrumScale = 4;
int songBufferSize;
float songSampleRate;
int lastDetected = 0, transitionTime, bgColorIndex = 0;

int x = 0, y = 0, spacing = 50, index = 0, vertexLength = 50, patternNum = 2;
boolean scroll = false, looping = true, bgResetNeeded = false;
RandomPattern pattern;
int bgColor[] = {0,255};

TypographyClass typography;


void setup() {
	size(600, 600);
	//size(displayWidth, displayHeight);
	background(255);
	pattern = new RandomPattern(vertexLength);

	minim = new Minim(this);  
	song = minim.loadFile("jsicn.mp3", 2048);
	//song.cue(90000);
	song.play();
	songBufferSize = song.bufferSize();
	songSampleRate = song.sampleRate();

	beat = new BeatDetect(songBufferSize, songSampleRate);
	beat.setSensitivity(300);
	bl = new BeatListener(beat, song);

	fftLin = new FFT(songBufferSize, songSampleRate);
	fftLin.linAverages( 30 );

	typography = new TypographyClass(this);
}

void draw() {
	fftLin.forward( song.mix );
	transitionTime = song.position();

	if (transitionTime >= 0 && transitionTime <= 18000 && (millis() - lastDetected) > 100) {		
		if (beat.isHat()) {
			lastDetected = millis();
			background(255);
			for (int i = 0; i < int(random(50, 1000)); ++i) {
				patternNum = int(random(1, 8));
				x = spacing * int(random(0, 12));
				y = spacing * int(random(0, 12));
				pattern.setPattern(x, y, patternNum, index);
			}			
		}
		if (bgResetNeeded == false) {
			bgResetNeeded = true;
		}
	}
	else if ((transitionTime >= 90100 && transitionTime <= 123140) || (transitionTime >= 186000)) {
		if (transitionTime >= 90100 && transitionTime <= 123140) {
			background(bgColor[bgColorIndex]);
			if (transitionTime >= 90300 && transitionTime <= 92000) {
				typography.typographyDraw(0, int(random(0, 3)));
			}
			else if (transitionTime >= 94100 && transitionTime <= 95000) {
				typography.typographyDraw(1, int(random(0, 3)));
			}
			else if (transitionTime >= 96100 && transitionTime <= 97000) {
				typography.typographyDraw(2, int(random(0, 3)));
			}
			else if (transitionTime >= 98100 && transitionTime <= 99000) {
				typography.typographyDraw(3, int(random(0, 3)));
			}
			else if (transitionTime >= 101100 && transitionTime <= 102000) {
				typography.typographyDraw(4, int(random(0, 3)));
			}
			else if (transitionTime >= 104100 && transitionTime <= 105000) {
				typography.typographyDraw(5, int(random(0, 3)));
			}
			else if (transitionTime >= 108100 && transitionTime <= 109000) {
				typography.typographyDraw(6, int(random(0, 3)));
			}
			else if (transitionTime >= 110100 && transitionTime <= 111000) {
				typography.typographyDraw(7, int(random(0, 3)));
			}
			else if (transitionTime >= 112100 && transitionTime <= 113000) {
				typography.typographyDraw(8, int(random(0, 3)));
			}
			else if (transitionTime >= 114100 && transitionTime <= 15000) {
				typography.typographyDraw(9, int(random(0, 3)));
			}
			else if (transitionTime >= 116100 && transitionTime <= 117000) {
				typography.typographyDraw(10, int(random(0, 3)));
			}
			else if (transitionTime >= 118100 && transitionTime <= 119000) {
				typography.typographyDraw(11, int(random(0, 3)));
			}
			else if (transitionTime >= 120100 && transitionTime <= 121000) {
				typography.typographyDraw(12, int(random(0, 3)));
			}
			else if (transitionTime >= 122100 && transitionTime <= 123000) {
				typography.typographyDraw(13, int(random(0, 3)));
			}
			else if ((fftLin.getAvg(0)*spectrumScale >= 260) && (millis() - lastDetected) > 100) {
				lastDetected = millis();
				//background(bgColor[bgColorIndex]);
				background(bgColor[bgColorIndex = (bgColorIndex < (bgColor.length - 1) ? ++bgColorIndex : 0)]);
				patternNum = int(random(1, 8));
				index = 0;
				for (int i = 0; i <= height; i += spacing) {
					for (int j = 0; j <= height; j += spacing) {
						pattern.setPattern(j, i, patternNum, index);
					}
					index++;
				}
			}
		}
		else if ((fftLin.getAvg(0)*spectrumScale >= 260) && (millis() - lastDetected) > 100) {
			lastDetected = millis();
			background(255);
			patternNum = int(random(1, 8));
			index = 0;
			for (int i = 0; i <= height; i += spacing) {
				for (int j = 0; j <= height; j += spacing) {
					pattern.setPattern(j, i, patternNum, index);
				}
				index++;
			}
		}
		x = y = index = 0;
		scroll = false;
		if (bgResetNeeded == false) {
			bgResetNeeded = true;
		}
	}
	else if (transitionTime > 18000) {
		if (bgResetNeeded == true) {
			bgResetNeeded = false;
			background(bgColor[bgColorIndex]);
		}		
		pattern.setPattern(x, y, patternNum, index);
		x += spacing;

		if (x > (width + 1*spacing)) {
			x = 0;
			index++;
			if (scroll == true) {		
				y = height-vertexLength;
				PImage p = get(0, 0, width, height);
				//background(255);
				background(bgColor[bgColorIndex]);
				set(0, -(spacing), p);
			}
			else {
				y += spacing;
			}		
		}

		if (index == (height/spacing) && scroll == false) {
			PImage p = get(0, 0, width, height);
			//background(255);
			background(bgColor[bgColorIndex]);
			set(0, -(spacing), p);
			scroll = true;
			y = height-vertexLength;
		}
		
		if ((fftLin.getAvg(0)*spectrumScale >= 260) && (millis() - lastDetected) > 100) {
			lastDetected = millis();
			background(bgColor[bgColorIndex = (bgColorIndex < (bgColor.length - 1) ? ++bgColorIndex : 0)]);
		}
		if ((fftLin.getAvg(3)*spectrumScale >= 58) /*&& (millis() - lastDetected) > 1000*/) {
			//lastDetected = millis();
			background(bgColor[bgColorIndex]);
			patternNum = int(random(1, 8));	
			if (frameCount%10 == 0) {
				x = spacing * int(random(0, 12));
			}
			else {
				x = 0;
			}		
			y = spacing * int(random(0, 12));
			index = (y/spacing);
			scroll = false;
		}
	}
	//println(song.position());
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
