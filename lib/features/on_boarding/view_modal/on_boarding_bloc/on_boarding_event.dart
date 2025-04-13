part of 'on_boarding_bloc.dart';

abstract class OnBoardingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PageChangeEvent extends OnBoardingEvent {
  final int pageIndex;

  PageChangeEvent({required this.pageIndex});

  @override
  List<Object> get props => [pageIndex];
}
