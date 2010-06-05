#define KEYDELAY 200
#define KEYREPEAT 85

// Pins the buttons are connected to
int buttons[7] = {
  4, 5, 13, 15, //Joystick
  0, 1, 2 //Buttons
};

// Keys to send
int keyCodes[7] = {
  KEY_DOWN, KEY_RIGHT, KEY_UP, KEY_LEFT, //Joytick
  KEY_D, KEY_X, KEY_Z //Buttons
};

int keySends[7] = {
  1, 2, 1, 2, // Joysticks on separate so you can do vertical and horizontal at the same time
  3, 4, 5 // Buttons on there own so they can be better :P
};

int oldState[7];

static int currentKey[6] = {0, 0, 0, 0, 0, 0};

void setSendKey(byte keyNum, int keyCode){
  switch(keyNum){
    case 1: Keyboard.set_key1(keyCode); break;
    case 2: Keyboard.set_key2(keyCode); break;
    case 3: Keyboard.set_key3(keyCode); break;
    case 4: Keyboard.set_key4(keyCode); break;
    case 5: Keyboard.set_key5(keyCode); break;
    case 6: Keyboard.set_key6(keyCode); break;
  }
}

void processKeys(){
  for (byte i = 0; i < 7;i++){
    
}

void setup()   {                
  // initialize the digital pin as an output:
  for(byte i=0;i<7;i++){
    pinMode(buttons[i], INPUT_PULLUP);
    oldState[i] = !digitalRead(buttons[i]);
  }
}

void loop() {
  byte nothingPressed[6] = {1, 1, 1, 1, 1, 1};
  
  //static int repeatKey[6] = {0, 0, 0, 0, 0, 0};

  for (byte i = 0; i < 7; i++) {
    
    // are any of them pressed?
    if (! digitalRead(buttons[i])) {
      nothingPressed[i] = 0; // at least one button is pressed!
      
      // if its a new button, release the old one, and press the new one
      if (currentKey[keySends[i]] != keyCodes[i]) {
        setSendKey(keySends[i], 0);
        setSendKey(keySends[i],keyCodes[i]);
        currentKey[keySends[i]] = keyCodes[i];
        //repeatKey[keySends[i]] = 0;
      } 
    }
  }
  
  // release all keys
  for(byte i = 0; i < 6; i++){
    if (nothingPressed[i]){
      setSendKey(i, 0);
      //repeatKey[i] = 0;
      currentKey[i] = 0;
    }
  }
  //delay(1);
}

