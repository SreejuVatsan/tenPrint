//import org.apache.batik.svggen.*;
import geomerative.*;
import processing.core.*;
import processing.data.*;

class TypographyClass{

	String keyWords[] = new String[15];
	String fontNames[] = {"Amatic-Bold.ttf", "AndikaNewBasic-BI.ttf", "banksb20.ttf", "BEARPAW_.ttf", "FingerPaint-Regular.ttf", "FreeSans.ttf", "GONGN___.ttf", "JINKY.ttf", "seguisym.ttf"};
	FontAgent[] myAgents;
	RGroup heartGroup;

	RShape shp;
	RFont font[] = new RFont[keyWords.length];
	float wiggle = 3.7;

	TypographyClass (PApplet pa){
		smooth();
		RG.init(pa);

		shp = RG.loadShape("broken_heart.svg");
  		shp = RG.centerIn(shp, g);

		keyWords = loadStrings("typographyData.csv");
		for (int i = 0; i < keyWords.length; i++) {
			if (i == 12) {
				font[i] = new RFont(fontNames[fontNames.length-1], int(split(keyWords[i], ",")[1]), CENTER);
			}
			else {
				font[i] = new RFont(fontNames[int(random(0, fontNames.length))], int(split(keyWords[i], ",")[1]), CENTER);
			}			
			
		}
	}

	void typographyDraw(int number, int genNum){
		translate(width/2, height/2);
		RGroup myGroup = font[(number == 12) ? number : ((number*genNum % 9) == 0 ? int(random(0, number)) : number)].toGroup((number == 12) ? (new String(Character.toChars(unhex(split(keyWords[number], ",")[0])))) : (split(keyWords[number], ",")[0]));
		RPoint[] myPoints;
		if (genNum == 1) {
			myGroup = myGroup.toPolygonGroup();
			myPoints = myGroup.getPoints();
		}
		else {
			myPoints = myGroup.getPoints();
		}
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
