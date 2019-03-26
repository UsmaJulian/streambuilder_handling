import 'dart:async';

import 'package:stream_builders_sample/common/bloc_provider.dart';
import 'package:stream_builders_sample/common/resource.dart';

const randomTexts = ["Welcome", "I'm second", "The Force is with me", "Just Joking"];

class HomeBloc extends BlocBase {

  int index = 0;

  StreamController<Resource<String>> _controller = StreamController.broadcast();
  StreamSink<Resource<String>> get _value => _controller.sink;
  Stream<Resource<String>> get textListener => _controller.stream;

  void onChangeText() {
    index = ++index % randomTexts.length;
    final textToShow = randomTexts[index];

    //Emulate a server call
    _value.add(Resource<String>.loading());
    Future.delayed(Duration(seconds: 1), () {
      _value.add(Resource.success(textToShow));
    });
  }

  @override
  void dispose() {
    _controller.close();
  }

}