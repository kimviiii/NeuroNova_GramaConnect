class User {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? address;
  final String? nic;
  final String? district;
  final String? divisionalSecretariat;
  final String? gramaNiladhariDivision;
  final String role;
  final DateTime? createdAt;
  final String? token;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.address,
    this.nic,
    this.district,
    this.divisionalSecretariat,
    this.gramaNiladhariDivision,
    this.role = 'citizen',
    this.createdAt,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      address: json['address'],
      nic: json['nic'],
      district: json['district'],
      divisionalSecretariat: json['divisional_secretariat'],
      gramaNiladhariDivision: json['grama_niladhari_division'],
      role: json['role'] ?? 'citizen',
      token: json['token'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'nic': nic,
      'district': district,
      'divisional_secretariat': divisionalSecretariat,
      'grama_niladhari_division': gramaNiladhariDivision,
      'role': role,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? address,
    String? nic,
    String? district,
    String? divisionalSecretariat,
    String? gramaNiladhariDivision,
    String? role,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      nic: nic ?? this.nic,
      district: district ?? this.district,
      divisionalSecretariat:
          divisionalSecretariat ?? this.divisionalSecretariat,
      gramaNiladhariDivision:
          gramaNiladhariDivision ?? this.gramaNiladhariDivision,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
