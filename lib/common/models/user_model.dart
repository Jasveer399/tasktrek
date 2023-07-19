class UserModle {
    final int id;
    final int isVerified;

    UserModle({
        required this.id,
        required this.isVerified,
    });

    factory UserModle.fromJson(Map<String, dynamic> json) => UserModle(
        id: json["id"],
        isVerified: json["isVerified"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "isVerified": isVerified,
    };
}