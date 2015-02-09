
import android.content.res.AssetManager;

PImage[] images;

PImage backward;
PImage forward;

int nImages;
int nIcons;

int leftMostImage=0;

int mode;
int selectedImage;

void setup(){
  orientation(LANDSCAPE);
  String [] fileNames;
  fileNames = new String[2];
  String [] icons;
  icons = new String[1];
 
  AssetManager am = getAssets();
  // Get images
  try {
    fileNames = am.list("images");
    nImages=fileNames.length;
    images =  new PImage[nImages];
  }
  catch (IOException e) {
    System.out.println("Error: Android asset not found");
    return;
  }
  
  for(int i=0;i<fileNames.length;i++) {
    if (fileNames.length >= 1 && fileNames[i].endsWith(".png")) {
      images[i] = loadImage("images/"+ fileNames[i]);
      images[i].loadPixels();
    }
  }
  // Get icons
  try {
    icons = am.list("icons");
  }
  catch (IOException e) {
    System.out.println("Error: Android asset not found");
    return;
  }
  
  forward = loadImage("images/icons/forward.png");
  backward = loadImage("images/icons/backward.png");
  
  mode = 0 ;
}

void draw(){
  background(180);
  image(backward,0,displayHeight-150,150,150);
  image(forward,displayWidth-150,displayHeight-150,150,150);
  if (mode == 0){
    int squareLength=displayWidth/5;
    int pos;
    float newY=displayHeight/2-squareLength/2;
    
    for(int i=0;i<5;i++){
      pos=i+leftMostImage;
      image(images[pos % nImages],i*squareLength,newY,squareLength,squareLength);
    }
  }
  else if (mode == 1) {
    size(displayWidth, displayHeight);
    
    image(images[selectedImage],displayWidth/2-images[selectedImage].width/2,displayHeight/2-images[selectedImage].height/2);
    images[selectedImage].loadPixels();
  }
}
void mouseReleased()
{
  int squareLength=displayWidth/5;
  if (mode == 0) {
    if (mouseX<150 && mouseY>displayHeight-150){
      leftMostImage--;
    }
    else if (mouseX>displayWidth-150 && mouseY>displayHeight-150){
      leftMostImage++;
    }
    else if (mouseX<squareLength && mouseY>displayHeight/2-squareLength/2 && mouseY<displayHeight/2+squareLength/2) {
      mode = 1;
      selectedImage = leftMostImage;
    }
    else if (mouseX>squareLength && mouseX<squareLength*2 && mouseY>displayHeight/2-squareLength/2 && mouseY<displayHeight/2+squareLength/2) {
      mode = 1;
      selectedImage = leftMostImage + 1;
    }
    else if (mouseX>squareLength*2 && mouseX<squareLength*3 && mouseY>displayHeight/2-squareLength/2 && mouseY<displayHeight/2+squareLength/2) {
      mode = 1;
      selectedImage = leftMostImage + 2;
    }
    else if (mouseX>squareLength*3 && mouseX<squareLength*4 && mouseY>displayHeight/2-squareLength/2 && mouseY<displayHeight/2+squareLength/2) {
      mode = 1;
      selectedImage = leftMostImage + 3;
    }
    else if (mouseX>squareLength*4 && mouseX<squareLength*5 && mouseY>displayHeight/2-squareLength/2 && mouseY<displayHeight/2+squareLength/2) {
      mode = 1;
      selectedImage = leftMostImage + 4;
    }
    
  }
  else if (mode == 1) {
    if (mouseX<150 && mouseY>displayHeight-150){
      selectedImage--;
    }
    else if (mouseX>displayWidth-150 && mouseY>displayHeight-150){
      selectedImage++;
    }
    else if(mouseX>displayWidth/2-images[selectedImage].width/2 && mouseX<displayWidth/2+images[selectedImage].width/2 && 
            mouseY>displayHeight/2-images[selectedImage].height/2 && mouseY<displayHeight/2+images[selectedImage].height/2) {
      mode = 0; 
    }
  }
} 
