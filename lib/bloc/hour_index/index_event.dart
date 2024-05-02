part of 'index_bloc.dart';

sealed class IndexEvent extends Equatable {
  const IndexEvent();

  @override
  List<Object> get props => [];
}
class IndexChangedEvent extends IndexEvent{
  final int changeIndex;


  const IndexChangedEvent(
      {required this.changeIndex});

}
