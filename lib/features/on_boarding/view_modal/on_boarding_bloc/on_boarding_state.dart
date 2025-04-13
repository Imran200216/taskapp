part of 'on_boarding_bloc.dart';

abstract class OnBoardingState extends Equatable {
  @override
  List<Object> get props => [];
}

class OnBoardingPageChangedSuccess extends OnBoardingState {
  final int currentPage;

  OnBoardingPageChangedSuccess({required this.currentPage});

  @override
  List<Object> get props => [currentPage];
}
