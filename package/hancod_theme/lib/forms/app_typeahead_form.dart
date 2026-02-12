// ignore_for_file: strict_raw_type

part of '../forms.dart';

typedef SelectionToTextTransformer<T> = String Function(T suggestion);
typedef PaginatedSuggestionsCallback<T> = FutureOr<List<T>?> Function(
  String query,
  int pageNumber,
  int pageSize,
);

/// Text field that auto-completes user input from a list of items
class AppTypeAheadForm<T> extends FormBuilderFieldDecoration<T> {
  AppTypeAheadForm({
    required super.name,
    required this.itemBuilder,
    this.suggestionsCallback,
    this.paginatedSuggestionsCallback,
    this.label,
    super.key,
    super.autovalidateMode,
    super.enabled,
    super.focusNode,
    super.onSaved,
    super.validator,
    super.decoration,
    super.initialValue,
    super.onChanged,
    super.valueTransformer,
    super.onReset,
    this.animationDuration = const Duration(milliseconds: 500),
    this.autoFlipDirection = true,
    this.controller,
    this.debounceDuration = const Duration(milliseconds: 300),
    this.direction,
    this.suggestionErrorBuilder,
    this.hideOnUnfocus = true,
    this.hideOnEmpty = false,
    this.hideOnError = false,
    this.hideOnLoading = false,
    this.hideWithKeyboard = true,
    this.retainOnLoading = true,
    this.hideOnSelect = true,
    this.loadingBuilder,
    this.emptyBuilder,
    this.onSelected,
    this.scrollController,
    this.selectionToTextTransformer,
    this.suggestionsController,
    this.decorationBuilder,
    this.offset,
    this.customTextField,
    this.transitionBuilder,
    this.autoFlipListDirection = true,
    this.autoFlipMinHeight = 64.0,
    this.hideKeyboardOnDrag = false,
    this.itemSeparatorBuilder,
    this.listBuilder,
    this.showOnFocus = true,
    this.constraints,
    this.enableInfiniteScroll = false,
    this.pageSize = 20,
    this.loadMoreThreshold = 0.8,
    this.showSelectedState = true,
    this.selectedStateBuilder,
    this.clearButtonBuilder,
    this.selectedStateDecoration,
    this.selectedStateStyle,
  })  : assert(T == String || selectionToTextTransformer != null),
        assert(
          suggestionsCallback != null || paginatedSuggestionsCallback != null,
          'Either suggestionsCallback or paginatedSuggestionsCallback must be provided',
        ),
        assert(
          !enableInfiniteScroll || paginatedSuggestionsCallback != null,
          'When enableInfiniteScroll is true, paginatedSuggestionsCallback must be provided',
        ),
        super(
          builder: (FormFieldState<T?> field) {
            final state = field as AppTypeAheadFormState<T>;
            final theme = Theme.of(state.context);

            return TypeAheadField<T>(
              controller: state._typeAheadController,
              focusNode: state.effectiveFocusNode,
              showOnFocus:
                  showOnFocus && (state.value == null || !showSelectedState),
              constraints: constraints,
              builder: (context, controller, focusNode) {
                // Show selected state if value is selected and showSelectedState is enabled
                if (showSelectedState && state.value != null) {
                  return state._buildSelectedState(context, state.value as T,
                      () {
                    state.didChange(null);
                    controller.clear();
                    focusNode.requestFocus();
                  });
                }

                return customTextField != null
                    ? customTextField.copyWith(
                        enabled: state.enabled,
                        controller: controller,
                        focusNode: focusNode,
                        decoration: state.decoration,
                        style: state.enabled
                            ? customTextField.style
                            : theme.textTheme.titleMedium!.copyWith(
                                color: theme.disabledColor,
                              ),
                      )
                    : TextField(
                        enabled: state.enabled,
                        controller: controller,
                        focusNode: focusNode,
                        decoration: state.decoration,
                        style: state.enabled
                            ? theme.textTheme.titleMedium
                            : theme.textTheme.titleMedium!.copyWith(
                                color: theme.disabledColor,
                              ),
                      );
              },
              autoFlipMinHeight: autoFlipMinHeight,
              hideKeyboardOnDrag: hideKeyboardOnDrag,
              itemSeparatorBuilder: itemSeparatorBuilder,
              listBuilder: listBuilder,
              suggestionsCallback:
                  enableInfiniteScroll && paginatedSuggestionsCallback != null
                      ? state._handlePaginatedSuggestions
                      : suggestionsCallback ?? ((_) => null),
              itemBuilder: itemBuilder,
              transitionBuilder: (context, animation, child) => child,
              onSelected: (T suggestion) {
                state.didChange(suggestion);
                onSelected?.call(suggestion);
              },
              errorBuilder: suggestionErrorBuilder,
              emptyBuilder: emptyBuilder,
              loadingBuilder: loadingBuilder,
              debounceDuration: debounceDuration,
              decorationBuilder: decorationBuilder ??
                  (context, child) => Material(
                        type: MaterialType.card,
                        elevation: 4,
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8),
                        child: child,
                      ),
              offset: offset,
              animationDuration: animationDuration,
              direction: direction,
              hideOnLoading: hideOnLoading,
              hideOnEmpty: hideOnEmpty,
              hideOnError: hideOnError,
              hideWithKeyboard: hideWithKeyboard,
              retainOnLoading: retainOnLoading,
              autoFlipDirection: autoFlipDirection,
              suggestionsController: enableInfiniteScroll
                  ? state._suggestionsController
                  : suggestionsController,
              hideOnSelect: hideOnSelect,
              hideOnUnfocus: hideOnUnfocus,
              scrollController: enableInfiniteScroll
                  ? state._scrollController
                  : scrollController,
            );
          },
        );
  final FutureOr<List<T>?> Function(String)? suggestionsCallback;
  final PaginatedSuggestionsCallback<T>? paginatedSuggestionsCallback;
  final bool enableInfiniteScroll;
  final int pageSize;
  final double loadMoreThreshold;
  final bool showSelectedState;
  final Widget Function(BuildContext context, T value, VoidCallback onClear)?
      selectedStateBuilder;
  final Widget Function(VoidCallback onClear)? clearButtonBuilder;
  final BoxDecoration? selectedStateDecoration;
  final TextStyle? selectedStateStyle;
  final void Function(T)? onSelected;
  final Widget Function(BuildContext, T) itemBuilder;
  final Widget Function(BuildContext, Widget)? decorationBuilder;
  final SuggestionsController<T>? suggestionsController;
  final Duration debounceDuration;
  final WidgetBuilder? loadingBuilder;
  final WidgetBuilder? emptyBuilder;
  final Widget Function(BuildContext context, Object error)?
      suggestionErrorBuilder;
  final Widget Function(BuildContext, Animation<double>, Widget)?
      transitionBuilder;
  final Duration animationDuration;
  final VerticalDirection? direction;
  final String? label;

  /// Custom text field to use instead of the default [TextField]
  ///
  /// When use this parameter, FormBuilderTypeAhead will be override the
  /// following properties:
  ///
  /// - enabled
  /// - decoration
  /// - controller
  /// - focusNode
  /// - style.disabled
  final TextField? customTextField;
  final Offset? offset;
  final bool hideOnLoading;
  final bool hideOnEmpty;
  final bool hideOnError;
  final bool hideWithKeyboard;
  final bool retainOnLoading;
  final bool hideOnSelect;
  final bool autoFlipDirection;
  final SelectionToTextTransformer<T>? selectionToTextTransformer;
  final TextEditingController? controller;
  final bool hideOnUnfocus;
  final ScrollController? scrollController;
  final IndexedWidgetBuilder? itemSeparatorBuilder;
  final Widget Function(BuildContext, List<Widget>)? listBuilder;
  final bool autoFlipListDirection;
  final double autoFlipMinHeight;
  final bool hideKeyboardOnDrag;
  final bool showOnFocus;
  final BoxConstraints? constraints;

  @override
  AppTypeAheadFormState<T> createState() => AppTypeAheadFormState<T>();

  /// Get access to the suggestions controller for advanced functionality
  /// Only available when enableInfiniteScroll is true
  SuggestionsController<T>? getSuggestionsController(BuildContext context) {
    if (!enableInfiniteScroll) return null;
    final state = context.findAncestorStateOfType<AppTypeAheadFormState<T>>();
    return state?._suggestionsController;
  }
}

