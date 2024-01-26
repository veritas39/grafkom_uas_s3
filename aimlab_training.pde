int targetX, targetY; // Koordinat target
int targetSize = 30; // Ukuran target
boolean targetClicked = false; // Apakah target diklik
int score = 0; // Skor pemain
float targetSpeed = 2;
int gameDuration = 60; // Durasi permainan dalam detik
int startTime; // Waktu mulai permainan
boolean gameStarted = false; // Status permainan

void setup() {
  size(800, 800);
  textSize(24);
  textAlign(CENTER, CENTER);
}

void draw() {
  background(255);
  
  if (gameStarted) {
    if (!targetClicked) {
      fill(255, 0, 0); // Warna target
      ellipse(targetX, targetY, targetSize, targetSize); // Gambar target

      // Animasi pergerakan target
      targetX += targetSpeed;

      // Ubah arah jika target mencapai tepi layar
      if (targetX > width - targetSize/2 || targetX < targetSize/2) {
        targetSpeed *= -1; // Ubah arah
      }
    }

    fill(0);
    text("Score: " + score, width/2, 30); // Tampilkan skor

    // Hitung waktu yang telah berlalu
    int elapsedTime = millis() / 1000 - startTime;
    
    // Hitung sisa waktu
    int remainingTime = max(0, gameDuration - elapsedTime);
    
    // Tampilkan waktu di tengah layar
    text("Time: " + remainingTime, width/2, height/2);

    // Cek apakah waktu habis
    if (remainingTime == 0) {
      gameStarted = false;
      text("Game Over! Press any key to play again.", width/2, height/2 + 40);
    }
  } else {
    text("Press any key to start the game", width/2, height/2);
  }
}

void keyPressed() {
  if (keyCode == ENTER) {
    gameDuration = 0; // set time ke nol, langsung muncul score
  }
  if (keyCode == 32) { //keyCode 32 adalah SPACE pada keyboard
    inGame = false;  // Set inGame ke false, langsung muncul halaman homescreen drawHomeScreen()
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
