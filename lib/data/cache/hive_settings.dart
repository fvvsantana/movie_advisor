import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'models/movie_details_cm.dart';
import 'models/movie_summary_cm.dart';

void initHive(HiveInterface hive) {
  WidgetsFlutterBinding.ensureInitialized();
  getApplicationDocumentsDirectory().then((dir) {
    hive
      ..init(dir.path)
      ..registerAdapter<MovieSummaryCM>(
        MovieSummaryCMAdapter(),
      )
      ..registerAdapter<MovieDetailsCM>(
        MovieDetailsCMAdapter(),
      );
  });
}
