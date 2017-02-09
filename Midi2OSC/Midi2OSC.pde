import netP5.*;
import oscP5.*;
import themidibus.*;

OscP5 oscP5;
NetAddress remoteLocation;

MidiBus midiBus;
int state = 0;
String[] inputDevices;
String[] outputDevices;

float textSize = 24;
Panel panel;

int inputDevice;
int outputDevice;
PVector buttonSize;

int channel;
int number;
int value;

int noteOnChannel;
int noteOnPitch;
int noteOnVelocity;

int noteOffChannel;
int noteOffPitch;
int noteOffVelocity;

void setup() {
  size(400, 400);
  inputDevices = MidiBus.availableInputs();
  outputDevices = MidiBus.availableOutputs();
  oscP5 = new OscP5(this,12000);
  remoteLocation = new NetAddress("127.0.0.1",13000);
  buttonSize = new PVector(width, 40);
  panel = new Panel("select input device.");
  for (int i = 0; i < inputDevices.length; i++) {
    Button button = new Button(0, buttonSize.y*(i+1), buttonSize.x, buttonSize.y, inputDevices[i], i);
    panel.add(button);
  }

  textAlign(LEFT, CENTER);
}

void draw() {
  background(0);
  //hover
  if (state < 2) {
    {
      int index = panel.checkIsHoverButton(mouseX, mouseY);
      if (index >= 0) {
        panel.setButtonColor(index, color(0, 127, 255));
      }
    }
    panel.draw();
  }else{
    fill(255);
    text("----------controller----------",10,(buttonSize.y/2)*1);
    text("channel : "+channel,10,(buttonSize.y/2)*2);
    text("number : "+number,10,(buttonSize.y/2)*3);
    text("value : "+value,10,(buttonSize.y/2)*4);
    
    text("----------noteOn----------",10,(buttonSize.y/2)*5);
    text("channel : "+noteOnChannel,10,(buttonSize.y/2)*6);
    text("pitch : "+noteOnPitch,10,(buttonSize.y/2)*7);
    text("velocity : "+noteOnVelocity,10,(buttonSize.y/2)*8);
    
    text("----------noteOff----------",10,(buttonSize.y/2)*9);
    text("channel : "+noteOffChannel,10,(buttonSize.y/2)*10);
    text("pitch : "+noteOffPitch,10,(buttonSize.y/2)*11);
    text("velocity : "+noteOffVelocity,10,(buttonSize.y/2)*12);
  }
  //press

  
}
void noteOn(int channel, int pitch, int velocity) {
  this.noteOnChannel = channel;
  this.noteOnPitch = pitch;
  this.noteOnVelocity = velocity;
  
  OscMessage msg = new OscMessage("/noteOff");
  msg.add(channel);
  msg.add(pitch);
  msg.add(velocity);
  oscP5.send(msg,remoteLocation);
}

//ノートオフが来たときに起きる関数
void noteOff(int channel, int pitch, int velocity) {
  this.noteOffChannel = channel;
  this.noteOffPitch = pitch;
  this.noteOffVelocity = velocity;
  OscMessage msg = new OscMessage("/noteOff");
  msg.add(channel);
  msg.add(pitch);
  msg.add(velocity);
  oscP5.send(msg,remoteLocation);
}

void controllerChange(int channel, int number, int value) {
  this.channel = channel;
  this.number = number;
  this.value = value;
  
  OscMessage msg = new OscMessage("/controllerChange");
  msg.add(channel);
  msg.add(number);
  msg.add(value);
  oscP5.send(msg,remoteLocation);
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  println(e);
}

void mousePressed() {
  if (mouseButton == LEFT) {
    int index = panel.checkIsPressedButton(mouseX, mouseY);
    if (index >= 0) {
      switch(state) {
      case 0:
        inputDevice = index;
        panel = new Panel("select output device.");
        for (int i = 0; i < outputDevices.length; i++) {
          Button button = new Button(0, buttonSize.y*(i+1), buttonSize.x, buttonSize.y, outputDevices[i], i);
          panel.add(button);
          state = 1;
        }
        break;

      case 1:
        outputDevice = index;
        midiBus = new MidiBus(this, inputDevice,outputDevice);
        state = 2;
        break;

      default:

        break;
      }
    } else if (mouseButton == RIGHT) {
      
      
    }
  }
}