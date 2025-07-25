class UserModel {
  final String uid;
  final String? email;
  final String? careerGoal;
  final List<String>? preferredRoles;

  UserModel({
    required this.uid,
    this.email,
    this.careerGoal,
    this.preferredRoles,
  });
}
