
class BData {
  int isDid;
  String title;
  BData();
  void blank() {
    isDid = 0;
    title = '';
  }
  void push(String title) {
    this.title = title;
  }
  void did(int isDid) {
    this.isDid = isDid;
  }
  String get_title() {
    return title;
  }
}