class AppTypeAheadFormState<T>
    extends FormBuilderFieldDecorationState<AppTypeAheadForm<T>, T> {
  late TextEditingController _typeAheadController;
  ScrollController? _scrollController;
  SuggestionsController<T>? _suggestionsController;

  // Pagination state
  int _currentPage = 1;
  bool _isLoadingMore = false;
  bool _hasMoreData = true;
  String _lastQuery = '';

  @override
  void initState() {
    super.initState();
    _typeAheadController = widget.controller ??
        TextEditingController(text: _getTextString(initialValue));

    if (widget.enableInfiniteScroll) {
      _scrollController = ScrollController();
      _scrollController!.addListener(_onScroll);
      _suggestionsController =
          widget.suggestionsController ?? SuggestionsController<T>();
    }
  }

  @override
  void didChange(T? value) {
    super.didChange(value);
    final text = _getTextString(value);

    if (_typeAheadController.text != text) {
      _typeAheadController.text = text;
    }
  }

  @override
  void dispose() {
    // Dispose the _typeAheadController when initState created it
    if (widget.enableInfiniteScroll) {
      _scrollController?.removeListener(_onScroll);
      _scrollController?.dispose();
      // Only dispose if we created the controller (not provided externally)
      if (widget.suggestionsController == null) {
        _suggestionsController?.dispose();
      }
    }
    super.dispose();
    _typeAheadController.dispose();
  }

  @override
  void reset() {
    super.reset();
    _typeAheadController.text = _getTextString(initialValue);

    if (widget.enableInfiniteScroll) {
      _resetPagination();
    }
  }

  String _getTextString(T? value) {
    final text = value == null
        ? ''
        : widget.selectionToTextTransformer != null
            ? widget.selectionToTextTransformer!(value)
            : value.toString();

    return text;
  }

  // Pagination methods for infinite scroll
  void _resetPagination() {
    _currentPage = 1;
    _isLoadingMore = false;
    _hasMoreData = true;
    _lastQuery = '';
    _suggestionsController?.suggestions = null;
    _suggestionsController?.refresh();
  }

  void _onScroll() {
    if (!widget.enableInfiniteScroll ||
        _isLoadingMore ||
        !_hasMoreData ||
        _scrollController == null) {
      return;
    }

    final maxScroll = _scrollController!.position.maxScrollExtent;
    final currentScroll = _scrollController!.position.pixels;
    final threshold = maxScroll * widget.loadMoreThreshold;

    if (currentScroll >= threshold) {
      _loadMoreData();
    }
  }

  Future<void> _loadMoreData() async {
    if (_isLoadingMore || !_hasMoreData || _suggestionsController == null) {
      return;
    }

    _isLoadingMore = true;
    _suggestionsController!.isLoading = true;
    _currentPage++;

    try {
      final newItems = await widget.paginatedSuggestionsCallback!(
        _lastQuery,
        _currentPage,
        widget.pageSize,
      );

      if (newItems == null || newItems.isEmpty) {
        _hasMoreData = false;
      } else {
        // Append new items to existing suggestions
        final currentSuggestions = _suggestionsController!.suggestions ?? <T>[];
        _suggestionsController!.suggestions = [
          ...currentSuggestions,
          ...newItems,
        ];

        if (newItems.length < widget.pageSize) {
          _hasMoreData = false;
        }
      }
    } catch (error) {
      _suggestionsController!.error = error;
    } finally {
      _isLoadingMore = false;
      _suggestionsController!.isLoading = false;
    }
  }

  Future<List<T>?> _handlePaginatedSuggestions(String query) async {
    if (_suggestionsController == null) return null;

    // Reset pagination if query changed
    if (query != _lastQuery) {
      _resetPagination();
      _lastQuery = query;
    }

    // Load first page if no data
    final currentSuggestions = _suggestionsController!.suggestions;
    if ((currentSuggestions == null || currentSuggestions.isEmpty) &&
        !_isLoadingMore) {
      _isLoadingMore = true;
      _suggestionsController!.isLoading = true;

      try {
        final firstPageItems = await widget.paginatedSuggestionsCallback!(
          query,
          _currentPage,
          widget.pageSize,
        );

        if (firstPageItems != null && firstPageItems.isNotEmpty) {
          _suggestionsController!.suggestions = firstPageItems;
          if (firstPageItems.length < widget.pageSize) {
            _hasMoreData = false;
          }
        } else {
          _hasMoreData = false;
          _suggestionsController!.suggestions = <T>[];
        }
      } catch (error) {
        _suggestionsController!.error = error;
        _suggestionsController!.suggestions = <T>[];
      } finally {
        _isLoadingMore = false;
        _suggestionsController!.isLoading = false;
      }
    }

    return _suggestionsController!.suggestions;
  }

  /// Build the selected state UI
  Widget _buildSelectedState(
    BuildContext context,
    T value,
    VoidCallback onClear,
  ) {
    final theme = Theme.of(context);

    // Use custom builder if provided
    if (widget.selectedStateBuilder != null) {
      return widget.selectedStateBuilder!(context, value, onClear);
    }

    // Default selected state UI
    final displayText = widget.selectionToTextTransformer != null
        ? widget.selectionToTextTransformer!(value)
        : value.toString();

    return InputDecorator(
      decoration: const InputDecoration(),
      child: Row(
        children: [
          Expanded(
            child: Text(
              displayText,
              style: widget.selectedStateStyle ??
                  theme.textTheme.titleMedium?.copyWith(
                    color: widget.enabled
                        ? theme.colorScheme.onSurface
                        : theme.disabledColor,
                  ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (widget.enabled) ...[
            const SizedBox(width: 8),
            _buildClearButton(onClear),
          ],
        ],
      ),
    );
  }

  /// Build the clear button
  Widget _buildClearButton(VoidCallback onClear) {
    // Use custom builder if provided
    if (widget.clearButtonBuilder != null) {
      return widget.clearButtonBuilder!(onClear);
    }

    // Default clear button
    return InkWell(
      onTap: onClear,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(4),
        child: Icon(
          Icons.close,
          size: 16,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 12),
        ],
        super.build(context),
      ],
    );
  }
}
