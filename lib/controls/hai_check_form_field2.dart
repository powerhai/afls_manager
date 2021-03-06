import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class CheckboxListTileFormField extends FormField<bool>{
    CheckboxListTileFormField({
    Key key,
    ValueNotifier<bool> persister,
    bool initialValue =false,
      ListTileControlAffinity controlAffinity = ListTileControlAffinity.platform,
      Color activeColor,
      bool dense,
      bool isThreeLine = false,
      Widget secondary,
      bool selected = false,
      Widget title,
      Widget subtitle,
  }) : super(
    key: key,
    initialValue: persister != null? persister.value : initialValue,
    builder: (FormFieldState<bool> field) {
        return new CheckboxListTile(
          value: field.widget.initialValue,
          controlAffinity: controlAffinity,
          activeColor: activeColor,
          dense: dense,
          isThreeLine: isThreeLine,
          secondary: secondary,
          selected: selected,
          title: title,
          subtitle: subtitle,
          onChanged: (bool value) {
            persister.value = value;
            field.didChange(value);
            }
          );
        }
    );
}