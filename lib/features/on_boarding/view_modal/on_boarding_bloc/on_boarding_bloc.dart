import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'on_boarding_event.dart';
part 'on_boarding_state.dart';

class OnBoardingBloc extends Bloc<OnBoardingEvent, OnBoardingState> {
  OnBoardingBloc() : super(OnBoardingPageChangedSuccess(currentPage: 0)) {
    on<PageChangeEvent>((event, emit) {
      emit(OnBoardingPageChangedSuccess(currentPage: event.pageIndex));
    });
  }
}
