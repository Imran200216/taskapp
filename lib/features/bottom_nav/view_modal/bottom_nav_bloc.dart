import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_nav_event.dart';
part 'bottom_nav_state.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(const BottomNavUpdated(0)) {  // Default index is 0
    on<SelectTab>((event, emit) {
      emit(BottomNavUpdated(event.index));  // Emit new state correctly
    });
  }
}


