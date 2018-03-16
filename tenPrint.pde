/**
 * 
 *Main file of the Sketch. Uses Minim Library for loading and performing frequency analysis on it.
 *for more infor on Minim: http://code.compartmental.net/minim/
 * 
 */
import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
BeatDetect beat;
BeatListener bl;
FFT fftLin;
float spectrumScale, songSampleRate;
int songBufferSize, lastDetected, transitionTime, bgColorIndex;
int x, y, spacing, index, vertexLength, patternNum, imgWidth, imgHeight;
boolean scroll, looping, bgResetNeeded, endingBgResetNeeded;
RandomPattern pattern;
int bgColor[] = {0,255};
PImage img, p;
TypographyClass typography;
String settingsValue[] = new String[12];

void setup() {
	fullScreen();
	println(displayWidth+" - "+displayHeight);

	//global values are initialized from the settings.csv file.
	settingsValue = loadStrings("settings.csv");
	{
		bgColorIndex = int(split(settingsValue[0], ",")[1]);
		spectrumScale = float(split(settingsValue[1], ",")[1]);
		x = int(split(settingsValue[2], ",")[1]);
		y = int(split(settingsValue[3], ",")[1]);
		spacing = int(split(settingsValue[4], ",")[1]);
		index = int(split(settingsValue[5], ",")[1]);
		vertexLength = int(split(settingsValue[6], ",")[1]);
		patternNum = int(split(settingsValue[7], ",")[1]);
		scroll = boolean(split(settingsValue[8], ",")[1]);
		looping = boolean(split(settingsValue[9], ",")[1]);
		bgResetNeeded = boolean(split(settingsValue[10], ",")[1]);
		endingBgResetNeeded = boolean(split(settingsValue[11], ",")[1]);
	}

	//loading the album art to be displayed at the end.
	img = loadImage("jaden-smith-syre.jpg");
	imgWidth = img.width;
	imgHeight = img.height;

	//background color is set to white.
	background(bgColor[bgColor.length-1]);
	//RandomPattern object is created using the vertexLenght.
	pattern = new RandomPattern(vertexLength);

	//Minim Library is initialized, music is loaded into AudioPlayer object.
	minim = new Minim(this);
	song = minim.loadFile("jsicn.mp3", 2048);
	//song.cue(213000);
	song.play();

	//BeatDetect and FFT object is created using songBufferSize and songSampleRate
	//of Audioplayer object.
	songBufferSize = song.bufferSize();
	songSampleRate = song.sampleRate();
	beat = new BeatDetect(songBufferSize, songSampleRate);
	beat.setSensitivity(300);
	bl = new BeatListener(beat, song);
	fftLin = new FFT(songBufferSize, songSampleRate);
	fftLin.linAverages(30);

	//an object for TypographyClass is created.
	typography = new TypographyClass(this);
}

