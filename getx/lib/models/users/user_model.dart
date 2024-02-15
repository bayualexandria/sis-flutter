class UserModel {
  final String id;
  final String noInduk;
  final String nama;
  final String jenisKelamin;
  final String userId;
  final String noHp;
  final String imageProfile;
  final String alamat;
  final String kelasId;
  final String createdAt;
  final String updatedAt;
  final Null deletedAt;

  UserModel(
      {required this.id,
      required this.noInduk,
      required this.nama,
      required this.jenisKelamin,
      required this.userId,
      required this.noHp,
      required this.imageProfile,
      required this.alamat,
      required this.kelasId,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        noInduk: json['no_induk'],
        nama: json['nama'],
        jenisKelamin: json['jenis_kelamin'],
        userId: json['user_id'],
        noHp: json['no_hp'],
        imageProfile: json['image_profile'],
        alamat: json['alamat'],
        kelasId: json['kelas_id'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        deletedAt: json['deleted_at']);
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['no_induk'] = this.noInduk;
  //   data['nama'] = this.nama;
  //   data['jenis_kelamin'] = this.jenisKelamin;
  //   data['user_id'] = this.userId;
  //   data['no_hp'] = this.noHp;
  //   data['image_profile'] = this.imageProfile;
  //   data['alamat'] = this.alamat;
  //   data['kelas_id'] = this.kelasId;
  //   data['created_at'] = this.createdAt;
  //   data['updated_at'] = this.updatedAt;
  //   data['deleted_at'] = this.deletedAt;
  //   return data;
  // }
}
