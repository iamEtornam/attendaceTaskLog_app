class Employee {
  String name;
  String email;
  String phone;
  String department;
  String photo;

  Employee(
      {this.name, this.email, this.phone, this.department, this.photo});

  Employee.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    department = json['department'];
    photo = json['photo'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['department'] = this.department;
    data['photo'] = this.photo;
    return data;
  }
}
