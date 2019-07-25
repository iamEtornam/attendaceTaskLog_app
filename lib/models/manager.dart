class Manager {
  String name;
  String email;
  String department;
  String photo;

  Manager({this.name, this.email, this.department, this.photo});

  Manager.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    email = json['email'];
    department = json['department'];
    photo = json['photo'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['department'] = this.department;
    data['photo'] = this.photo;
    return data;
  }
}
