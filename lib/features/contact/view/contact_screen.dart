import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskapp/features/add_task/view_modals/contact_bloc/contact_bloc.dart';
import 'package:taskapp/features/add_task/view_modals/contact_bloc/contact_state.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredContacts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contacts")),
      body: BlocProvider(
        create: (context) => ContactBloc()..add(FetchContactsEvent()),
        child: BlocBuilder<ContactBloc, ContactState>(
          builder: (context, state) {
            if (state is ContactLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ContactLoaded) {
              _filteredContacts = state.contacts;

              return Column(
                children: [
                  // 🔍 Search Bar
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (query) {
                        setState(() {
                          _filteredContacts =
                              state.contacts
                                  .where(
                                    (contact) => contact['name']
                                        .toLowerCase()
                                        .contains(query.toLowerCase()),
                                  )
                                  .toList();
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Search contacts...",
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                  ),

                  // 📋 Contacts List with Pull-to-Refresh
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        context.read<ContactBloc>().add(FetchContactsEvent());
                      },
                      child: ListView.builder(
                        itemCount: _filteredContacts.length,
                        itemBuilder: (context, index) {
                          final contact = _filteredContacts[index];
                          return ListTile(
                            leading: _buildAvatar(contact['photo']),
                            title: Text(
                              contact['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(contact['phone'] ?? "No number"),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () {
                              // TODO: Open contact details screen
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is ContactError) {
              return Center(
                child: Text(state.error),
              ); // ✅ Use 'error' instead of 'message'
            }

            return const Center(child: Text("No contacts found"));
          },
        ),
      ),
    );
  }

  /// 🖼️ Helper function to build the contact avatar safely.
  Widget _buildAvatar(String? base64Photo) {
    if (base64Photo == null || base64Photo.isEmpty) {
      return const CircleAvatar(child: Icon(Icons.person));
    }

    try {
      final Uint8List imageBytes = base64Decode(base64Photo);
      return CircleAvatar(backgroundImage: MemoryImage(imageBytes));
    } catch (e) {
      debugPrint("Error decoding Base64 image: $e");
      return const CircleAvatar(child: Icon(Icons.person));
    }
  }
}
