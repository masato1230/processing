PImage img;

void setup() {
  size(1200, 800, P3D);
  img = loadImage("vitpilen.jpeg");
  img.resize(1200, 800);
}

void draw() {
  background(#18181c);
  noStroke();
  sphereDetail(3);
  
  float tiles = 10000;
  float tileSize = width / tiles;
  
  push();
  
  for (int x = 0; x < tiles; x++) {
    for (int y = 0; y < tiles; y++) {
      color tileColor = img.get(int(x * tileSize), int(y * tileSize));
      // float brightness = map(brightness(tileColor), 0, 255, 0, 1);
			int brightness = int(brightness(tileColor));
			// dismiss white
			if (brightness > 240) {
				continue;
			}

      // float z = map(brightness, 0, 1, 100, -100);
			int brightnessLevel = sepalateBrightnessToFiveLebel(brightness);
			float z = 0f;
			switch (brightnessLevel) {
				case 1:
					z = -100f;
					break;
				case 2:
					z = -50f;
					break;
				case 3:
					break;
				case 4:
					z = 50f;
					break;
				case 5:
					z = 100f;
			}
      
      push();
      fill(tileColor);
      translate(width / 2, height / 2);
      // rotateY(radians(frameCount * 5));
			rotateX(radians(20));
			rotateY(radians(20));
      translate(x * tileSize - width / 2, y * tileSize - height / 2, z);
			sphere(tileSize);
      pop();
    }
  }
  
  
  pop();
}

void mousePressed() {
  save("output.jpeg");
	exit();
}

int sepalateBrightnessToFiveLebel(int brightness) {
	if (brightness > 200) {
		return 5;
	} else if (brightness > 150)  {
		return 4;
	} else if (brightness > 100) {
		return 3;
	} else if (brightness > 50) {
		return 2;
	} else {
		return 1;
	}
}
