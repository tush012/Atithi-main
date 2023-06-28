/// status : "1"
/// msg : "Service providers"
/// setting : [{"id":"1","title":"What is the minimum quantity for printed wedding cards?","description":"<p>Just 25 cards.</p>\r\n\r\n<p>We understand that you may want to have a smaller wedding and consequently have kept the minimums at just 25pcs. Most designer wedding card companies have a minimum of 100pcs, that seems too high.</p>\r\n"},{"id":"2","title":"How do I order a printed wedding card?","description":"<ul>\r\n\t<li>\r\n\t<p>It&rsquo;s very simple:</p>\r\n\r\n\t<ul>\r\n\t\t<li>Choose your card, share text and place order</li>\r\n\t\t<li>Receive digital proof via email in 4 days</li>\r\n\t\t<li>In case of edits, receive revised proof via email in 3 days</li>\r\n\t\t<li>Once the pr"}]

class FaqModel {
  FaqModel({
      String? status, 
      String? msg, 
      List<Setting>? setting,}){
    _status = status;
    _msg = msg;
    _setting = setting;
}

  FaqModel.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
    if (json['setting'] != null) {
      _setting = [];
      json['setting'].forEach((v) {
        _setting?.add(Setting.fromJson(v));
      });
    }
  }
  String? _status;
  String? _msg;
  List<Setting>? _setting;
FaqModel copyWith({  String? status,
  String? msg,
  List<Setting>? setting,
}) => FaqModel(  status: status ?? _status,
  msg: msg ?? _msg,
  setting: setting ?? _setting,
);
  String? get status => _status;
  String? get msg => _msg;
  List<Setting>? get setting => _setting;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['msg'] = _msg;
    if (_setting != null) {
      map['setting'] = _setting?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// title : "What is the minimum quantity for printed wedding cards?"
/// description : "<p>Just 25 cards.</p>\r\n\r\n<p>We understand that you may want to have a smaller wedding and consequently have kept the minimums at just 25pcs. Most designer wedding card companies have a minimum of 100pcs, that seems too high.</p>\r\n"

class Setting {
  Setting({
      String? id, 
      String? title, 
      String? description,}){
    _id = id;
    _title = title;
    _description = description;
}

  Setting.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
  }
  String? _id;
  String? _title;
  String? _description;
Setting copyWith({  String? id,
  String? title,
  String? description,
}) => Setting(  id: id ?? _id,
  title: title ?? _title,
  description: description ?? _description,
);
  String? get id => _id;
  String? get title => _title;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    return map;
  }

}