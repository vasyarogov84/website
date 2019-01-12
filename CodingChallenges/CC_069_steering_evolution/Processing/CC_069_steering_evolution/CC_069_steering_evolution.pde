// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Processing transcription: Chuck England

// Steering Evolution
// Another version:
// https://github.com/shiffman/NOC-S17-2-Intelligence-Learning/tree/master/week2-evolution/01_evolve_steering

// Part 1: [TBA]
// Part 2: [TBA]
// Part 3: [TBA]
// Part 4: [TBA]
// Part 5: [TBA]

import java.util.*;

List<Vehicle> vehicles = new ArrayList<Vehicle>();
List<PVector> food = new ArrayList<PVector>();
List<PVector> poison = new ArrayList<PVector>();

boolean debug;

void setup() {
  size(640, 360);
  for (int i = 0; i < 50; i++) {
    float x = random(width);
    float y = random(height);
    vehicles.add(new Vehicle(x, y));
  }

  for (int i = 0; i < 40; i++) {
    float x = random(width);
    float y = random(height);
    food.add(new PVector(x, y));
  }

  for (int i = 0; i < 20; i++) {
    float x = random(width);
    float y = random(height);
    poison.add(new PVector(x, y));
  }
}

void mouseDragged() {
  vehicles.add(new Vehicle(mouseX, mouseY));
}

void draw() {
  background(51);

  if (random(1) < 0.1) {
    float x = random(width);
    float y = random(height);
    food.add(new PVector(x, y));
  }

  if (random(1) < 0.01) {
    float x = random(width);
    float y = random(height);
    poison.add(new PVector(x, y));
  }


  for (int i = 0; i < food.size(); i++) {
    fill(0, 255, 0);
    noStroke();
    ellipse(food.get(i).x, food.get(i).y, 4, 4);
  }

  for (int i = 0; i < poison.size(); i++) {
    fill(255, 0, 0);
    noStroke();
    ellipse(poison.get(i).x, poison.get(i).y, 4, 4);
  }

  for (int i = vehicles.size() - 1; i >= 0; i--) {
    vehicles.get(i).boundaries();
    vehicles.get(i).behaviors(food, poison);
    vehicles.get(i).update();
    vehicles.get(i).display();

    Vehicle newVehicle = vehicles.get(i).clone();
    if (newVehicle != null) {
      vehicles.add(newVehicle);
    }

    if (vehicles.get(i).dead()) {
      float x = vehicles.get(i).position.x;
      float y = vehicles.get(i).position.y;
      food.add(new PVector(x, y));
      vehicles.remove(i);
    }
  }
}
