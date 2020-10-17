
class AuthViewModel {
  final bool isLoading;
  final String lastHostAddress;
  final String lastEmail;

  bool get isNotLoading => !isLoading;

  AuthViewModel({this.isLoading, this.lastHostAddress, this.lastEmail});
}