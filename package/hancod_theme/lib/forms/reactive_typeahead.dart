// Copyright 2020 Vasyl Dytsiak. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

part of '../forms.dart';

/// A [ReactiveTypeAhead] that contains a [TextField].
///
/// This is a convenience widget that wraps a [TextField] widget in a
/// [ReactiveTypeAhead].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveTypeAhead<T, V> extends ReactiveFormField<T, V> {
  /// Creates a [ReactiveTypeAhead] that contains a [TextField].
  ///
  /// Can optionally provide a [formControl] to bind this widget to a control.
  ///
  /// Can optionally provide a [formControlName] to bind this ReactiveFormField
  /// to a [FormControl].
  ///
  /// Must provide one of the arguments [formControl] or a [formControlName],
  /// but not both at the same time.
  ///
  /// Can optionally provide a [validationMessages] argument to customize a
  /// message for different kinds of validation errors.
  ///
  /// Can optionally provide a [valueAccessor] to set a custom value accessors.
  /// See [ControlValueAccessor].
  ///
  /// Can optionally provide a [showErrors] function to customize when to show
  /// validation messages. Reactive Widgets make validation messages visible
  /// when the control is INVALID and TOUCHED, this behavior can be customized
  /// in the [showErrors] function.
  ///
  /// ### Example:
  /// Binds a text field.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveTypeAhead(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveTypeAhead(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveTypeAhead(
  ///   formControlName: 'email',
  ///   validationMessages: {
  ///     ValidationMessage.required: 'The email must not be empty',
  ///     ValidationMessage.email: 'The email must be a valid email',
  ///   }
  /// ),
  /// ```
  ///
  /// Customize when to show up validation messages.
  /// ```dart
  /// ReactiveTypeAhead(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [TextField] class
  /// and [TextField], the constructor.
  ReactiveTypeAhead({
    required this.stringify,
    required Widget Function(BuildContext, V) itemBuilder,
    super.key,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.valueAccessor,
    super.showErrors,
    V Function(String)? viewDataTypeFromTextEditingValue,

    ////////////////////////////////////////////////////////////////////////////
    this.suggestionsCallback,
    Widget Function(BuildContext, Widget)? decorationBuilder,
    Duration debounceDuration = const Duration(milliseconds: 300),
    Widget Function(BuildContext)? loadingBuilder,
    Widget Function(BuildContext)? emptyBuilder,
    Widget Function(BuildContext, Object?)? errorBuilder,
    Widget Function(BuildContext, Animation<double>, Widget)? transitionBuilder,
    Duration animationDuration = const Duration(milliseconds: 500),
    Offset? offset,
    VerticalDirection? direction,
    bool hideOnLoading = false,
    bool hideOnEmpty = false,
    bool hideOnError = false,
    bool hideWithKeyboard = true,
    bool retainOnLoading = true,
    bool hideOnSelect = true,
    bool autoFlipDirection = true,
    SuggestionsController<V>? suggestionsController,
    ScrollController? scrollController,
    bool hideKeyboardOnDrag = false,
    Widget Function(BuildContext, int)? itemSeparatorBuilder,
    Widget Function(BuildContext, List<Widget>)? listBuilder,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical? textAlignVertical,
    TextEditingController? textEditingController,
    TextInputAction? textInputAction,
    bool autofocus = false,
    bool readOnly = false,
    bool? showCursor,
    bool obscureText = false,
    String obscuringCharacter = '•',
    bool autocorrect = true,
    FocusNode? focusNode,
    InputDecoration? decoration,
    void Function(V?)? onSuggestionSelected,
    String? label,
    this.paginateBuilder,
    this.itemLoader,
    this.pageSize = 20,
    this.viewToModel,
    bool isSearchField = false,
    this.refreshOnFormControlChanges,
  })  : assert(suggestionsCallback != null || paginateBuilder != null),
        super(
          builder: (field) {
            final state = field as _ReactiveTypeaheadState<T, V>;
            final effectiveDecoration = (decoration ?? const InputDecoration())
                .applyDefaults(Theme.of(state.context).inputDecorationTheme);

            state._setFocusNode(focusNode);
            final controller = textEditingController ?? state._textController;
            final fieldSuggestionsController =
                suggestionsController ?? state._suggestionsController;

            final isPaginated = paginateBuilder != null;
            // Check if field has a value to prevent suggestions from opening
            final hasValue = field.value != null ||
                (field.control.value != null && !state._isLoadingInitialValue);

            final isRequired = field.control.validators
                .any((validator) => validator is RequiredValidator);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              spacing: 12,
              children: [
                if (label != null)
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: label),
                        if (isRequired)
                          const TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          ),
                      ],
                    ),
                  ),
                TypeAheadField<V>(
                  controller: controller,
                  showOnFocus:
                      !hasValue, // Don't show suggestions on focus when there's a value
                  suggestionsCallback: (pattern) async {
                    // Don't show suggestions if field has a value (read-only)
                    if (hasValue) return [];

                    if (isPaginated) {
                      state._refreshPagination(pattern);
                      return [];
                    } else {
                      return suggestionsCallback!(pattern);
                    }
                  },
                  itemBuilder: isPaginated
                      ? (context, item) => const SizedBox.shrink()
                      : itemBuilder,
                  onSelected: (value) {
                    if (isSearchField) {
                      onSuggestionSelected?.call(value);
                      fieldSuggestionsController.close();
                      controller.clear();
                      return;
                    }

                    if (value == null && isPaginated) {
                      return;
                    }

                    controller.text = stringify(value);
                    field.control.markAsTouched();
                    field.didChange(value);
                    onSuggestionSelected?.call(value);
                    // Close suggestions immediately and remove focus for better UX
                    fieldSuggestionsController.close();
                    focusNode?.unfocus();
                  },
                  hideOnEmpty: !isPaginated && hideOnEmpty,
                  hideOnLoading: !isPaginated && hideOnLoading,
                  hideOnError: !isPaginated && hideOnError,
                  builder: (context, controller, focusNode) {
                    return TextField(
                      controller: controller,
                      focusNode: focusNode,
                      // Prevent focus when there's a value to avoid opening suggestions
                      canRequestFocus: !hasValue,
                      decoration: effectiveDecoration.copyWith(
                        errorText: field.errorText,
                        suffixIcon: state._isLoadingInitialValue
                            ? const Padding(
                                padding: EdgeInsets.all(8),
                                child: SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              )
                            : hasValue && !readOnly
                                ? IconButton(
                                    onPressed: () {
                                      field.control.markAsTouched();
                                      field.didChange(null);
                                      controller.clear();
                                      onSuggestionSelected?.call(null);
                                      state._lastLoadedValue = null;
                                      state._lastLoadedViewValue = null;
                                      fieldSuggestionsController.open();
                                      if (isPaginated) {
                                        state._refreshPagination('');
                                      }
                                    },
                                    icon: const Icon(Icons.clear),
                                  )
                                : effectiveDecoration.suffixIcon,
                      ),
                      enabled: field.control.enabled,
                      style: style,
                      strutStyle: strutStyle,
                      textDirection: textDirection,
                      textAlign: textAlign,
                      textAlignVertical: textAlignVertical,
                      textInputAction: textInputAction,
                      autofocus: autofocus,
                      // Make read-only when there's a value to prevent manual editing
                      // User can clear via the clear button to enable editing again
                      readOnly: readOnly || hasValue,
                      showCursor: showCursor,
                      obscureText: obscureText,
                      obscuringCharacter: obscuringCharacter,
                      autocorrect: autocorrect,
                      onChanged: (value) {
                        field.control.markAsTouched();
                        if (value.isEmpty) {
                          field.didChange(null);
                        } else if (viewDataTypeFromTextEditingValue != null) {
                          field.didChange(
                            viewDataTypeFromTextEditingValue.call(value),
                          );
                        }
                        if (isPaginated) {
                          state._refreshPagination(value, force: true);
                        }
                      },
                    );
                  },
                  decorationBuilder: decorationBuilder ??
                      (context, child) {
                        return Material(
                          type: MaterialType.card,
                          elevation: 4,
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(8),
                          child: child,
                        );
                      },
                  debounceDuration: debounceDuration,
                  suggestionsController: fieldSuggestionsController,
                  loadingBuilder: loadingBuilder,
                  emptyBuilder: isPaginated
                      ? (context) {
                          return Container(
                            constraints: const BoxConstraints(
                              maxHeight: 200,
                            ),
                            child: PagingListener(
                              controller: state._pagingController,
                              builder: (context, state, fetchNextPage) {
                                return PagedListView<int, V>(
                                  state: state,
                                  fetchNextPage: fetchNextPage,
                                  builderDelegate: PagedChildBuilderDelegate<V>(
                                    itemBuilder: (context, item, index) =>
                                        InkWell(
                                      onTap: () {
                                        controller.text = stringify(item);
                                        field.control.markAsTouched();
                                        field.didChange(item);
                                        onSuggestionSelected?.call(item);
                                        // Close suggestions immediately and remove focus for better UX
                                        fieldSuggestionsController.close();
                                        field.focusNode.unfocus();
                                      },
                                      child: itemBuilder(context, item),
                                    ),
                                    firstPageErrorIndicatorBuilder: (context) =>
                                        const Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Center(
                                        child: Text('Error loading data'),
                                      ),
                                    ),
                                    noItemsFoundIndicatorBuilder: (context) =>
                                        emptyBuilder?.call(context) ??
                                        const Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Center(
                                            child: Text('No items found'),
                                          ),
                                        ),
                                    newPageProgressIndicatorBuilder:
                                        (context) => const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                    firstPageProgressIndicatorBuilder:
                                        (context) =>
                                            loadingBuilder?.call(context) ??
                                            const Center(
                                              child: Padding(
                                                padding: EdgeInsets.all(8),
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            ),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      : emptyBuilder,
                  errorBuilder: errorBuilder,
                  transitionBuilder: transitionBuilder,
                  animationDuration: animationDuration,
                  offset: offset ?? const Offset(0, 5),
                  direction: direction,
                  hideWithKeyboard: hideWithKeyboard,
                  retainOnLoading: retainOnLoading,
                  hideOnSelect: hideOnSelect,
                  autoFlipDirection: autoFlipDirection,
                  scrollController: scrollController,
                  hideKeyboardOnDrag: hideKeyboardOnDrag,
                  itemSeparatorBuilder: itemSeparatorBuilder,
                  listBuilder: listBuilder,
                ),
              ],
            );
          },
        );

  final String Function(V value) stringify;
  final FutureOr<List<V>?> Function(String)? suggestionsCallback;
  final Future<List<V>> Function(String query, int page, int pageSize)?
      paginateBuilder;
  final Future<V?> Function(T value)? itemLoader;
  final int pageSize;
  final T Function(V value)? viewToModel;
  final List<String>? refreshOnFormControlChanges;

  Future<V?> Function(T value)? get _effectiveItemLoader => itemLoader;

  @override
  ReactiveFormFieldState<T, V> createState() => _ReactiveTypeaheadState<T, V>();
}

