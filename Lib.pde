/*
 Project: 3D Dandelion in Processing.
 Author: Ruhail Mir
 Date: July 1, 2021
 Connect:
   Twitter: https://www.twitter.com/ImRuhailMir
   Instagram: https://www.instagram.com/ruhailmir
 */

// Names of the images, you want to use, in order.
String[] names = {"st.jpg", "d.jpg", "o.jpg", "p.jpg", "e.jpg", "dot.jpg" };

// Get PVectors of all images.
ArrayList<ArrayList<PVector>> getAllVecs () {
  ArrayList<ArrayList<PVector>> imageVecs = new ArrayList();
  for ( int i=0; i<names.length; i++ ) {
    PImage img = loadImage( names[i] );
    ArrayList<PVector> points = toVectors( img );
    imageVecs.add( points );
  }
  return imageVecs;
}

// Convert each pixel of a single Image to a PVector.
ArrayList<PVector> toVectors (PImage image) {
  int w = image.width;
  int h = image.height;
  ArrayList<PVector> points = new ArrayList();

  for ( int i=0; i < w; i++ ) {
    for ( int j=0; j < h; j++ ) {
      color c = image.get(i, j);
      if ( red(c) <= thresh && green(c) <= thresh && green (c) <= thresh ) {
        points.add(new PVector( i, j, random(255)));
      }
    }
  }

  return points;
}
