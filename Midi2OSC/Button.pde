class Button{
 float x,y,w,h;
 int index;
 String label;
 color col;
 Button(float x, float y, float w, float h, String label,int index){
   this.x = x;
   this.y = y;
   this.w = w;
   this.h = h;
   this.label = label;
   this.index = index;
   col = color(127);
 }
 
 void draw(){
   stroke(0);
   fill(col);
   rect(x,y,w,h);
   fill(0);
   text(this.label,x + 10,y + h/2);
   col = color(127);
 }
 
 void setColor(color col){
   this.col = col;
 }
 
 boolean isPressed(float x, float y){
   boolean isPress = false;
   if(x > this.x && x < this.x + this.w){
     if(y > this.y && y < this.y + this.h){
       isPress = true;
     }
   }
   return isPress;
 }
 
 boolean isHover(float x, float y){
   boolean isHover = false;
   if(x > this.x && x < this.x + this.w){
     if(y > this.y && y < this.y + this.h){
       isHover = true;
     }
   }
   return isHover;
 }
}