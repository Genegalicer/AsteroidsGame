//your variable declarations here
public boolean touch = false;
public int bulletCount = 0;
public boolean left =true;
SpaceShip Gship = new SpaceShip();
Star[] galaxy = new Star[500];
ArrayList <Asteroid> field = new ArrayList <Asteroid>();
ArrayList <Bullet> destroy = new ArrayList <Bullet>();
boolean wIsPressed, aIsPressed, dIsPressed, sIsPressed, spaceIsPressed;
;
public void setup() 
{
  size(700, 700);
  for (int i = 0; i<galaxy.length; i++)
  {
    galaxy[i] = new Star();
  }
  for (int i = 0; i<=15; i++)
  {
    field.add(i, new Asteroid());
  }
}
public void draw() 
{
  background(0);
  if (spaceIsPressed == true && bulletCount <100)
  {
    destroy.add(new Bullet(Gship));
    bulletCount++;
  }
  for (int i = 0; i<destroy.size(); i++) 
  {
    destroy.get(i).show();
    destroy.get(i).move();
    if (((destroy.get(i).getX()) > 700) || ((destroy.get(i).getX() < 0))) {
      destroy.remove(i);
      bulletCount--;
    } else if (((destroy.get(i).getY()) > 700) || ((destroy.get(i).getY() < 0))) {
      destroy.remove(i);
      bulletCount--;
    }
  }
  for (int i = 0; i<galaxy.length; i++)
  {
    galaxy[i].show();
  }
  for (int i = 0; i<field.size(); i++)
  {
    field.get(i).show();
    field.get(i).move();
    field.get(i).isTouchingShip(); 
    if (touch == true)
    {
      field.remove(i);
      touch = false;
      break;
    }
    for (int z = 0; z<destroy.size(); z++)
    {
      //checking to see if the bullets are touching the asteroids
      if ((dist((float)field.get(i).getX(), (float)field.get(i).getY(), (float)destroy.get(z).getX(), (float)destroy.get(z).getY())) < 5)
      { 
        field.remove(i);
        destroy.remove(z);
        bulletCount--;
        break;
      }
    }
  }
  Gship.show();
  if (wIsPressed == true) {
    Gship.accelerate(.2);
  }
  if (aIsPressed == true) {
    Gship.rotate(-6);
  }
  if (dIsPressed == true) {
    Gship.rotate(6);
  }
  if (sIsPressed == true) {
    Gship.accelerate(-.2);
  }
  Gship.move();
}
public void keyPressed()
{
  if (key == ' ') {
    spaceIsPressed = true;
  }
  if (key == 'w') {
    wIsPressed = true;
  }//go forward
  if (key == 'a') {
    aIsPressed = true;
  }//turn left
  if (key == 'd') {
    dIsPressed = true;
  }//turn right
  if (key == 's') {
    sIsPressed = true;
  }//go backwards
  if (key == 'q')//"hyperspace"
  {
    Gship.setDirectionX(0);
    Gship.setDirectionY(0);
    Gship.setX((int)(Math.random()*700));
    Gship.setY((int)(Math.random()*700));
  }
}
public void keyReleased()
{
  if (key == ' ') {
    spaceIsPressed = false;
  }
  if (key == 'w') {
    wIsPressed = false;
  }//go forward
  if (key == 'a') {
    aIsPressed = false;
  }//turn left
  if (key == 'd') {
    dIsPressed = false;
  }//turn right
  if (key == 's') {
    sIsPressed = false;
  }
}
class Bullet extends Floater
{
  public Bullet(SpaceShip gene)
  {
    myCenterX = gene.myCenterX;
    myPointDirection = gene.myPointDirection;
    double dRadians = myPointDirection*(Math.PI/180);

    myCenterY = gene.myCenterY;
    myDirectionX = 5*Math.cos(dRadians)+gene.myDirectionX;
    myDirectionY = 5*Math.sin(dRadians)+gene.myDirectionY;
  }
  public void move()
  {    
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;
  }
  public void show()
  {
    noFill();
    stroke(130);
    ellipse((float)myCenterX, (float)myCenterY, (float)5, (float)5);
  }
  public void setX(int x) {
    myCenterX = x;
  }
  public int getX() {
    return (int)myCenterX;
  }
  public void setY(int y) {
    myCenterY = y;
  }  
  public int getY() {
    return (int)myCenterY;
  }  
  public void setDirectionX(double x) {
    myDirectionX = x;
  }  
  public double getDirectionX() {
    return myDirectionX;
  }  
  public void setDirectionY(double y) {
    myDirectionY = y;
  }  
  public double getDirectionY() {
    return myDirectionY;
  }   
  public void setPointDirection(int degrees) {
    myPointDirection = degrees;
  }   
  public double getPointDirection() {
    return myPointDirection;
  }
}
class SpaceShip extends Floater  
{   
  public SpaceShip()
  {
    int[] xS = {   -25, 25, 0,0,-25};
    int[] yS = {   -25, -10, 0, 0,10};
    corners = xS.length;
    xCorners = xS;
    yCorners = yS;

    myCenterX=350;//starting position
    myCenterY=350;
    myColor=255;
    myDirectionX=0;
    myDirectionY=0;
    myPointDirection=-90;//direction its pointing
  }
  public void setX(int x) {
    myCenterX = x;
  }
  public int getX() {
    return (int)myCenterX;
  }
  public void setY(int y) {
    myCenterY = y;
  }  
  public int getY() {
    return (int)myCenterY;
  }  
  public void setDirectionX(double x) {
    myDirectionX = x;
  }  
  public double getDirectionX() {
    return myDirectionX;
  }  
  public void setDirectionY(double y) {
    myDirectionY = y;
  }  
  public double getDirectionY() {
    return myDirectionY;
  }   
  public void setPointDirection(int degrees) {
    myPointDirection = degrees;
  }   
  public double getPointDirection() {
    return myPointDirection;
  }
}
abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if (myCenterX >width)
    {     
      myCenterX = 0;
    } else if (myCenterX<0)
    {     
      myCenterX = width;
    }    
    if (myCenterY >height)
    {    
      myCenterY = 0;
    } else if (myCenterY < 0)
    {     
      myCenterY = height;
    }
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for (int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated, yRotatedTranslated);
    }   
    endShape(CLOSE);
  }
} 
class Star
{
  private int starX, starY;
  public Star()
  {
    starX = (int)(Math.random()*700);
    starY = (int)(Math.random()*700);
  }
  public void show()
  {
    fill(255);
    noStroke();
    ellipse(starX, starY, 2, 2);
  }
}
class Asteroid extends Floater
{
  private int rotSpeed;
  public Asteroid()
  {
    corners = 6;
    int[] aXs = {(int)25,(int)-25,(int)25,(int)-25,(int)-25,(int)25};
    int[] aYs = {(int)-25,(int)25,(int)-25,(int)25,(int)-25,(int)25};
    xCorners = aXs;
    yCorners = aYs;
    //add in myDirectionX and myDirectionY in order to move
    myDirectionY = ((int)(Math.random()*5)-2);
    myDirectionX = ((int)(Math.random()*5)-2);
    myCenterX = ((int)(Math.random()*700));
    myCenterY = ((int)(Math.random()*700));
    rotSpeed = ((int)(Math.random()*10));
    myColor = 105;
  }
  public void move()
  {
    rotate(rotSpeed);
    super.move();
  }
  public boolean isTouchingShip()
  {
    if ((dist((float)myCenterX, (float)myCenterY, (float)Gship.getX(), (float)Gship.getY())) < 20) {
      return touch = true;
    } else {
      return touch;
    }
  }
  public void setX(int x) {
    myCenterX = x;
  }
  public int getX() {
    return (int)myCenterX;
  }
  public void setY(int y) {
    myCenterY = y;
  }  
  public int getY() {
    return (int)myCenterY;
  }  
  public void setDirectionX(double x) {
    myDirectionX = x;
  }  
  public double getDirectionX() {
    return myDirectionX;
  }  
  public void setDirectionY(double y) {
    myDirectionY = y;
  }  
  public double getDirectionY() {
    return myDirectionY;
  }   
  public void setPointDirection(int degrees) {
    myPointDirection = degrees;
  }   
  public double getPointDirection() {
    return myPointDirection;
  }
}

