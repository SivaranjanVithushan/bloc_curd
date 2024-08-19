import 'dart:developer';

import 'package:bloc_curd/bloc/user_list_bloc.dart';
import 'package:bloc_curd/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: BlocBuilder<UserListBloc, UserListState>(
        builder: (context, state) {
          if (state is UserListInitial) {
            return const Center(
              child: Text('No users found'),
            );
          } else if (state is UserListUpdated) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          context.read<UserListBloc>().add(DeleteUser(user));
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.green),
                        onPressed: () {
                          log('User ID: ${user.id}');
                          showDialog(
                            context: context,
                            builder: (_) =>
                                UserDialog(isEdit: true, user: user),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => const UserDialog(isEdit: false),
          );
        },
        tooltip: 'Add User',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class UserDialog extends StatefulWidget {
  final bool isEdit;
  final User? user;

  const UserDialog({super.key, required this.isEdit, this.user});

  @override
  State<UserDialog> createState() => _UserDialogState();
}

class _UserDialogState extends State<UserDialog> {
  late TextEditingController nameController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nameController =
        TextEditingController(text: widget.isEdit ? widget.user?.name : '');
    emailController =
        TextEditingController(text: widget.isEdit ? widget.user?.email : '');
  }

  String randomId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.isEdit ? 'Update User' : 'Add User'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
            keyboardType: TextInputType.text,
          ),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final name = nameController.text.trim();
            final email = emailController.text.trim();

            if (name.isEmpty || email.isEmpty) return;

            if (widget.isEdit) {
              final updatedUser = User(
                id: widget.user!.id,
                name: name,
                email: email,
              );
              context.read<UserListBloc>().add(UpdateUser(updatedUser));
            } else {
              final newUser = User(
                id: randomId(),
                name: name,
                email: email,
              );
              context.read<UserListBloc>().add(AddUser(newUser));
            }

            Navigator.of(context).pop();
          },
          child: Text(widget.isEdit ? 'Update' : 'Add'),
        ),
      ],
    );
  }
}
