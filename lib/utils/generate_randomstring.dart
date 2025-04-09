import 'dart:math';

String generateRandomString(int length) {
  const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  Random random = Random();
  StringBuffer randomString = StringBuffer();

  for (int i = 0; i < length; i++) {
    int randomIndex = random.nextInt(characters.length);
    randomString.write(characters[randomIndex]);
  }

  return randomString.toString();
}