
import android.content.res.AssetManager;

PImage[] images;

int nimages;
int leftMostImage=0;

void setup(){
  orientation(LANDSCAPE);  
  String [] fileNames;
  fileNames = new String[2];
 
  AssetManager am = getAssets();
  try {
    fileNames = am.list("");
    nimages=fileNames.length;
    images =  new PImage[nimages];
  }
  catch (IOException e) {
    System.out.println("Error: Android asset not found");
    return;
  }
  for(int i=0;i<fileNames.length;i++) {
    if (fileNames.length >= 1 && fileNames[i].endsWith(".png")) {
      images[i] = loadImage(fileNames[i]);
      images[i].loadPixels();
    }
  }
}

void draw(){
  int squareLength=displayWidth/5;
  int pos;
  float newY=displayHeight/2-squareLength/2;
  
  for(int i=0;i<5;i++){
    pos=i+leftMostImage;
    
    if(i+leftMostImage<=nimages){
      image(images[pos],i*squareLength,newY,squareLength,squareLength);
    }
    else {
      pos=0;
      image(images[pos],i*squareLength,newY,squareLength,squareLength);
    }
  }
  

  

  
}
void mouseReleased()
{
  if (mouseX>displayWidth/2){
    leftMostImage++;
  }
  else if (mouseX<displayWidth/2){
    leftMostImage--;
  }
} 
