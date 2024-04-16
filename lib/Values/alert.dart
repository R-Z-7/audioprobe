part of Values;

class Alerts {
  static showError(String text) {
    return showSimpleNotification(
        Text(
          text,
          style: const TextStyle(color: AppColors.white),
        ),
        background: AppColors.dark);
  }

  static showError2(String text) {
    return showSimpleNotification(
        Text(text, style: const TextStyle(color: AppColors.white)),
        background: Colors.red.shade900);
  }

  static showSuccess(String text) {
    return showSimpleNotification(Text(text), background: AppColors.green);
  }

  static show(int type, String text) {
    if (type == 1) {
      showSuccess(text);
    } else {
      showError(text);
    }
  }
}
