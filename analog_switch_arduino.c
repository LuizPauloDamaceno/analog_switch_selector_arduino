int dg_a = 2;
int dg_b = 3;
String control;

void setup(){
  Serial.begin(115200);
  Serial.setTimeout(200);
  pinMode(dg_a, OUTPUT);
  pinMode(dg_b, OUTPUT);
  digitalWrite(dg_a, HIGH);
  digitalWrite(dg_b, HIGH);
}

void loop(){
  delay(50);
  control = Serial.readString();
  delay(10);
  if(control == "A_to_2")
  {
    digitalWrite(dg_a, HIGH);
  }
  delay(10);
  if(control == "A_to_1")
  {
    digitalWrite(dg_a, LOW);
  }
  delay(10);
  if(control == "B_to_2")
  {
    digitalWrite(dg_b, HIGH);
  }
  delay(10);
  if(control == "B_to_1")
  {
    digitalWrite(dg_b, LOW);
  }
}
