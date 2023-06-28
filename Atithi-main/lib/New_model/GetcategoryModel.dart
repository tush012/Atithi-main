/// status : true
/// message : "Slider List"
/// data : [{"id":"69","c_name":"Wedding Card","c_name_a":"","icon":"","sub_title":null,"description":null,"img":"https://developmentalphawizz.com/invitation_design/uploads/64354574d3e70.jpg","other_img":"","type":"vip","p_id":null,"service_type":"0"},{"id":"72","c_name":"Birthday Card","c_name_a":"","icon":"","sub_title":null,"description":null,"img":"https://developmentalphawizz.com/invitation_design/uploads/6435454d0b021.jpg","other_img":"","type":"vip","p_id":null,"service_type":"0"},{"id":"73","c_name":"Holidays","c_name_a":"","icon":"","sub_title":null,"description":null,"img":"https://developmentalphawizz.com/invitation_design/uploads/64396933e4b6a.jpg","other_img":"","type":"vip","p_id":null,"service_type":"0"},{"id":"74","c_name":"House Inauguration ","c_name_a":"","icon":"","sub_title":null,"description":null,"img":"https://developmentalphawizz.com/invitation_design/uploads/643d49de83a67.JPG","other_img":"","type":"vip","p_id":null,"service_type":"0"}]

class GetcategoryModel {
  GetcategoryModel({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetcategoryModel.fromJson(dynamic json) {
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
GetcategoryModel copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => GetcategoryModel(  status: status ?? _status,
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

/// id : "69"
/// c_name : "Wedding Card"
/// c_name_a : ""
/// icon : ""
/// sub_title : null
/// description : null
/// img : "https://developmentalphawizz.com/invitation_design/uploads/64354574d3e70.jpg"
/// other_img : ""
/// type : "vip"
/// p_id : null
/// service_type : "0"

class Data {
  Data({
      String? id, 
      String? cName, 
      String? cNameA, 
      String? icon,
      bool? selected,
      dynamic subTitle, 
      dynamic description, 
      String? img, 
      String? otherImg, 
      String? type, 
      dynamic pId, 
      String? serviceType,}){
    _id = id;
    _cName = cName;
    _cNameA = cNameA;
    select = selected;
    _icon = icon;
    _subTitle = subTitle;
    _description = description;
    _img = img;
    _otherImg = otherImg;
    _type = type;
    _pId = pId;
    _serviceType = serviceType;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _cName = json['c_name'];
    _cNameA = json['c_name_a'];
    _icon = json['icon'];
    select = false;
    _subTitle = json['sub_title'];
    _description = json['description'];
    _img = json['img'];
    _otherImg = json['other_img'];
    _type = json['type'];
    _pId = json['p_id'];
    _serviceType = json['service_type'];
  }
  String? _id;
  String? _cName;
  String? _cNameA;
  bool? select;
  String? _icon;
  dynamic _subTitle;
  dynamic _description;
  String? _img;
  String? _otherImg;
  String? _type;
  dynamic _pId;
  String? _serviceType;
Data copyWith({  String? id,
  String? cName,
  String? cNameA,
  String? icon,
  dynamic subTitle,
  dynamic description,
  String? img,
  String? otherImg,
  String? type,
  dynamic pId,
  String? serviceType,
}) => Data(  id: id ?? _id,
  cName: cName ?? _cName,
  cNameA: cNameA ?? _cNameA,
  icon: icon ?? _icon,
  subTitle: subTitle ?? _subTitle,
  description: description ?? _description,
  img: img ?? _img,
  otherImg: otherImg ?? _otherImg,
  type: type ?? _type,
  pId: pId ?? _pId,
  serviceType: serviceType ?? _serviceType,
);
  String? get id => _id;
  String? get cName => _cName;
  String? get cNameA => _cNameA;
  String? get icon => _icon;
  dynamic get subTitle => _subTitle;
  dynamic get description => _description;
  String? get img => _img;
  String? get otherImg => _otherImg;
  String? get type => _type;
  dynamic get pId => _pId;
  String? get serviceType => _serviceType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['c_name'] = _cName;
    map['c_name_a'] = _cNameA;
    map['icon'] = _icon;
    map['sub_title'] = _subTitle;
    map['description'] = _description;
    map['img'] = _img;
    map['other_img'] = _otherImg;
    map['type'] = _type;
    map['p_id'] = _pId;
    map['service_type'] = _serviceType;
    return map;
  }

}