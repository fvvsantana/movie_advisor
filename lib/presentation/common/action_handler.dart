import 'dart:async';
import 'package:flutter/material.dart';

class ActionHandler<T> extends StatefulWidget {
  const ActionHandler({
    @required this.child,
    @required this.actionStream,
    @required this.onReceived,
    Key key,
  })  : assert(child != null),
        assert(actionStream != null),
        assert(onReceived != null),
        super(key: key);

  final Widget child;
  final Stream<T> actionStream;
  final ValueChanged<T> onReceived;

  @override
  _ActionHandlerState<T> createState() => _ActionHandlerState<T>();
}

class _ActionHandlerState<T> extends State<ActionHandler<T>> {
  StreamSubscription<T> _streamSubscription;

  @override
  void initState() {
    super.initState();
    _streamSubscription = widget.actionStream.listen(
      widget.onReceived,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
