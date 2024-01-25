void setup() {
  size(800, 800);
  textSize(24);
  textAlign(CENTER, CENTER);
}

void drawHomeScreen() {
  fill(0);
  textSize(36);
  text("Target Clicker Game", width/2, height/2 - 50);
  
  // Easy button
  fill(100, 200, 100);
  rect(width/3 - 10, height/2, 100, 50);
  fill(0);
  text("Easy", width/2 - 95, height/2 + 25);
  
  // Hard button
  fill(200, 100, 100);
  rect(width/2 + 50, height/2, 100, 50);
  fill(0);
  text("Hard", width/2 + 100, height/2 + 25);
}

void spawnTarget() {
  // Munculkan target di posisi acak
  targetX = int(random(targetSize/2, width - targetSize/2));
  targetY = int(random(targetSize/2, height - targetSize/2));
  targetClicked = false;
}
void mouseClicked() {
  if (!targetClicked) {
    // Cek apakah klik berada di dalam target
    float distance = dist(mouseX, mouseY, targetX, targetY);
    
    if (distance < targetSize/2) {
      targetClicked = true;
      score++;
      spawnTarget();
    }
  } else {
    // Jika sudah mengklik target sebelumnya, reset game
    targetClicked = false;
    spawnTarget();
  }
}
