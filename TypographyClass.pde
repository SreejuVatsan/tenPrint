import geomerative.*;

class TypographyClass{

	String myText[] = {"what?", "Huh?", "whAt?", "woO", "go Phsycho", "Woo", "what?", "huH?", "So what?!", "so what?", "So What?", "So what?!", "so what?", "Grow up!!"};
	int myTextSize[] = {200 ,200 ,200 ,200 ,120 ,200 ,200 ,200 ,100 ,100 ,130 ,110 ,120 ,100};

	RFont font[] = new RFont[myText.length];
	//COULD USE A NOISE FUNCTION HERE FOR WIGGLE.
	float wiggle = 3.7;

	TypographyClass (PApplet pa){
		smooth();
		RG.init(pa);
		for (int i = 0; i < myTextSize.length; ++i) {
			font[i] = new RFont("FreeSans.ttf", myTextSize[i], CENTER);
		}		
	}

	void typographyDraw(int number){
		translate(width/2, height/2);
		RCommand.setSegmentLength(10);
		RCommand.setSegmentator(RCommand.UNIFORMLENGTH);

		RGroup myGoup = font[number].toGroup(myText[number]); 
		RPoint[] myPoints = myGoup.getPoints();

		beginShape(TRIANGLE_STRIP);
		for (int i=0; i<myPoints.length; i++) {
			myPoints[i].x += random(-wiggle, wiggle);
			myPoints[i].y += random(-wiggle, wiggle);
			vertex(myPoints[i].x, myPoints[i].y);
		}
		endShape();
	}
}