class RandomPattern{
	ShapeClass shapeObj;
	int shapeSelect;
	//int xS, yS;

	RandomPattern(int vertexLength){
		shapeObj = new ShapeClass(vertexLength);
		shapeSelect = 0;
	}

	void setPattern(int x, int y, int patternSelector, int index){
		if (patternSelector == 1) {
			shape(shapeObj.getShape(int(random(1,5))), x, y);
		}
		else if (patternSelector == 2) {			
			shape(shapeObj.getShape((shapeSelect >= 4) ? shapeSelect=1 : ++shapeSelect), x, y);			
		}
		else if (patternSelector == 3) {
			//pattern created by alternating between shapes 3 and 4
			shape(shapeObj.getShape((shapeSelect != 3) ? shapeSelect=3 : ++shapeSelect), x, y);
		}
		else if (patternSelector == 4) { //<>//
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
			shape(shapeObj.getShape(1), x, y);
		}
		else if (patternSelector == 6) {
			shape(shapeObj.getShape(2), x, y);
		}
		else if (patternSelector == 7) {
			shape(shapeObj.getShape(3), x, y);
		}
		else if (patternSelector == 8) {
			shape(shapeObj.getShape(4), x, y);
		}
	}

}