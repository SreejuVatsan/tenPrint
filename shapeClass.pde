/**
 * Creates Truchet tiles as PShape of varying vertex lenght passed as an argument when an object is created. 
 */
class ShapeClass{
	PShape s1, s2,s3, s4;

	ShapeClass(int vertexLength){
		// Creating a custom PShape as a triangle, by
  		// specifying a series of vertices.
  		s1 = createShape();
  		s1.beginShape();
  		s1.fill(40);// 76.5% Black
  		s1.noStroke();
  		s1.vertex(0, 0);
  		s1.vertex(0, vertexLength);
  		s1.vertex(vertexLength, vertexLength);
  		s1.endShape(CLOSE);
  		
  		s2 = createShape();
  		s2.beginShape();
  		s2.fill(80);// 68.6% Black
  		s2.noStroke();
  		s2.vertex(vertexLength, 0);  
  		s2.vertex(vertexLength, vertexLength);
  		s2.vertex(0, vertexLength);
  		s2.endShape(CLOSE);		
		
		  s3 = createShape();
  		s3.beginShape();
  		s3.fill(120);// 52.9% Black 
  		s3.noStroke();
  		s3.vertex(0, 0);
  		s3.vertex(vertexLength, 0);
  		s3.vertex(vertexLength, vertexLength);  	
  		s3.endShape(CLOSE);

  		s4 = createShape();
  		s4.beginShape();
  		s4.fill(160);// 37.25% Black
  		s4.noStroke();
  		s4.vertex(0, 0);  
  		s4.vertex(vertexLength, 0);
  		s4.vertex(0, vertexLength);
  		s4.endShape(CLOSE);	
	}

  //Shape is retrived using a selector.
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