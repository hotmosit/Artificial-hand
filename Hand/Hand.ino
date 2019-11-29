#include<Servo.h>
#define Max 270 // Maximum degree
#define Min 1 // Minimum degree
#define Case 2 // Operation case (1~3)

#define commandValue -1 // IF  Positive : All finger controll
                        // __  Negative : None

// Serial Flag (collision)
#define SFlag1 4
#define SFlag2 7
#define SFlag3 8
#define SFlag4 11
#define SFlag5 12

#define F1_power 270 // Thumb's power
#define F2_power 260 // Index's power
#define F3_power 270 // Middle's power
#define F4_power 250 // Ring's power
#define F5_power 250 // pinky's power

int pos = Max; // Degree input
int flag = 1; // Flag for pos

Servo F1, F2, F3, F4, F5; // Finger num 
                            // (F1 : Thumb, F5 : The little) 
int F1F, F2F, F3F, F4F, F5F; // Finger force temp

void SerialReport();

void setup() {
  // put your setup code here, to run once:
  // Finger attach
  F1.attach(10, 544, 544);
  F2.attach(3,544,544);
  F3.attach(5,544,544);
  F4.attach(6,544,544);
  F5.attach(9,544,544);

  Serial.begin(9600); // Serial board rate (bps)

  // Initial set
  F1.write(pos);
  F2.write(pos);
  F3.write(pos);
  F4.write(pos);
  F5.write(pos);

  pinMode(SFlag1, OUTPUT);
  analogWrite(SFlag1, LOW);
  pinMode(SFlag2, OUTPUT);
  analogWrite(SFlag2, LOW);
  pinMode(SFlag3, OUTPUT);
  analogWrite(SFlag3, LOW);
  pinMode(SFlag4, OUTPUT);
  analogWrite(SFlag4, LOW);
  pinMode(SFlag5, OUTPUT);
  analogWrite(SFlag5, LOW);
}

///////////////////////////////////////////////////////////////////////

