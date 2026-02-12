
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hancod_theme/forms/app_form.dart';
import 'package:phone_form_field/phone_form_field.dart';

class AppPhoneNumberForm extends AppForm<String> {
  const AppPhoneNumberForm({
    required super.name,
    super.key,
    super.validator,
    this.mobileValidator,
    super.label,
    PhoneNumber? super.initialValue,
    super.fieldKey,
    this.onChanged,
    this.required = false,
    this.decoration = const InputDecoration(),
    this.onFieldSubmitted,
    super.enabled = true,
  });

  final void Function(String?)? onChanged;
  final bool required;
  final String? Function(PhoneNumber?)? mobileValidator;
  final void Function(String value)? onFieldSubmitted;
  final InputDecoration decoration;
  @override
  State<AppPhoneNumberForm> createState() => _AppPhoneNumberFormState();
}

class _AppPhoneNumberFormState extends State<AppPhoneNumberForm> {
  @override
  Widget build(BuildContext context) {
    return widget.buildContainer(
      context,
      FormBuilderField<String>(
        enabled: widget.enabled,
        name: widget.name,
        validator: widget.validator,
        onChanged: widget.onChanged,
        initialValue: (widget.initialValue as PhoneNumber?)?.international,
        builder: (FormFieldState<String> field) {
          return PhoneFormField(
            enabled: widget.enabled,
            initialValue: widget.initialValue as PhoneNumber?,
            validator: widget.mobileValidator,
            decoration: widget.decoration,
            onChanged: (phoneNumber) {
              field.didChange(phoneNumber.international);
            },
            onSubmitted: (phoneNumber) {
              widget.onFieldSubmitted?.call(phoneNumber.international);
            },
            countrySelectorNavigator: const CountrySelectorNavigator.dialog(
              height: 600,
              width: 500,
            ),
            countryButtonStyle: const CountryButtonStyle(
              showIsoCode: true,
              flagSize: 16,
            ),
          );
        },
      ),
    );
  }
}
