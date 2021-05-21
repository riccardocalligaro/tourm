import 'dart:math';

class TMUtils {
  static int getRandomNumber() {
    Random random = Random();
    int randomNumber = random.nextInt(999999);
    return randomNumber;
  }
}
