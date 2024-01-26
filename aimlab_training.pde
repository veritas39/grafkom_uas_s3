int targetX, targetY; // Koordinat target
int targetSize = 30; // Ukuran target
boolean targetClicked = false; // Apakah target diklik
int score = 0; // Skor pemain
int gameDuration = 60; // Durasi permainan dalam detik
int startTime; // Waktu mulai permainan
boolean inGame = false; // Status permainan
boolean isEasy = false;
float targetSpeed = 2.5; // Kecepatan pergerakan target
float targetDirectionX = 1; // Arah pergerakan target (1 untuk ke kanan, -1 untuk ke kiri)
float targetDirectionY = 1; // Arah pergerakan target (1 untuk ke bawah, -1 untuk ke atas)

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
        
        if(!isEasy){
          // Update target position based on direction and speed
          targetX += targetDirectionX * targetSpeed;
          targetY += targetDirectionY * targetSpeed;
  
          // Check and update target direction to prevent going beyond canvas bounds
          if (targetX - targetSize/2 <= 0 || targetX + targetSize/2 >= width) {
            targetDirectionX *= -1; // Reverse direction on reaching left or right edge
            targetX = constrain(targetX, targetSize/2, width - targetSize/2);
    
          }
          if (targetY - targetSize/2 <= 0 || targetY + targetSize/2 >= height) {
            targetDirectionY *= -1; // Reverse direction on reaching top or bottom edge
            targetY = constrain(targetY, targetSize/2, height - targetSize/2);
          }
        }
      }

      fill(0);
      text("Score: " + score, 70, 30); // Tampilkan skor
      
      // Draw visual timer
      int remainingTime = gameDuration - (millis() - startTime);
      int seconds = ceil(remainingTime / 1000.0);
      text("Time: " + seconds + "s", width - 120, 30);
    } else {
      // If time is up, display final score in the middle of the screen
      textAlign(CENTER, CENTER);
      textSize(36);
      text("Game Over!\nYour Score: " + score + "\n\nPress SPACE to go to home", width/2, height/2);
    }
  }
}

void keyPressed() {
  if (keyCode == ENTER) {
    gameDuration = 0; //set time ke nol, langsung keluar scorenya
  }
  if (keyCode == 32) { //keyCode 32 adalah SPACE pada keyboard
    inGame = false;  // Set inGame ke false, langsung ke home screen
  }
}

void drawHomeScreen() {
  fill(0);
  textSize(36);
  text("Aim Training Game", width/2, height/2 - 50);
  
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

void startGame(int duration) {
  inGame = true;
  gameDuration = duration;
  startTime = millis();
  score = 0;
  spawnTarget();
  cursor(CROSS);
}

void spawnTarget() {
  // Munculkan target di posisi acak
  targetX = int(random(targetSize/2, width - targetSize/2));
  targetY = int(random(targetSize/2, height - targetSize/2));
  targetClicked = false;
}

void mousePressed() {
  if (!inGame) {
    // Check if the easy button is clicked
    if (mouseX > width/3 - 10 && mouseX < width/3 + 90 && mouseY > height/2 && mouseY < height/2 + 50) {
      isEasy = true;
      startGame(30000); // Easy mode: 30 seconds
    }
    // Check if the hard button is clicked
    else if (mouseX > width/2 + 50 && mouseX < width/2 + 150 && mouseY > height/2 && mouseY < height/2 + 50) {
      isEasy = false;
      startGame(15000); // Hard mode: 15 seconds
    }
  } else {
    // Check if game time is still within the allowed duration
    if (millis() - startTime < gameDuration) {
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
  }
}
