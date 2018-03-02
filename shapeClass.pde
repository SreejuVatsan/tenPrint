class ShapeClass{
	PShape s1, s2,s3, s4;

	ShapeClass(int vertexLength){
		// Creating a custom PShape as a triangle, by
  		// specifying a series of vertices.
  		s1 = createShape();
  		s1.beginShape();
  		s1.fill(40);
  		s1.noStroke();
  		s1.vertex(0, 0);
  		s1.vertex(0, vertexLength);
  		s1.vertex(vertexLength, vertexLength);
  		s1.endShape(CLOSE);
  		
  		s2 = createShape();
  		s2.beginShape();
  		s2.fill(80);
  		s2.noStroke();
  		s2.vertex(vertexLength, 0);  
  		s2.vertex(vertexLength, vertexLength);
  		s2.vertex(0, vertexLength);
  		s2.endShape(CLOSE);		
		
		s3 = createShape();
  		s3.beginShape();
  		s3.fill(160);
  		s3.noStroke();
  		s3.vertex(0, 0);
  		s3.vertex(vertexLength, 0);
  		s3.vertex(vertexLength, vertexLength);  	
  		s3.endShape(CLOSE);

  		s4 = createShape();
  		s4.beginShape();
  		s4.fill(120);
  		s4.noStroke();
  		s4.vertex(0, 0);  
  		s4.vertex(vertexLength, 0);
  		s4.vertex(0, vertexLength);
  		s4.endShape(CLOSE);	
	}

	PShape getShape(int shapeNum){
		if (shapeNum == 1) {
			return s1;
		}
		else if (shapeNum == 2) {
			return s2;
		}
		else if (shapeNum == 3) {
			return s3;
		}
		else {
			return s4;
		}
	}

}