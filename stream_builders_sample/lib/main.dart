import 'package:flutter/material.dart';
import 'package:stream_builders_sample/common/bloc_provider.dart';
import 'package:stream_builders_sample/home/home_bloc.dart';
import 'package:stream_builders_sample/home/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StreamBuilder Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        bloc: HomeBloc(),
        child: HomeScreen()
      ),
    );
  }
}