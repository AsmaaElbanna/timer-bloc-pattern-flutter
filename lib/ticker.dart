class Ticker {
  Stream<int> tick(int ticks) => Stream.periodic(Duration(seconds: 5,), (x) {
        return ticks - x - 1;
      }).take(ticks);
}
