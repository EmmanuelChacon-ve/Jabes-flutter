import 'dart:convert';

UserHasRoles userHasRolesFromJson(String str) =>
    UserHasRoles.fromJson(json.decode(str));

String userHasRolesToJson(UserHasRoles data) => json.encode(data.toJson());

class UserHasRoles {
  String? id;
  String? userId;
  String? roleId;
  String? createdAt;
  String? updatedAt;
  bool? status;

  UserHasRoles({
    this.id,
    this.userId,
    this.roleId,
    this.createdAt,
    this.updatedAt,
    this.status,
  });

  factory UserHasRoles.fromJson(Map<String, dynamic> json) {
    return UserHasRoles(
      id: json["id"]?.toString(),
      userId: json["id_user"]?.toString(),
      roleId: json["id_rol"]?.toString(),
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "id_user": userId,
      "id_rol": roleId,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "status": status,
    };
  }
}
