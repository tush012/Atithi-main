/// status : true
/// message : "Template saved success"
/// data : [{"id":"2","user_id":"21","template_id":"24","image":"https://developmentalphawizz.com/invitation_design/uploads/profile_pics/6492915a84702.png","price":"100.00","created_at":"2023-06-21 05:57:46","updated_at":"2023-06-21 05:57:46"},{"id":"3","user_id":"21","template_id":"24","image":"https://developmentalphawizz.com/invitation_design/uploads/profile_pics/64929341e4455.png","price":"100.00","created_at":"2023-06-21 06:05:53","updated_at":"2023-06-21 06:05:53"}]

class SavedCardModel {
  SavedCardModel({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  SavedCardModel.fromJson(dynamic json) {
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
SavedCardModel copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => SavedCardModel(  status: status ?? _status,
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
/// user_id : "21"
/// template_id : "24"
/// image : "https://developmentalphawizz.com/invitation_design/uploads/profile_pics/6492915a84702.png"
/// price : "100.00"
/// created_at : "2023-06-21 05:57:46"
/// updated_at : "2023-06-21 05:57:46"

class Data {
  Data({
      String? id, 
      String? userId, 
      String? templateId, 
      String? image, 
      String? price, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _userId = userId;
    _templateId = templateId;
    _image = image;
    _price = price;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _templateId = json['template_id'];
    _image = json['image'];
    _price = json['price'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _userId;
  String? _templateId;
  String? _image;
  String? _price;
  String? _createdAt;
  String? _updatedAt;
Data copyWith({  String? id,
  String? userId,
  String? templateId,
  String? image,
  String? price,
  String? createdAt,
  String? updatedAt,
}) => Data(  id: id ?? _id,
  userId: userId ?? _userId,
  templateId: templateId ?? _templateId,
  image: image ?? _image,
  price: price ?? _price,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get templateId => _templateId;
  String? get image => _image;
  String? get price => _price;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['template_id'] = _templateId;
    map['image'] = _image;
    map['price'] = _price;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}