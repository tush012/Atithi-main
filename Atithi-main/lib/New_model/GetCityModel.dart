/// status : true
/// message : "City List"
/// data : [{"id":"48","name":"Ajmer"},{"id":"50","name":"Alwar"},{"id":"61","name":"Banswara"},{"id":"56","name":"Baran"},{"id":"59","name":"Beawar"},{"id":"52","name":"Bharatpur"},{"id":"49","name":"Bhilwara"},{"id":"46","name":"Bhiwadi"},{"id":"45","name":"Bikaner"},{"id":"57","name":"Dhaulpur"},{"id":"62","name":"Dungarpur"},{"id":"60","name":"Hanumangarh"},{"id":"42","name":"Jaipur"},{"id":"43","name":"Jodhpur"},{"id":"55","name":"Kishangarh"},{"id":"44","name":"Kota"},{"id":"53","name":"Pali"},{"id":"63","name":"Pratapgarh"},{"id":"51","name":"Sikar"},{"id":"54","name":"Sri Ganganagar"},{"id":"58","name":"Tonk"},{"id":"47","name":"Udaipur"}]

class GetCityModel {
  GetCityModel({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetCityModel.fromJson(dynamic json) {
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
GetCityModel copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => GetCityModel(  status: status ?? _status,
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

/// id : "48"
/// name : "Ajmer"

class Data {
  Data({
      String? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  String? _id;
  String? _name;
Data copyWith({  String? id,
  String? name,
}) => Data(  id: id ?? _id,
  name: name ?? _name,
);
  String? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}