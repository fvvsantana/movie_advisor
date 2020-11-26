import 'package:flutter/material.dart';

import 'package:movie_advisor/generated/l10n.dart';

class MoviesListEmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: Text(S.of(context).moviesListEmptyStateMessage),
      );
}
