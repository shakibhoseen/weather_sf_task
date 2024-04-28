part of 'degree_bloc.dart';

sealed class DegreeState extends Equatable {
  const DegreeState();
  
  @override
  List<Object> get props => [];
}

class CentigradeState extends DegreeState{}
class FahrenheitState extends DegreeState{}
