part of 'index_bloc.dart';

sealed class IndexState extends Equatable {
  const IndexState();
  
  @override
  List<Object> get props => [];
}

final class IndexInitial extends IndexState {}
final class IndexChangedState extends IndexState {
  final int changeIndex;


  const IndexChangedState(this.changeIndex, );


  @override
  List<Object> get props => [changeIndex, ];
}
