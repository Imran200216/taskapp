part of 'selection_chip_bloc.dart';

sealed class SelectionChipState extends Equatable {
  const SelectionChipState();
}

final class SelectionChipInitial extends SelectionChipState {
  @override
  List<Object> get props => [];
}

class SelectionChipSelected extends SelectionChipState {
  final int selectedIndex;

  const SelectionChipSelected(this.selectedIndex);

  @override
  List<Object> get props => [selectedIndex];
}