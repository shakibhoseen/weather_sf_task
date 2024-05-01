
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'degree_event.dart';
part 'degree_state.dart';

class DegreeBloc extends Bloc<DegreeEvent, DegreeState> {
  DegreeBloc() : super(CentigradeState()) {
    on<DegreeEvent>((event, emit) {
       if(event is CentigradeEvent){
         emit(CentigradeState());
       }else{
         emit(FahrenheitState());
       }
    });
  }
}
