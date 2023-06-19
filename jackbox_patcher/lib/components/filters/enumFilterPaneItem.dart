import 'package:fluent_ui/fluent_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jackbox_patcher/model/misc/filterEnum.dart';

class EnumFilterPaneItem extends PaneItemHeader {
  EnumFilterPaneItem(
      {required this.icon,
      required this.name,
      required this.onChanged,
      required this.onActivationChanged,
      required this.defaultValue,
      required this.availableValues, 
      required this.activated})
      : super(
            header: EnumFilterPaneItemTitle(
                icon: icon,
                name: name,
                onChanged: onChanged,
                onActivationChanged: onActivationChanged,
                defaultValue: defaultValue,
                availableValues: availableValues, 
                activated: activated));

  final IconData icon;
  final String name;
  final ValueChanged<FilterValue> onChanged;
  final ValueChanged<bool> onActivationChanged;
  final FilterValue defaultValue;
  final List<FilterValue> availableValues;
  final bool activated;
}

class EnumFilterPaneItemTitle extends StatefulWidget {
  EnumFilterPaneItemTitle(
      {Key? key,
      required this.icon,
      required this.name,
      required this.onChanged,
      required this.onActivationChanged,
      required this.defaultValue,
      required this.availableValues, 
      required this.activated})
      : super(key: key);

  final IconData icon;
  final String name;
  final ValueChanged<FilterValue> onChanged;
  final ValueChanged<bool> onActivationChanged;
  final FilterValue defaultValue;
  final List<FilterValue> availableValues;
  final bool activated;

  @override
  State<EnumFilterPaneItemTitle> createState() =>
      _EnumFilterPaneItemTitleState();
}

class _EnumFilterPaneItemTitleState extends State<EnumFilterPaneItemTitle> {
  bool isChecked = false;
  bool activated = false;
  late FilterValue currentValue;

  @override
  void initState() {
    currentValue = widget.defaultValue;
    activated = widget.activated;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Checkbox(
          checked: activated,
          onChanged: (value) {
            widget.onActivationChanged(value!);
            setState(() {
              activated = value;
            });
          }),
      SizedBox(width: 8),
      Icon(widget.icon, color: activated ? null : Colors.grey),
      SizedBox(width: 10),
      Text(widget.name,
          style: TextStyle(color: activated ? null : Colors.grey)),
      Spacer(),
      ComboBox(
        elevation: 0,
       items: widget.availableValues
              .map((e) => ComboBoxItem(value: e, child: Row(children: [
                 Container(
                  width:10,
                  height:10,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: e.color)),
                SizedBox(width: 10),
                 Text(e.name)])))
              .toList(),
          onChanged: activated? (FilterValue? value) {
            widget.onChanged(value!);
            setState(() {
              currentValue = value;
            });
          }:null,
          value: currentValue)
    ]);
  }
}