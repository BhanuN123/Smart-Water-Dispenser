#define TRIG_PIN 9
#define ECHO_PIN 10
#define RELAY_PIN 7
#define DISTANCE_THRESHOLD 10
#define PUMP_ON_TIME1 3600
#define PUMP_ON_TIME2 6600
#define PUMP_ON_TIME3 10040
#define PUMP_ON_TIME4 13300
#define PUMP_ON_TIME5 17500

unsigned long previousMillis = 0;
float distance;

void setup() {
  pinMode(TRIG_PIN, OUTPUT);
  pinMode(ECHO_PIN, INPUT);
  pinMode(RELAY_PIN, OUTPUT);
  digitalWrite(RELAY_PIN, HIGH);
  Serial.begin(9600);
}

float getDistance() {
  digitalWrite(TRIG_PIN, LOW);
  delayMicroseconds(2);
  digitalWrite(TRIG_PIN, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIG_PIN, LOW);

  long duration = pulseIn(ECHO_PIN, HIGH);
  return (duration * 0.034) / 2;
}

void loop() {

  if (Serial.available() > 0) {
    char data = Serial.read();
    Serial.println("data received from bluetooth ");
    Serial.println(data);

    if (data == 'a') {
      distance = getDistance();
      if (distance < DISTANCE_THRESHOLD) {
        digitalWrite(RELAY_PIN, LOW);
        Serial.println("Motor ON");
        previousMillis = millis();
        while (millis() - previousMillis < PUMP_ON_TIME1) {
          distance = getDistance();
          Serial.println(distance);

          if (distance >= DISTANCE_THRESHOLD) break;
        }
        digitalWrite(RELAY_PIN, HIGH);
        Serial.println("Motor OFF");
      }
    } else if (data == 'b') {
      distance = getDistance();
      if (distance < DISTANCE_THRESHOLD) {
        digitalWrite(RELAY_PIN, LOW);
        Serial.println("Motor ON");
        previousMillis = millis();
        while (millis() - previousMillis < PUMP_ON_TIME2) {
          distance = getDistance();
          Serial.println(distance);
          if (distance >= DISTANCE_THRESHOLD) break;
        }
        digitalWrite(RELAY_PIN, HIGH);
        Serial.println("Motor OFF");
      }
    } else if (data == 'c') {
      distance = getDistance();
      if (distance < DISTANCE_THRESHOLD) {
        digitalWrite(RELAY_PIN, LOW);
        Serial.println("Motor ON");
        previousMillis = millis();
        while (millis() - previousMillis < PUMP_ON_TIME3) {
          distance = getDistance();
          Serial.println(distance);
          if (distance >= DISTANCE_THRESHOLD) break;
        }
        digitalWrite(RELAY_PIN, HIGH);
        Serial.println("Motor OFF");
      }
    } else if (data == 'd') {
      distance = getDistance();
      if (distance < DISTANCE_THRESHOLD) {
        digitalWrite(RELAY_PIN, LOW);
        Serial.println("Motor ON");
        previousMillis = millis();
        while (millis() - previousMillis < PUMP_ON_TIME4) {
          distance = getDistance();
          Serial.println(distance);
          if (distance >= DISTANCE_THRESHOLD) break;
        }
        digitalWrite(RELAY_PIN, HIGH);
        Serial.println("Motor OFF");
      }
    } else if (data == 'e') {
      distance = getDistance();
      if (distance < DISTANCE_THRESHOLD) {
        digitalWrite(RELAY_PIN, LOW);
        Serial.println("Motor ON");
        previousMillis = millis();
        while (millis() - previousMillis < PUMP_ON_TIME5) {
          distance = getDistance();
          Serial.println(distance);
          if (distance >= DISTANCE_THRESHOLD) break;
        }
        digitalWrite(RELAY_PIN, HIGH);
        Serial.println("Motor OFF");
      }
    }
  }

  delay(100);
}