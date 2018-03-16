class RandomPattern{
	ShapeClass shapeObj;
	int shapeSelect;
	//int xS, yS;
	int pattern8[] = {4,3,1,2};
	int patterArrayIndex = 0;

	RandomPattern(int vertexLength){
		shapeObj = new ShapeClass(vertexLength);
		shapeSelect = 0;
	}

	void setPattern(int x, int y, int patternSelector, int index){
		if (patternSelector == 1) {
			shape(shapeObj.getShape(int(random(1,5))), x, y);
		}
		else if (patternSelector == 2) {//similar to pattern 9
			shape(shapeObj.getShape((shapeSelect >= 4) ? shapeSelect=1 : ++shapeSelect), x, y);			
		}
		else if (patternSelector == 3) {
			//pattern created by alternating between shapes 3 and 4
			shape(shapeObj.getShape((shapeSelect != 3) ? shapeSelect=3 : ++shapeSelect), x, y);
		}
		else if (patternSelector == 4) {
			if (index % 2 == 0) {
				if(shapeSelect != 4){
					shapeSelect = 1;          			
					shape(shapeObj.getShape(shapeSelect), x, y);
					shapeSelect=4;
				}
				else if(shapeSelect == 4) {          			
					shape(shapeObj.getShape(shapeSelect), x, y);
					shapeSelect=1;
				}				
			}
			else {				
				shape(shapeObj.getShape((shapeSelect != 2) ? shapeSelect=2 : ++shapeSelect), x, y);
			}
		}
		else if (patternSelector == 5) {
			if (index % 2 == 0) {
				shape(shapeObj.getShape(1), x, y);
			}
			else{
				shape(shapeObj.getShape(3), x, y);
			}
		}
		else if (patternSelector == 6) {
			if (index % 2 == 0) {
				if(shapeSelect != 3){
					shapeSelect = 1;          			
					shape(shapeObj.getShape(shapeSelect), x, y);
					shapeSelect=3;
				}
				else if(shapeSelect == 3) {          			
					shape(shapeObj.getShape(shapeSelect), x, y);
					shapeSelect=1;
				}
			}
			else{
				if(shapeSelect != 1){
					shapeSelect = 3;          			
					shape(shapeObj.getShape(shapeSelect), x, y);
					shapeSelect=1;
				}
				else if(shapeSelect == 1) {          			
					shape(shapeObj.getShape(shapeSelect), x, y);
					shapeSelect=3;
				}
			}
		}
		else if (patternSelector == 7) {
			shape(shapeObj.getShape(pattern8[(patterArrayIndex >= (pattern8.length-1)) ? patterArrayIndex=0 : ++patterArrayIndex]), x, y);
		}
		else if (patternSelector == 8) {
			if (index % 2 == 0) {
				//pattern created by alternating between shapes 3 and 4
				shape(shapeObj.getShape((shapeSelect != 3) ? shapeSelect=3 : ++shapeSelect), x, y);
			}
			else {
				//alternating between shapes 1 and 2
				shape(shapeObj.getShape((shapeSelect != 1) ? shapeSelect=1 : ++shapeSelect), x, y);
			}
		}
		else if (patternSelector == 9) {
			//similar to pattern 2 but patterns are in reverse order
			shape(shapeObj.getShape((shapeSelect <= 0) ? shapeSelect=3 : --shapeSelect), x, y);
		}
		else if (patternSelector == 10) {
			if (index % 2 == 0) {
				//alternating between shapes 3 and 4
				shape(shapeObj.getShape((shapeSelect != 3) ? shapeSelect=3 : ++shapeSelect), x, y);
			}
			else {
				//alternating between shapes 2 and 1
				shape(shapeObj.getShape((shapeSelect != 2) ? shapeSelect=2 : --shapeSelect), x, y);
			}
		}
		else if (patternSelector == 11) {
			shape(shapeObj.getShape(1), x, y);
		}
		else if (patternSelector == 12) {
			shape(shapeObj.getShape(2), x, y);
		}
		else if (patternSelector == 13) {
			shape(shapeObj.getShape(3), x, y);
		}
		else if (patternSelector == 14) {
			shape(shapeObj.getShape(4), x, y);
		}
	}

}