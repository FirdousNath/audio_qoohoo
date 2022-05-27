String getTime(int seconds) {
  String hhmmss = '${Duration(seconds: seconds)}';
  return hhmmss.split('.')[0].padLeft(8, '0');
}
