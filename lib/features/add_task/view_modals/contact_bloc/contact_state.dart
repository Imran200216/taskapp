
import 'package:equatable/equatable.dart';

sealed class ContactState extends Equatable {
  const ContactState();
}

final class ContactInitial extends ContactState {
  @override
  List<Object> get props => [];
}

final class ContactLoading extends ContactState {
  @override
  List<Object> get props => [];
}

final class ContactLoaded extends ContactState {
  final List<Map<String, dynamic>> contacts;

  const ContactLoaded(this.contacts);

  @override
  List<Object> get props => [contacts];
}

final class ContactError extends ContactState {
  final String error;

  const ContactError(this.error);

  @override
  List<Object> get props => [error];
}
