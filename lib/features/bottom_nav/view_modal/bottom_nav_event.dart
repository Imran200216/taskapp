part of 'bottom_nav_bloc.dart';

sealed class BottomNavEvent extends Equatable {
  const BottomNavEvent();
}

class SelectTab extends BottomNavEvent {
  final int index;

  const SelectTab({required this.index});

  @override
  // TODO: implement props
  List<Object?> get props => [index];
}
