class AddressModel {
  String address;
  String landmark;
  String city;
  String state;
  String pinCode;

  AddressModel(
      {this.address, this.landmark, this.city, this.state, this.pinCode});

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      address: json['address'],
      landmark: json['landmark'],
      city: json['city'],
      state: json['state'],
      pinCode: json['pinCode'],
    );
  }
}
