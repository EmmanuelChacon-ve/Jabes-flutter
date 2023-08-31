class UserData {
  String idUser;
  String idRol;

  UserData({
    required this.idUser,
    required this.idRol,
  });

  // Método factory para crear una instancia de UserData a partir de un JSON
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      idUser: json['id_user'],
      idRol: json['id_rol'],
    );
  }

  // Método para convertir el objeto UserData a un JSON
  Map<String, dynamic> toJson() {
    return {
      'id_user': idUser,
      'id_rol': idRol,
    };
  }
}
