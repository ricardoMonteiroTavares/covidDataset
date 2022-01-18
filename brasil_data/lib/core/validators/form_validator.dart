class FormValidator {
  /// Esta função valida o [email]. Caso seja válido, é retornado o valor null
  static String? validateEmail(String email) {
    final RegExp _emailRegex = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$");
    return (_emailRegex.hasMatch(email)) ? null : "Insira um e-mail válido";
  }

  /// Esta função valida a senha([password]). Caso seja válido, é retornado o valor null
  static String? validatePassword(String password) {
    if (password.trim().isEmpty) {
      return "Insira um senha válida";
    } else if (password.trim().length < 6) {
      return "A senha deve possuir mínimo 6 caracteres";
    } else {
      return null;
    }
  }
}
