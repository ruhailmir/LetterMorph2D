/*
 Project: 3D Dandelion in Processing.
 Author: Ruhail Mir
 Date: July 1, 2021
 Connect:
   Twitter: https://www.twitter.com/ImRuhailMir
   Instagram: https://www.instagram.com/ruhailmir
 */

import java.util.*;

int idx = 0;
// threshold, whether to get that pixel or not.
int thresh = 7;
// for starting the animation on mouse click.
boolean start = false;
ArrayList<ArrayList<PVector>> imageVec;

void setup() {
  size(400, 400);
  // fullScreen();
  colorMode(HSB);
  // get pixel vectors of all images.
  imageVec = getAllVecs();
}

void mousePressed() {
  start = true;
}

void draw() {
  background(51);
  translate(-10, -10);

  if ( start ) {
    ArrayList<Particle> result = new ArrayList();
    // Converting all the pixel vectors to Particle objects
    // so that we can apply physics we defined in the Particle class.
    if ( imageVec.size() > 0 ) {
      ArrayList<PVector> al = imageVec.get( idx );
      ArrayList<PVector> bl = imageVec.get( idx + 1);

      // get the minimum of the two consecutive pixel vecters.
      // make sure we iterate at the min of the two
      // so that we don't get any IndexOutOfBounds errors.
      // this is the reason why we may have less pixels in
      // one image than other, because all images have different
      // no of pixels, for instance: the Letter "A" has more pixels
      // than the letter "I".
      // So theres a possibility that there are some missing points.
      // Add your logic, to add some missing points if there are some.
      // --------------- I haven't added it ----------------------------

      // get min pixels of the two pixel vectors.
      int min = al.size() < bl.size() ? al.size() : bl.size();

      // Apply some physics, i.e
      // the particle of second pixel vector at some index 'x' is
      // accelerated towards the position of the first pixel vector at the
      // same index 'x'

      for ( int j = 0; j < min; j++ ) {
        PVector a = al.get( j );
        PVector b = bl.get( j );
        PVector dir = PVector.sub( b, a ).normalize().mult(1);
        a .add ( dir );
        result.add( new Particle ( a.x, a.y, a.z, -1 ) );
      }
    }

    // increment the index variable 'idx' to get the transition of
    // next pair of images after 350 frames.
    // change the value :
    // smaller value -> fast transition.
    // higher value -> slower transition.

    if ( frameCount % 350 == 0 ) {
      if ( idx < imageVec.size() - 2 ) {
        idx++;
      } else {
        imageVec = getAllVecs();
        idx = 0;
      }
    }

    // finally,
    // show and update the particle
    for ( Particle p : result ) {
      Particle scaled = multPart( p, 3 );
      scaled.update();
      scaled.show();
    }
  } else {
    // show a text message.
    stroke(255, 150);
    textSize(20);
    text("Click Me", width/2 - (30), height/2);
  }
}
