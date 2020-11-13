import 'package:flutter/material.dart';
import 'package:movie_advisor/presentation/common/centered_progress_indicator.dart';

/// Chooses between a [CenteredProgressIndicator], an error widget or a
/// content widget by matching the snapshot's data with the provided generic
/// types.
class AsyncSnapshotResponseView<Loading, Error, Success>
    extends StatelessWidget {
  AsyncSnapshotResponseView({
    @required this.snapshot,
    @required this.errorWidgetBuilder,
    @required this.successWidgetBuilder,
    Key key,
  })  : assert(snapshot != null),
        assert(errorWidgetBuilder != null),
        assert(successWidgetBuilder != null),
        assert(Loading != dynamic),
        assert(Error != dynamic),
        assert(Success != dynamic),
        super(key: key);

  final AsyncSnapshot snapshot;
  final Widget Function(BuildContext context, Success success)
      successWidgetBuilder;
  final Widget Function(BuildContext context, Error error) errorWidgetBuilder;

  @override
  Widget build(BuildContext context) {
    final snapshotData = snapshot.data;
    if (snapshotData == null || snapshotData is Loading) {
      return CenteredProgressIndicator();
    }

    if (snapshotData is Error) {
      return errorWidgetBuilder(context, snapshotData);
    }

    if (snapshotData is Success) {
      return successWidgetBuilder(context, snapshotData);
    }

    throw UnknownStateTypeException();
  }
}

class UnknownStateTypeException implements Exception {}
