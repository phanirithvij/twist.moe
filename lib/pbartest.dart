// Copyright (c) 2014, <Jaron Tai>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library progress_bar.example;

import 'progress_bar/progress_bar.dart' show ProgressBar;
import 'dart:async';

void main() {
  // █
  print('starting');
  var bar = ProgressBar(
    ':percent [:bar] :current/:total :etas',
    total: 10,
    incomplete: '-',
    complete: '=',
  );
  Timer.periodic(Duration(milliseconds: 200), (Timer timer) {
    bar.tick();
    if (bar.complete) {
      timer.cancel();
    }
  });
  print('done');
}
