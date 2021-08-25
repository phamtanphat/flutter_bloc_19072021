import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc_19072021/base/base_event.dart';

abstract class BaseBloc extends ChangeNotifier{
  late StreamController<BaseEvent> _eventController  = StreamController();

  BaseBloc(){
    _eventController.stream.listen((event) {
      dispatch(event);
    });
  }

  void addEvent(BaseEvent event){
    _eventController.sink.add(event);
  }

  void dispatch(BaseEvent event);

  @override
  void dispose() {
    super.dispose();
    _eventController.close();
  }
}