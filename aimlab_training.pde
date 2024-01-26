int targetX, targetY; // Koordinat target
int targetSize = 30; // Ukuran target
boolean targetClicked = false; // Apakah target diklik
int score = 0; // Skor pemain
float targetSpeed = 2;
int gameDuration = 60; // Durasi permainan dalam detik
int startTime; // Waktu mulai permainan
boolean inGame = false; // Status permainan

void setup() {
  size(800, 800);
  textSize(24);
  textAlign(CENTER, CENTER);
}

void draw() {
  background(255);
  
  if (!inGame) {
    drawHomeScreen();
    cursor(ARROW);
  } else {
    // Check if game time is still within the allowed duration
    if (millis() - startTime < gameDuration) {
      if (!targetClicked) {
        fill(255, 0, 0); // Warna target
        ellipse(targetX, targetY, targetSize, targetSize); // Gambar target

        fill(0);
        text("Score: " + score, 70, 30); // Tampilkan skor
      
        // Draw visual timer
        int remainingTime = gameDuration - (millis() - startTime);
        int seconds = ceil(remainingTime / 1000.0);
        text("Time: " + seconds + "s", width - 120, 30);
      }
    } else {
      // If time is up, display final score in the middle of the screen
      textAlign(CENTER, CENTER);
      textSize(36);
      text("Game Over!\nYour Score: " + score + "\n\nPress SPACE to go to home", width/2, height/2);
    }
  }
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
