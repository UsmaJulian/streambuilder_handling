import 'package:flutter/material.dart';
import 'package:stream_builders_sample/common/bloc_provider.dart';
import 'package:stream_builders_sample/common/resource.dart';
import 'package:stream_builders_sample/home/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeBloc = BlocProvider.of<HomeBloc>(context);

    return Scaffold(
      //Need to create a Builder to get the Scaffold context, so it can be used by the Snackbar
      body: Builder(
        builder: (context) {
          _listenSuccessStates(context, homeBloc);
          return _content(homeBloc);
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () {
            homeBloc.onChangeText();
          }),
    );
  }

  void _listenSuccessStates(BuildContext context, HomeBloc homeBloc) {
    final onData = (Resource state) {
      if (state.status == Status.SUCCESS) {
        final snackBar =
            SnackBar(content: Text('Yay, not blocking the build process'));
        Scaffold.of(context).showSnackBar(snackBar);
      }
    };

    homeBloc.textListener.listen(onData);
  }

  Widget _content(HomeBloc homeBloc) {
    return Container(
      child: Center(
        child: StreamBuilder(
            stream: homeBloc.textListener,
            initialData: Resource<String>.idle(),
            builder: (context, asyncSnapshot) {
              return _handleTextStream(asyncSnapshot.data);
            }),
      ),
    );
  }

  Widget _handleTextStream(Resource<String> data) {
    switch (data.status) {
      case Status.IDLE:
        return Text("Welcome to this sample");
      case Status.LOADING:
        return CircularProgressIndicator();
      case Status.SUCCESS:
        return Text(data.data);
      case Status.ERROR:
        return Text("Something went wrong");
      default:
        return Text("How I get here");
    }
  }
}
