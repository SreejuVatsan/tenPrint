/**
 * Class for generative typography using Geomerative library by Ricard Marxer. 
 * http://www.ricardmarxer.com/geomerative/
 * 
 * Code examples TypoGeo_Wiggle, Geo_Font_02_b, and TypoGeo_Motion_02 from Mark Webster's Geomerative Tutorial. Part 1. have been adapeted to the asthetic needs of the visualizer
 * http://freeartbureau.org/fab_activity/geomerative-tutorial-part-1
 * 
 */
import geomerative.*;

class TypographyClass{

	//keywords of the lyrics and font names are loaded as an array of Strings.
	String keyWords[] = new String[15];
	String fontNames[] = {"Amatic-Bold.ttf", "AndikaNewBasic-BI.ttf", "banksb20.ttf", "BEARPAW_.ttf", "FingerPaint-Regular.ttf", "FreeSans.ttf", "GONGN___.ttf", "JINKY.ttf", "seguisym.ttf"};
	FontAgent[] myAgents;

	RFont font[] = new RFont[keyWords.length];
	float wiggle = 3.7;

	//Constructor for TypographyClass which initializes the Geomerative library.
	TypographyClass (PApplet pa){
		smooth();
		RG.init(pa);
		keyWords = loadStrings("typographyData.csv");
		for (int i = 0; i < keyWords.length; i++) {
			if (i == 12) {
				//loading unicode font seguisym.ttf for displaying U+2764 (❤) for the 12th keyword.
				font[i] = new RFont(fontNames[fontNames.length-1], int(split(keyWords[i], ",")[1]), CENTER);
			}
			else {
				//otherwise, randomly load any of the available fonts. 
				font[i] = new RFont(fontNames[int(random(0, fontNames.length))], int(split(keyWords[i], ",")[1]), CENTER);
			}
		}
	}

	void typographyDraw(int keyWordNumber, int genNum){
		translate(width/2, height/2);
		//if keyWordNumber=12, the logic specifically selects the element of index 12 from RFont[], group the Shapes obtained from the String after converting the hex value 2764 (which is stored as the keyword) into decimal.
		//otherwise an RFont is randomly selected from the array.
		RGroup myGroup = font[(keyWordNumber == 12) ? keyWordNumber : ((keyWordNumber*genNum % 9) == 0 ? int(random(0, keyWordNumber)) : keyWordNumber)].toGroup((keyWordNumber == 12) ? (new String(Character.toChars(unhex(split(keyWords[keyWordNumber], ",")[0])))) : (split(keyWords[keyWordNumber], ",")[0]));
		RPoint[] myPoints;
		if (genNum == 1) {
			myGroup = myGroup.toPolygonGroup();
			myPoints = myGroup.getPoints();
		}
		else {
			myPoints = myGroup.getPoints();
		}
		//TypoGeo_Wiggle - vertices are drawn using x and y coordinates plus a radom number between -wiggle and wiggle.
		if (genNum == 0) {
			RCommand.setSegmentLength(10);
			RCommand.setSegmentator(RCommand.UNIFORMLENGTH);

			beginShape(TRIANGLE_STRIP);
			for (int i=0; i<myPoints.length; i++) {
				myPoints[i].x += random(-wiggle, wiggle);
				myPoints[i].y += random(-wiggle, wiggle);
				vertex(myPoints[i].x, myPoints[i].y);
			}
			endShape();
		}
		//Geo_Font_02_b - curves drawn using x and y coordinates with SegmentLength randomly varying between 0-30.
		else if (genNum == 1) {
			RCommand.setSegmentLength(int(random(0, 30)));
			RCommand.setSegmentator(RCommand.UNIFORMLENGTH);

			beginShape();
			for(int i=0; i<myPoints.length; i++){
				//vertex(myPoints[i].x, myPoints[i].y); 
				curveVertex(myPoints[i].x, myPoints[i].y);
			}
			endShape();
		}
		//TypoGeo_Motion_02 - parameters like stroke weight, length of lines and rotation angle for the pvector have been randomized accordingly.
		else if (genNum == 2) {
			myAgents = new FontAgent[myPoints.length];
			for (int i=0; i<myPoints.length; i++) {
				myAgents[i] = new FontAgent(new PVector(myPoints[i].x, myPoints[i].y));
			}
			for (int i = 0; i < myPoints.length; i++) {
				myAgents[i].display();
			}
		}
	}
}
