/*
 Project: 3D Dandelion in Processing.
 Author: Ruhail Mir
 Date: July 1, 2021
 Connect:
   Twitter: https://www.twitter.com/ImRuhailMir
   Instagram: https://www.instagram.com/ruhailmir
 */

// spring constant
float K = 0.0001;

class Particle {
  // Current and previous positions.
  PVector pos;
  PVector prev;

  // Particle size, size or -1 for default.
  float s = -1;
  // color of particle.
  float hue;

  Particle ( float a, float b, float c, float s ) {
    this.pos = new PVector(a, b);
    this.s = s;
    if ( this.prev == null ) {
      this.prev = this.pos.copy();
    }
    this.hue = c;
  }

  void update() {
    // apply spring force if mouse is pressed.
    if ( mousePressed ) {
      PVector dir = PVector.sub(this.pos, new PVector(mouseX, mouseY))
        .normalize()
        .mult( 21 );
      this.pos.add( dir );
    }
    // Spring force, Hooks law.
    float d = dist(this.prev.x, this.prev.y, this.pos.x, this.pos.y);
    PVector ext = PVector.sub(this.pos, this.prev).mult(d);
    ext.mult( -K );
    this.pos.add( ext );
  }

  // Show the particle.
  void show() {
    if ( this.s != -1 ) {
      strokeWeight(this.s);
    } else {
      strokeWeight(4);
    }
    stroke(this.hue, 255, 255, 200);
    point(this.pos.x, this.pos.y);
  }
}

// Helper method for scaler multiplication of two Particle positions.
Particle multPart (Particle p, float f ) {
  return new Particle( p.pos.x * f, p.pos.y * f, p.hue, p.s );
}
