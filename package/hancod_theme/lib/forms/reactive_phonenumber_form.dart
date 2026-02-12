part of '../forms.dart';

/// Helper function to get the default country code from device locale
IsoCode _getDefaultCountryCode() {
  try {
    // Get the device locale
    final locale = ui.PlatformDispatcher.instance.locale;
    // Extract country code from locale (e.g., 'en_IN' -> 'IN', 'en_US' -> 'US')
    final countryCode = locale.countryCode;
    if (countryCode != null && countryCode.isNotEmpty) {
      // Convert country code to IsoCode
      return IsoCode.fromJson(countryCode);
    }
  } catch (e) {
    // If anything fails, fall back to US
  }
  // Default fallback to US
  return IsoCode.US;
}

class ReactivePhoneNumberForm extends ReactiveFormField<String, String> {
  ReactivePhoneNumberForm({
    super.key,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.valueAccessor,
    super.showErrors,
    this.label,
    this.decoration = const InputDecoration(),
    this.keyboardType,
    this.textInputAction,
    this.countryCode,
  }) : super(
          builder: (field) {
            final state = field as _ReactivePhoneNumberFormState;
            final effectiveDecoration = decoration
                .applyDefaults(Theme.of(state.context).inputDecorationTheme);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (label != null) ...[
                  Text(label),
                  const SizedBox(height: 12),
                ],
                PhoneFormField(
                  controller: state._phoneController,
                  countryButtonStyle: const CountryButtonStyle(
                    showIsoCode: true,
                    flagSize: 16,
                  ),
                  decoration: effectiveDecoration.copyWith(
                    errorText: state.errorText,
                  ),
                  onChanged: (phoneNumber) {
                    field.didChange(phoneNumber.international);
                  },
                  enabled: field.control.enabled,
                  countrySelectorNavigator:
                      const CountrySelectorNavigator.dialog(
                    width: 500,
                    height: 600,
                  ),
                ),
              ],
            );
          },
        );

  final String? label;
  final InputDecoration decoration;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final PhoneNumber? countryCode;

  @override
  ReactiveFormFieldState<String, String> createState() =>
      _ReactivePhoneNumberFormState();
}

class _ReactivePhoneNumberFormState
    extends ReactiveFormFieldState<String, String> {
  late PhoneController _phoneController;

  @override
  void initState() {
    super.initState();
    final widget = this.widget as ReactivePhoneNumberForm;
    final initialValue = control.value ?? widget.countryCode?.international;

    // Get default country code from device locale if no initial value or country code provided
    final defaultIsoCode = widget.countryCode?.isoCode ??
        (initialValue != null ? null : _getDefaultCountryCode());

    _phoneController = PhoneController(
      initialValue: initialValue != null
          ? PhoneNumber.parse(initialValue)
          : PhoneNumber(
              isoCode: defaultIsoCode ?? IsoCode.US,
              nsn: '',
            ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  void onControlValueChanged(dynamic value) {
    String? newValue;

    if (value == null) {
      newValue = null;
    } else if (value is String) {
      newValue = value;
    } else {
      newValue = value.toString();
    }

    // Update the phone controller when the control value changes
    if (newValue != null && newValue.isNotEmpty) {
      try {
        final phoneNumber = PhoneNumber.parse(newValue);
        if (_phoneController.value != phoneNumber) {
          _phoneController.value = phoneNumber;
        }
      } catch (e) {
        // If parsing fails, use default country code from locale
        _phoneController.value = PhoneNumber(
          isoCode: _getDefaultCountryCode(),
          nsn: '',
        );
      }
    } else {
      // Use default country code from locale when clearing
      _phoneController.value = PhoneNumber(
        isoCode: _getDefaultCountryCode(),
        nsn: '',
      );
    }

    super.onControlValueChanged(newValue);
  }

  @override
  ControlValueAccessor<String, String> selectValueAccessor() {
    return _PhoneNumberValueAccessor();
  }
}

class _PhoneNumberValueAccessor extends ControlValueAccessor<String, String> {
  @override
  String? modelToViewValue(String? modelValue) {
    return modelValue;
  }

  @override
  String? viewToModelValue(String? viewValue) {
    return viewValue;
  }
}
