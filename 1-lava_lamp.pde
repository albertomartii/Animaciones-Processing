ArrayList<Ball> balls;

int resolution = 3; // más bajo = más suave (más caro)
float threshold = 1.2;

void setup() {
  size(1900, 1200);
  noStroke();

  colorMode(HSB, 360, 100, 100, 100);

  balls = new ArrayList<Ball>();

  for (int i = 0; i < 8; i++) {
    balls.add(new Ball(random(width), random(height)));
  }
}

void draw() {
  background(230, 60, 10);

  // mover bolas
  for (Ball b : balls) {
    b.update();
  }

  // campo metaball suave
  for (int x = 0; x < width; x += resolution) {
    for (int y = 0; y < height; y += resolution) {

      float sum = 0;

      for (Ball b : balls) {
        float dx = x - b.pos.x;
        float dy = y - b.pos.y;
        float d = sqrt(dx*dx + dy*dy);

        sum += b.r / max(d, 1);
      }

      float alpha = map(sum, 0.5, 2.5, 0, 120);
      alpha = constrain(alpha, 0, 120);

      if (alpha > 0) {
        fill(190, 80, 100, alpha);
        rect(x, y, resolution, resolution);
      }
    }
  }

}

// ---------------- BALL ----------------

class Ball {
  PVector pos;
  PVector vel;
  float r;

  Ball(float x, float y) {
    pos = new PVector(x, y);
    vel = PVector.random2D().mult(2);
    r = random(80, 140);
  }

  void update() {
    pos.add(vel);

    if (pos.x < 0 || pos.x > width) vel.x *= -1;
    if (pos.y < 0 || pos.y > height) vel.y *= -1;
  }

  void show() {
    noFill();
    stroke(0, 0, 100, 80);
    strokeWeight(2);
    circle(pos.x, pos.y, r * 2);
  }
}
