import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import 'contact_state.dart';

part 'contact_event.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc() : super(ContactInitial()) {
    on<FetchContactsEvent>(_onFetchContacts);
  }

  Future<void> _onFetchContacts(
    FetchContactsEvent event,
    Emitter<ContactState> emit,
  ) async {
    emit(ContactLoading());

    try {
      if (await FlutterContacts.requestPermission()) {
        var contacts = await FlutterContacts.getContacts(
          withProperties: true,
          withPhoto: true,
        );

        var contactList = contacts.map((contact) => contact.toJson()).toList();

        emit(ContactLoaded(contactList));
      } else {
        emit(ContactError('Permission denied to access contacts.'));
      }
    } catch (e) {
      emit(ContactError(e.toString()));
    }
  }
}
