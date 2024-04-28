part of 'degree_bloc.dart';

sealed class DegreeEvent extends Equatable {
  const DegreeEvent();

  @override
  List<Object> get props => [];
}

class CentigradeEvent extends DegreeEvent{}
class FahrenheitEvent extends DegreeEvent{}