class _ReactiveTypeaheadState<T, V> extends ReactiveFormFieldState<T, V> {
  late TextEditingController _textController;
  late SuggestionsController<V> _suggestionsController;
  late PagingController<int, V> _pagingController;

  String _currentQuery = '';
  bool _isLoadingInitialValue = false;
  T? _lastLoadedValue;
  V? _lastLoadedViewValue; // Store the last loaded view value to restore text if needed
  bool _isHandlingFormStateChange =
      false; // Flag to prevent loops during form enable/disable

  FocusNode? _focusNode;
  late FocusController _focusController;
  final List<StreamSubscription<dynamic>> _formControlSubscriptions = [];

  @override
  FocusNode get focusNode => _focusNode ?? _focusController.focusNode;

  @override
  void initState() {
    super.initState();
    _suggestionsController = SuggestionsController<V>();
    _pagingController = PagingController(
      getNextPageKey: (state) {
        if (state.pages == null) return state.nextIntPageKey;
        return (state.pages!.last.length) <
                (widget as ReactiveTypeAhead<T, V>).pageSize
            ? null
            : state.nextIntPageKey;
      },
      fetchPage: _fetchPage,
    );

    final initialValue = value;
    _textController = TextEditingController(
      text: initialValue == null
          ? ''
          : (widget as ReactiveTypeAhead<T, V>).stringify(initialValue),
    );

    // Schedule async value loading after frame completes
    if (initialValue != null &&
        (widget as ReactiveTypeAhead<T, V>)._effectiveItemLoader != null) {
      _lastLoadedValue = initialValue as T;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _loadValue(initialValue as T);
      });
    }
  }

  Future<void> _loadValue(T val) async {
    // Skip if already loading or already loaded
    if (_isLoadingInitialValue || _lastLoadedValue == val) {
      // If text controller is empty but we have a loaded view value, restore it
      if (_textController.text.isEmpty &&
          _lastLoadedViewValue != null &&
          _lastLoadedValue == val) {
        final widget = this.widget as ReactiveTypeAhead<T, V>;
        _textController.text = widget.stringify(_lastLoadedViewValue as V);
      }
      return;
    }

    if (!mounted) return;

    setState(() {
      _isLoadingInitialValue = true;
    });

    final widget = this.widget as ReactiveTypeAhead<T, V>;
    try {
      if (widget._effectiveItemLoader != null) {
        final result = await widget._effectiveItemLoader!(val);
        if (result != null && mounted) {
          _textController.text = widget.stringify(result);
          // Don't call didChange here - the control value is already correct (it's the model value val)
          // We're just loading the view value to display. Calling didChange would trigger
          // the value accessor again, causing a loop.
          _lastLoadedValue = val;
          _lastLoadedViewValue = result; // Store the view value
        }
      }
    } catch (e) {
      debugPrint('Error loading value: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingInitialValue = false;
        });
      }
    }
  }

  Future<List<V>> _fetchPage(int pageKey) async {
    final widget = this.widget as ReactiveTypeAhead<T, V>;
    if (widget.paginateBuilder == null) return [];

    try {
      return await widget.paginateBuilder!(
        _currentQuery,
        pageKey,
        widget.pageSize,
      );
    } catch (error) {
      rethrow;
    }
  }

  void _refreshPagination(String query, {bool force = false}) {
    if (_currentQuery != query || force) {
      _currentQuery = query;
      _pagingController.refresh();
    }
  }

  @override
  void dispose() {
    for (final subscription in _formControlSubscriptions) {
      subscription.cancel();
    }
    _formControlSubscriptions.clear();
    _pagingController.dispose();
    super.dispose();
  }

  @override
  void subscribeControl() {
    _registerFocusController(FocusController());
    super.subscribeControl();
    // Schedule listener setup after frame to ensure context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _setupFormControlListeners();
      }
    });
  }

  void _setupFormControlListeners() {
    final widget = this.widget as ReactiveTypeAhead<T, V>;
    if (widget.refreshOnFormControlChanges == null ||
        widget.refreshOnFormControlChanges!.isEmpty) {
      return;
    }

    final parent = ReactiveForm.of(context, listen: false);
    if (parent == null || parent is! FormControlCollection) {
      return;
    }

    final collection = parent as FormControlCollection;
    for (final controlName in widget.refreshOnFormControlChanges!) {
      try {
        final formControl = collection.control(controlName);
        final subscription = formControl.valueChanges.listen((_) {
          if (mounted) {
            _refreshPagination(_currentQuery, force: true);
          }
        });
        _formControlSubscriptions.add(subscription);
      } catch (e) {
        debugPrint(
          'Warning: Could not find form control "$controlName" to listen to: $e',
        );
      }
    }
  }

  @override
  void unsubscribeControl() {
    _unregisterFocusController();
    super.unsubscribeControl();
  }

  @override
  void onControlValueChanged(dynamic value) {
    final typeAheadWidget = widget as ReactiveTypeAhead<T, V>;

    // If view value is null but we have a model value (using value accessor),
    // this means the value accessor returned null. This happens when the form
    // is enabled/disabled. We should preserve the text controller's existing
    // text instead of clearing it, and trigger a reload if needed.
    if (value == null && control.value != null) {
      // Prevent loops during form state changes
      if (_isHandlingFormStateChange || _isLoadingInitialValue) {
        super.onControlValueChanged(value);
        return;
      }

      // If text controller already has text and value matches, do nothing
      if (_textController.text.isNotEmpty &&
          _lastLoadedValue == control.value) {
        super.onControlValueChanged(value);
        return;
      }

      // If text controller is empty but we have a stored view value, restore it
      if (typeAheadWidget._effectiveItemLoader != null) {
        if (_textController.text.isEmpty &&
            _lastLoadedViewValue != null &&
            _lastLoadedValue == control.value) {
          _isHandlingFormStateChange = true;
          _textController.text =
              typeAheadWidget.stringify(_lastLoadedViewValue as V);
          // Reset flag after a microtask to allow this change to complete
          Future.microtask(() {
            if (mounted) {
              _isHandlingFormStateChange = false;
            }
          });
        } else if (_lastLoadedValue != control.value) {
          // Only trigger load if value actually changed
          _scheduleLoadValue(control.value as T);
        }
      }
      // Don't clear the text controller - preserve existing text
      super.onControlValueChanged(value);
      return;
    }

    // Reset the flag when we get a non-null value
    _isHandlingFormStateChange = false;

    // Only update text controller if we have a non-null value
    final effectiveValue =
        value == null ? '' : typeAheadWidget.stringify(value as V);

    // Only update if the text is actually different to avoid unnecessary updates
    if (_textController.text != effectiveValue) {
      _textController.value = _textController.value.copyWith(
        text: effectiveValue,
        selection: TextSelection.collapsed(offset: effectiveValue.length),
        composing: TextRange.empty,
      );
    }

    super.onControlValueChanged(value);
  }

  @override
  ControlValueAccessor<T, V> selectValueAccessor() {
    if ((widget as ReactiveTypeAhead<T, V>).viewToModel != null) {
      return _TypeAheadValueAccessor<T, V>(
        (widget as ReactiveTypeAhead<T, V>).viewToModel!,
        _scheduleLoadValue,
      );
    }
    return super.selectValueAccessor();
  }

  void _scheduleLoadValue(T val) {
    // Schedule load after current frame to avoid setState during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadValue(val);
    });
  }

  void _registerFocusController(FocusController focusController) {
    _focusController = focusController;
    control.registerFocusController(focusController);
  }

  void _unregisterFocusController() {
    control.unregisterFocusController(_focusController);
    _focusController.dispose();
  }

  void _setFocusNode(FocusNode? focusNode) {
    if (_focusNode != focusNode) {
      _focusNode = focusNode;
      _unregisterFocusController();
      _registerFocusController(FocusController(focusNode: _focusNode));
    }
  }
}

class _TypeAheadValueAccessor<T, V> extends ControlValueAccessor<T, V> {
  _TypeAheadValueAccessor(this.viewToModel, this.loadValueCallback);

  final T Function(V value) viewToModel;
  final void Function(T value) loadValueCallback;

  @override
  V? modelToViewValue(T? modelValue) {
    if (modelValue == null) return null;

    // Schedule load asynchronously to avoid setState during build
    loadValueCallback(modelValue);

    // Return null temporarily; loadValueCallback will update the field
    return null;
  }

  @override
  T? viewToModelValue(V? viewValue) {
    if (viewValue == null) return null;
    return viewToModel(viewValue);
  }
}
