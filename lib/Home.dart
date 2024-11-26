import 'package:bloc_crud/bloc/user/user_list_bloc.dart';
import 'package:bloc_crud/model/user.dart';
import 'package:bloc_crud/widget/text_filed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CRUD')),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          final id = context.read<UserListBloc>().state.users.length + 1;
          showBottomSheet(context: context, id: id);
        },
        child: const Text('Add User'),
      ),
      body: BlocBuilder<UserListBloc, UserListState>(
        builder: (context, state) {
          if (state is UserListUpdated && state.users.isNotEmpty) {
            final users = state.users;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return buildUserTile(context, user);
              },
            );
          } else {
            return const Center(child: Text('No User Found'));
          }
        },
      ),
    );
  }

  Widget buildUserTile(BuildContext context, User user) {
    return ListTile(
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              context.read<UserListBloc>().add(DeleteUser(user: user));
            },
            icon: const Icon(Icons.delete, size: 30, color: Colors.red),
          ),
          IconButton(
            onPressed: () {
              name.text = user.name;
              email.text = user.email;
              showBottomSheet(context: context, id: user.id, isEdit: true);
            },
            icon: const Icon(Icons.edit, size: 30, color: Colors.yellow),
          )
        ],
      ),
    );
  }

  void showBottomSheet({
    required BuildContext context,
    bool isEdit = false,
    required int id,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormFieldComponent(hint: 'Enter Name', controller: name),
              TextFormFieldComponent(hint: 'Enter Email', controller: email),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: () {
                    final user = User(name: name.text, id: id, email: email.text);
                    if (isEdit) {
                      context.read<UserListBloc>().add(UpdateUser(user: user));
                    } else {
                      context.read<UserListBloc>().add(AddUser(user: user));
                    }
                    Navigator.pop(context);
                  },
                  child: Text(isEdit ? 'Update' : 'Add User'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
