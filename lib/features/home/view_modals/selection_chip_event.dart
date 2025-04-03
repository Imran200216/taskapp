part of 'selection_chip_bloc.dart';

sealed class SelectionChipEvent extends Equatable {
  const SelectionChipEvent();
}

class SelectChipEvent extends SelectionChipEvent {
  final int selectedIndex;

  const SelectChipEvent(this.selectedIndex);

  @override
  List<Object> get props => [selectedIndex];
}