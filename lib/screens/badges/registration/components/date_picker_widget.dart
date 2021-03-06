import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerWidget extends StatelessWidget {
  final DateTime? date;
  final Function(DateTime?) onChanged;
  final String? Function(DateTime?) validator;

  const DatePickerWidget(
      {Key? key, required this.date, required this.onChanged, required this.validator})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final monthFormat = DateFormat.MMMM('da');

    void datePicker() async {
      onChanged(await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000, 1, 1),
          lastDate: DateTime.now(),
          locale: Locale('da', 'DK')));
    }

    return Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
        child: Material(
            color: Colors.white,
            elevation: 10.0,
            shadowColor: Color.fromRGBO(0, 0, 0, 25),
            borderRadius: BorderRadius.circular(15),
            child: SizedBox(
              height: 51,
              child: TextFormField(
                validator: (string) => validator(date),
                controller: null,
                obscureText: true,
                obscuringCharacter: ' ',
                readOnly: true,
                textAlign: TextAlign.right,
                style: theme.textTheme.bodyText1,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  errorStyle: theme.textTheme.bodyText2!.copyWith(height: 0),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 8, 8, 8),
                    child: Text(
                      date != null
                          ? '${DateFormat.d().format(date!)}. ${monthFormat.format(date!)} ${DateFormat.y().format(date!)}'
                          : 'Dato',
                      style: theme.primaryTextTheme.bodyText1!.copyWith(fontSize: 16),
                    ),
                  ),
                  prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                  suffixIcon: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 25, 0),
                      child: GestureDetector(
                        onTap: () => datePicker(),
                        child: Text(
                          date != null ? '??ndre' : 'V??lg',
                          style: theme.primaryTextTheme.bodyText1!.copyWith(fontSize: 16),
                        ),
                      )),
                  suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                  focusColor: Colors.grey,
                  filled: true,
                  border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                ),
              ),
            )));
  }
}
