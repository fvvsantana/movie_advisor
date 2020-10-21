import 'package:flutter/foundation.dart';

class MovieSummaryModel {
  const MovieSummaryModel({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
  })  : assert(id != null),
        assert(title != null),
        assert(imageUrl != null);

  final int id;
  final String title;
  final String imageUrl;
}
