import 'package:flutter/material.dart';

abstract class BlocBase {
  void dispose();
}

class BlocProvider<T extends BlocBase> extends StatefulWidget {

  BlocProvider({
    Key key,
    @required this.bloc,
    @required this.child,
  }): super(key: key);

  final T bloc;
  final Widget child;

  @override
  State<StatefulWidget> createState() => _BlocProviderState<T>();

  static Type _typeOf<T>() => T;

  static T of<T extends BlocBase>(BuildContext context) {
    final type = _typeOf<_BlocProvider<T>>();
    return (context.inheritFromWidgetOfExactType(type) as _BlocProvider).bloc;
  }
}

class _BlocProviderState<T extends BlocBase> extends State<BlocProvider<T>> {

  @override
  Widget build(BuildContext context) => _BlocProvider<T>(bloc: widget.bloc, child: widget.child);

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}

class _BlocProvider<T> extends InheritedWidget {
  final T bloc;

  _BlocProvider({
    Key key,
    @required this.bloc,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_BlocProvider old) => bloc != old.bloc;
}