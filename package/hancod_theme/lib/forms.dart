import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:hancod_theme/hancod_theme.dart';
import 'package:hancod_theme/multi_file.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:phone_form_field/phone_form_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

part 'forms/app_datetime_form.dart';
part 'forms/app_dropdown_form.dart';
part 'forms/app_text_form.dart';
part 'forms/app_typeahead_form.dart';
part 'forms/reactive_datepicker.dart';
part 'forms/reactive_dropdown.dart';
part 'forms/reactive_filepicker.dart';
part 'forms/reactive_multidropdown.dart';
part 'forms/reactive_radio_button.dart';
part 'forms/reactive_switch.dart';
part 'forms/reactive_text.dart';
part 'forms/reactive_typeahead.dart';
part 'forms/reactive_checkbox.dart';
part 'forms/reactive_phonenumber_form.dart';

extension GenericValidator<T> on T? {
  /// Check if the value is empty in a generic way
  bool emptyValidator() {
    if (this == null) return true;
    if (this is Iterable) return (this! as Iterable).isEmpty;
    if (this is String) return (this! as String).isEmpty;
    if (this is List) return (this! as List).isEmpty;
    if (this is Map) return (this! as Map).isEmpty;
    if (this is Set) return (this! as Set).isEmpty;
    return false;
  }
}
