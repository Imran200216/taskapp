import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'selection_chip_event.dart';

part 'selection_chip_state.dart';

class SelectionChipBloc extends Bloc<SelectionChipEvent, SelectionChipState> {
  SelectionChipBloc() : super(SelectionChipInitial()) {
    // selection chip event
    on<SelectChipEvent>((event, emit) {
      emit(SelectionChipSelected(event.selectedIndex));
    });
  }
}
