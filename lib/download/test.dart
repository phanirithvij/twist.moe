void x(f) async {
  await print("ds $f");
}

void main() async {
  // final lss = [];
  for (int i = 0; i < 42; i++) {
    await x(i);
    // lss.add(i);
  }

  // Future.forEach(lss, x);
}