void loop() {
  // put your main code here, to run repeatedly:

  // Error
  /*
  if(pos < Min){
    printf("Motor Stop [Error]");
    exit(0);
  }*/

  // Run
  if(Case == 1){ // Case 1: Direct Movement
    // Finger move
    if(commandValue >= 0){
      pos = pos - flag;

      F1.write(pos);
      F2.write(pos);
      F3.write(pos);
      F4.write(pos);
      F5.write(pos);
      delay(20);
    }
  
    else{
      pos = pos - flag;
      
      if(pos >= Max-F1_power){
         F1.write(pos);
         F1F = pos;
      }
      else{
          F1.write(Max-F1_power);
      }  
      if(pos >= Max-F2_power){
         F2.write(pos);
         F2F = pos;
      }
      else{
          F2.write(Max-F2_power);
      }
      if(pos >= Max-F3_power){
         F3.write(pos);
         F3F = pos;
      }
      else{
         F3.write(Max-F3_power);
      }   
      if(pos >= Max-F4_power){
         F4.write(pos);
         F4F = pos;
      }
      else{
         F4.write(Max-F4_power);
      }   
      if(pos >= Max-F5_power){
         F5.write(pos);
         F5F = pos;
      }
      else{
         F5.write(Max-F5_power);
      }   
      delay(10);
    }

    // Serial report
  }

  else if(Case == 2){ // Case 2: Serial Report
    // Finger move
    if(commandValue >= 0){
      pos = pos - flag;

      F1.write(pos);
      F2.write(pos);
      F3.write(pos);
      F4.write(pos);
      F5.write(pos);
      delay(20);
    }
  
    else{
      pos = pos - flag;

      if(pos >= Max-F1_power){
         F1.write(pos);
         F1F = pos;
      }
      else{
          F1.write(Max-F1_power);
      }
      if(pos >= Max-F2_power){
         F2.write(pos);
         F2F = pos;
      }
      else{
          F2.write(Max-F2_power);
      }
      if(pos >= Max-F3_power){
         F3.write(pos);
         F3F = pos;
      }
      else{
         F3.write(Max-F3_power);
      }   
      if(pos >= Max-F4_power){
         F4.write(pos);
         F4F = pos;
      }
      else{
         F4.write(Max-F4_power);
      }   
      if(pos >= Max-F5_power){
         F5.write(pos);
         F5F = pos;
      }
      else{
         F5.write(Max-F5_power);
      }   
      delay(10);
    }
    
    // Serial report
    SerialReport2(F1.read(), F2.read(), F3.read(), F4.read(), F5.read());
    delay(10);
  }
  
  else if(Case == 3){ // Case 3: Serial Import
    char temp[2];
    if(Serial.available()){
      byte leng = Serial.readBytes(temp,2);
    }

    if(temp[0] == 'c'){
      if(temp[1] == '5'){
        digitalWrite(SFlag1, HIGH);
      }
      else if(temp[1] == '4'){
        digitalWrite(SFlag2, HIGH);
      }
      else if(temp[1] == '3'){
        digitalWrite(SFlag3, HIGH);
      }
      else if(temp[1] == '2'){
        digitalWrite(SFlag4, HIGH);
      }
      else if(temp[1] == '1'){
        digitalWrite(SFlag5, HIGH);
      }
      else{
        printf("Collision Error");
      }
    }
    
    // Finger move
    if(commandValue >= 0){
      pos = pos - flag;
      if(digitalRead(SFlag1) == LOW){F1.write(pos);}
      else{F1.write(F1.read());}
      if(digitalRead(SFlag2) == LOW){F2.write(pos);}
      else{F2.write(F2.read());}
      if(digitalRead(SFlag3) == LOW){F3.write(pos);}
      else{F3.write(F3.read());}
      if(digitalRead(SFlag4) == LOW){F4.write(pos);}
      else{F4.write(F4.read());}
      if(digitalRead(SFlag5) == LOW){F5.write(pos);}
      else{F5.write(F5.read());}
      delay(20);
    }
  
    else{
      pos = pos - flag;

      if(digitalRead(SFlag1) == LOW){
         if(pos >= Max-F1_power){
            F1.write(pos);
            F1F = pos;
         }
         else{
             F1.write(Max-F1_power);
         }
      }
      else{F1.write(F1.read());};
      
      if(digitalRead(SFlag2) == LOW){
         if(pos >= Max-F2_power){
            F2.write(pos);
            F2F = pos;
         }
         else{
             F2.write(Max-F2_power);
         }
      }
      else{F2.write(F2.read());};

      if(digitalRead(SFlag3) == LOW){
         if(pos >= Max-F3_power){
            F3.write(pos);
            F3F = pos;
         }
         else{
             F3.write(Max-F3_power);
         }
      }
      else{F3.write(F3.read());};

      if(digitalRead(SFlag4) == LOW){
         if(pos >= Max-F4_power){
            F4.write(pos);
            F4F = pos;
         }
         else{
             F4.write(Max-F4_power);
         }
      }
      else{F4.write(F4.read());};

      if(digitalRead(SFlag5) == LOW){
         if(pos >= Max-F5_power){
            F5.write(pos);
            F5F = pos;
         }
         else{
             F5.write(Max-F5_power);
         }
      }
      else{F5.write(F5.read());};
      
      delay(10);
    }

    if(digitalRead(SFlag1) == HIGH && digitalRead(SFlag2) == HIGH && digitalRead(SFlag3) == HIGH && digitalRead(SFlag4) == HIGH && digitalRead(SFlag5) == HIGH){
      Serial.end();
    }

    // Serial report
    SerialReport2(F1.read(), F2.read(), F3.read(), F4.read(), F5.read());
    delay(10);
  }
  
  else{ // Error
    printf("Case Error");
  }
}

void SerialReport1(int F1, int F2, int F3, int F4, int F5){
  Serial.print(F1);
  Serial.print(",");
  Serial.print(F2);
  Serial.print(",");
  Serial.print(F3);
  Serial.print(",");
  Serial.print(F4);
  Serial.print(",");
  Serial.print(F5);
  Serial.print(".");
  Serial.println();
}

void SerialReport2(int F1, int F2, int F3, int F4, int F5){
  if(F1 <= 180){
    Serial.print(F1);
  }
  else{
    Serial.print(F1F);
  }
  Serial.print(",");
  if(F2 <= 180){
    Serial.print(F2);
  }
  else{
    Serial.print(F2F);
  }
  Serial.print(",");
  if(F3 <= 180){
    Serial.print(F3);
  }
  else{
    Serial.print(F3F);
  }
  Serial.print(",");
  if(F4 <= 180){
    Serial.print(F4);
  }
  else{
    Serial.print(F4F);
  }
  Serial.print(",");
  if(F5 <= 180){
    Serial.print(F5);
  }
  else{
    Serial.print(F5F);
  }
  Serial.print(".");
}
