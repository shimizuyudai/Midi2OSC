class Panel {
  ArrayList<Button> buttonList = new ArrayList<Button>();
  String label;
  Panel(String label) {
    this.label = label;
  }
  
  void add(Button button){
    this.buttonList.add(button);
  }
  
  void update(){
    
  }
  
  void draw() {
    fill(64);
    rect(0,0,buttonSize.x,buttonSize.y);
    fill(255);
    text(label,10,buttonSize.y/2);
    for (Button button : buttonList) {
      button.draw();
    }
  }
  
  void setButtonColor(int index,color col){
    for (Button button : buttonList) {
      if(button.index == index){
        button.setColor(col);
        break;
      }
    }
  }
  
  int checkIsPressedButton(float x,float y){
    int index = -1;
    for (Button button : buttonList) {
      if(button.isPressed(x,y)){
        index = button.index;
        break;
      }
    }
    return index;
  }
  
  int checkIsHoverButton(float x,float y){
    int index = -1;
    for (Button button : buttonList) {
      if(button.isHover(x,y)){
        index = button.index;
        break;
      }
    }
    return index;
  }
  
}