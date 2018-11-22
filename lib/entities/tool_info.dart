import 'package:json_annotation/json_annotation.dart';
import 'epg_detail_info.dart';

class ToolInfo extends Object{

  String label;
  String icon;
  int action;

  ToolInfo(this.label,  this.icon, this.action);

  @override
  String toString() {
    return 'ToolInfo{label: $label, icon: $icon, action: $action}';
  }


}