void draw() {
	//performs a forward FFT on the samples in song's mix buffer.
	fftLin.forward(song.mix);
	//keeping track of music's progress.
	transitionTime = song.position();

	//from the start and till 18 seconds in to the music, a number of tiles ranging between
	//50-1000 with vertex length varying between 50-200 are displayed at random x and y 
	//positions everytime when a high hat frequency is sensed. A delay of 100ms is useed to dampen the
	//sensitivity.
	if (transitionTime >= 0 && transitionTime <= 18000 && (millis() - lastDetected) > 100) {		
		if (beat.isHat()) {
			lastDetected = millis();
			vertexLength = spacing = int(random(50, 200));
			pattern = new RandomPattern(vertexLength);
			background(255);
			for (int i = 0; i < int(random(50, 1000)); ++i) {
				patternNum = int(random(1, 14));
				x = spacing * int(random(0, (displayWidth/spacing)));
				y = spacing * int(random(0, (displayHeight/spacing)));
				pattern.setPattern(x, y, patternNum, index);
			}			
		}
		bgResetNeeded = (bgResetNeeded == false) ? true : false;
	}
	else if ((transitionTime >= 90100 && transitionTime <= 123000) || (transitionTime >= 186000)) {
		//Based on time, keywords of lyrics is selected using a number between 0-14 and 
		//the algorithm for typography is selected using a number between 0-2.
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
			else if (transitionTime >= 119100 && transitionTime <= 120000) {
				typography.typographyDraw(12, int(random(0, 3)));
			}
			else if (transitionTime >= 120100 && transitionTime <= 121000) {
				typography.typographyDraw(13, int(random(0, 3)));
			}
			else if (transitionTime >= 122100 && transitionTime <= 123000) {
				typography.typographyDraw(14, int(random(0, 3)));
			}
			//background color is switched and the patterns generated are flashed for short duration 
			//between the the keywords on sensing a kick.
			else if ((fftLin.getAvg(0)*spectrumScale >= 260) && (millis() - lastDetected) > 100) {
				lastDetected = millis();
				vertexLength = spacing = int(random(50, 200));
				pattern = new RandomPattern(vertexLength);
				background(bgColor[bgColorIndex = (bgColorIndex < (bgColor.length - 1) ? ++bgColorIndex : 0)]);
				patternNum = int(random(1, 14));
				index = 0;
				for (int i = 0; i <= displayHeight; i += spacing) {
					for (int j = 0; j <= displayWidth; j += spacing) {
						pattern.setPattern(j, i, patternNum, index);
					}
					index++;
				}
			}
		}
		else if ((fftLin.getAvg(0)*spectrumScale >= 260) && (millis() - lastDetected) > 100) {
			lastDetected = millis();
			background(255);
			vertexLength = spacing = int(random(50, 200));
			pattern = new RandomPattern(vertexLength);
			patternNum = int(random(1, 14));
			index = 0;
			for (int i = 0; i <= displayHeight; i += spacing) {
				for (int j = 0; j <= displayWidth; j += spacing) {
					pattern.setPattern(j, i, patternNum, index);
				}
				index++;
			}
		}
		x = y = index = 0;
		scroll = false;
		bgResetNeeded = (bgResetNeeded == false) ? true : false;
	}
	//displays at position x,y from left to right and from top to bottom.
	else if (transitionTime > 18000) {
		if (bgResetNeeded == true) {
			bgResetNeeded = false;
			background(bgColor[bgColorIndex]);
		}

		pattern.setPattern(x, y, patternNum, index);
		x += spacing;

		if (x > (displayWidth)) {
			x = 0;
			index++;
			//creats a scrolling effect when the x and y goes beyond displayWidht and displayHeight
			//respectively.
			if (scroll == true) {		
				y = displayHeight-vertexLength;
				p = get(0, 0, displayWidth, displayHeight);
				background(bgColor[bgColorIndex]);
				set(0, -(spacing), p);
			}
			else {
				y += spacing;
			}		
		}

		if (index == (displayHeight/spacing) && scroll == false) {
			p = get(0, 0, displayWidth, displayHeight);
			background(bgColor[bgColorIndex]);
			set(0, -(spacing), p);
			scroll = true;
			y = displayHeight-vertexLength;
		}
		//senses kick and changes the background color.
		if ((fftLin.getAvg(0)*spectrumScale >= 260) && (millis() - lastDetected) > 100) {
			lastDetected = millis();
			background(bgColor[bgColorIndex = (bgColorIndex < (bgColor.length - 1) ? ++bgColorIndex : 0)]);
		}
		//senses snare, changed the vertex length of the tiles and randomly selects a pattern for generation.
		if ((fftLin.getAvg(3)*spectrumScale >= 58)) {
			background(bgColor[bgColorIndex]);
			vertexLength = spacing = int(random(50, 200));
			pattern = new RandomPattern(vertexLength);
			patternNum = int(random(1, 14));	
			if (transitionTime%10 == 0) {
				x = spacing * int(random(0, (displayWidth/spacing)));
			}
			else {
				x = 0;
			}		
			y = spacing * int(random(0, (displayHeight/spacing)));
			index = (y/spacing);
			scroll = false;
		}
	}
	if (transitionTime >= 216000 && transitionTime < 221178) {
		//displaying the album art.
		pushMatrix();
		translate(displayWidth/2, displayHeight/2);
		imageMode(CENTER);
		img.resize(imgWidth, imgHeight);
		image(img, 0, 0);
		popMatrix();
		/*if (endingBgResetNeeded == true) {
			p = get(0, 0, displayWidth, displayHeight);
			endingBgResetNeeded = false;
		}
		set(0, 0, p);				
		if (imgWidth > 0 && imgHeight > 0) {
			pushMatrix();
			translate(displayWidth/2, displayHeight/2);
			imageMode(CENTER);
			img.resize(imgWidth, imgHeight);
			image(img, 0, 0);
			imgWidth = imgWidth - 5;
			imgHeight = imgHeight - 5;
			popMatrix();
		}
		else {
			set(0, 0, p);
		}*/
	}
	if (transitionTime >= 221178) {
		//exit();
		song.rewind();
		song.loop();
	}
	//println(frameRate);
	//saveFrame("output/tenPrint#####.tif");
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
