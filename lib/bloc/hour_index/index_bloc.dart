
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'index_event.dart';

part 'index_state.dart';

class IndexBloc extends Bloc<IndexEvent, IndexState> {
  IndexBloc() : super(IndexInitial()) {
    on<IndexChangedEvent>((event, emit) {
      emit(IndexChangedState(
          event.changeIndex,));
    });
  }
}
