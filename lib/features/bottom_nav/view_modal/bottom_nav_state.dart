part of 'bottom_nav_bloc.dart';

sealed class BottomNavState extends Equatable {
  final int selectedIndex;
  const BottomNavState(this.selectedIndex);

  @override
  List<Object> get props => [selectedIndex];
}

// Concrete class for state updates
class BottomNavUpdated extends BottomNavState {
  const BottomNavUpdated(super.selectedIndex);
}
