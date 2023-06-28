/// status : true
/// message : "Enquiry List"
/// data : [{"id":"2","name":"gfdf","mobile":"9192939495","email":"Ksh@gmail.com","message":"gdfg","vendor_id":"128","created_at":"2023-06-21 07:45:31","updated_at":"2023-06-14 14:24:18","city_name":"Jaipur","uname":"Khandelwal Delivery","event_name":"Birthday","description":"today is my birthday","profile_image":"649052332055a.png","status":"1"},{"id":"3","name":"gfdf","mobile":"7979878778","email":"gautam@gmail.com","message":"gdfg","vendor_id":"129","created_at":"2023-06-21 07:45:31","updated_at":"2023-06-15 05:25:46","city_name":"Jaipur","uname":"Atul","event_name":"","description":"","profile_image":"643540018ade0.jpg","status":"0"},{"id":"4","name":"hcvhvh","mobile":"9993224906","email":"Devesh33@gmail.com","message":"hccgcg","vendor_id":"130","created_at":"2023-06-21 07:45:31","updated_at":"2023-06-15 05:38:57","city_name":"Jaipur","uname":"Devesh","event_name":"devesh store","description":"demo","profile_image":"64895dff60108.jpg","status":"0"}]

class GetEnquiryModel {
  GetEnquiryModel({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetEnquiryModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Data>? _data;
GetEnquiryModel copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => GetEnquiryModel(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "2"
/// name : "gfdf"
/// mobile : "9192939495"
/// email : "Ksh@gmail.com"
/// message : "gdfg"
/// vendor_id : "128"
/// created_at : "2023-06-21 07:45:31"
/// updated_at : "2023-06-14 14:24:18"
/// city_name : "Jaipur"
/// uname : "Khandelwal Delivery"
/// event_name : "Birthday"
/// description : "today is my birthday"
/// profile_image : "649052332055a.png"
/// status : "1"

class Data {
  Data({
      String? id, 
      String? name, 
      String? mobile, 
      String? email, 
      String? message, 
      String? vendorId, 
      String? createdAt, 
      String? updatedAt, 
      String? cityName, 
      String? uname, 
      String? eventName, 
      String? description, 
      String? profileImage, 
      String? status,}){
    _id = id;
    _name = name;
    _mobile = mobile;
    _email = email;
    _message = message;
    _vendorId = vendorId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _cityName = cityName;
    _uname = uname;
    _eventName = eventName;
    _description = description;
    _profileImage = profileImage;
    _status = status;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _mobile = json['mobile'];
    _email = json['email'];
    _message = json['message'];
    _vendorId = json['vendor_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _cityName = json['city_name'];
    _uname = json['uname'];
    _eventName = json['event_name'];
    _description = json['description'];
    _profileImage = json['profile_image'];
    _status = json['status'];
  }
  String? _id;
  String? _name;
  String? _mobile;
  String? _email;
  String? _message;
  String? _vendorId;
  String? _createdAt;
  String? _updatedAt;
  String? _cityName;
  String? _uname;
  String? _eventName;
  String? _description;
  String? _profileImage;
  String? _status;
Data copyWith({  String? id,
  String? name,
  String? mobile,
  String? email,
  String? message,
  String? vendorId,
  String? createdAt,
  String? updatedAt,
  String? cityName,
  String? uname,
  String? eventName,
  String? description,
  String? profileImage,
  String? status,
}) => Data(  id: id ?? _id,
  name: name ?? _name,
  mobile: mobile ?? _mobile,
  email: email ?? _email,
  message: message ?? _message,
  vendorId: vendorId ?? _vendorId,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  cityName: cityName ?? _cityName,
  uname: uname ?? _uname,
  eventName: eventName ?? _eventName,
  description: description ?? _description,
  profileImage: profileImage ?? _profileImage,
  status: status ?? _status,
);
  String? get id => _id;
  String? get name => _name;
  String? get mobile => _mobile;
  String? get email => _email;
  String? get message => _message;
  String? get vendorId => _vendorId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get cityName => _cityName;
  String? get uname => _uname;
  String? get eventName => _eventName;
  String? get description => _description;
  String? get profileImage => _profileImage;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['mobile'] = _mobile;
    map['email'] = _email;
    map['message'] = _message;
    map['vendor_id'] = _vendorId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['city_name'] = _cityName;
    map['uname'] = _uname;
    map['event_name'] = _eventName;
    map['description'] = _description;
    map['profile_image'] = _profileImage;
    map['status'] = _status;
    return map;
  }

}