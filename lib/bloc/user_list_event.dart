part of 'user_list_bloc.dart';

@immutable
sealed class UserListEvent {}

class AddUser extends UserListEvent {
  final User user;

  AddUser(this.user);
}

class DeleteUser extends UserListEvent {
  final User user;

  DeleteUser(this.user);
}

class UpdateUser extends UserListEvent {
  final User user;

  UpdateUser(this.user);
}
