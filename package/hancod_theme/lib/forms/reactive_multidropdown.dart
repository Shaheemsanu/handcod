// ignore_for_file: deprecated_member_use

part of '../forms.dart';

/// A [ReactiveMultiDropdown] that allows selecting multiple items from a paginated list.
///
/// [T] is the type of the Value (e.g., int ID, String ID).
/// [V] is the type of the View Object (e.g., User object, Product object).
class ReactiveMultiDropdown<T, V> extends ReactiveFormField<List<T>, List<V>> {
  /// Creates a [ReactiveMultiDropdown].
  ///
  /// [itemBuilder] builds the list rows in the dropdown.
  /// [viewToModel] extracts the ID (T) from the Object (V).
  /// [itemLoader] loads Objects (V) given a list of IDs (T). Used for initial values.
  /// [paginateBuilder] fetches pages of data.
  /// [stringify] converts an Object (V) to a String for the Chip display.
  ReactiveMultiDropdown({
    // Required Logic
    required this.itemBuilder,
    required this.viewToModel,
    required this.itemLoader,
    required this.paginateBuilder,
    required this.stringify,
    super.key,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.showErrors,
    super.focusNode,

    // UI Configuration
    this.label,
    this.decoration = const InputDecoration(),
    this.chipDecoration,
    this.chipTextStyle,
    this.deleteIcon,
    this.dropdownDecoration,

    // Dropdown Configuration
    this.pageSize = 20,
    this.maxSelections,
    this.searchEnabled = true,
    this.searchDecoration,
    this.debounceDuration = const Duration(milliseconds: 300),
    this.dropdownMaxHeight = 300.0,
    this.enableSearchAutofocus = true,

    // Builders
    this.loadingBuilder,
    this.emptyBuilder,
    this.errorBuilder,
    this.selectedItemBuilder,
  }) : super(
          builder: (field) {
            final state = field as _ReactiveMultiDropdownState<T, V>;
            final effectiveDecoration = decoration
                .applyDefaults(Theme.of(state.context).inputDecorationTheme);

            // Use state._selectedItems instead of field.value for display
            // because field.value might be null or desynced during async updates.
            final displayItems = state._selectedItems;

            return Listener(
              onPointerDown: (_) {
                if (field.control.enabled) {
                  field.control.markAsTouched();
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (label != null) ...[
                    Text(
                      label,
                      style: Theme.of(state.context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                  ],
                  CompositedTransformTarget(
                    link: state._layerLink,
                    child: OverlayPortal(
                      controller: state._overlayController,
                      overlayChildBuilder: (context) => _DropdownOverlay<T, V>(
                        state: state,
                        maxHeight: dropdownMaxHeight,
                      ),
                      child: InkWell(
                        onTap: field.control.enabled
                            ? state._toggleDropdown
                            : null,
                        focusNode: state._focusNode,
                        borderRadius: BorderRadius.circular(4),
                        child: InputDecorator(
                          isFocused: state._isOverlayOpen,
                          isEmpty: displayItems.isEmpty,
                          decoration: effectiveDecoration.copyWith(
                            errorText: field.errorText,
                            suffixIcon: state._isLoadingInitial
                                ? const Padding(
                                    padding: EdgeInsets.all(12),
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  )
                                : const Icon(Icons.arrow_drop_down),
                          ),
                          child: _SelectedItemsList<V>(
                            items: displayItems,
                            stringify: stringify,
                            onDelete: field.control.enabled
                                ? state._removeItem
                                : null,
                            chipDecoration: chipDecoration,
                            chipTextStyle: chipTextStyle,
                            deleteIcon: deleteIcon,
                            customBuilder: selectedItemBuilder,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );

  final Widget Function(BuildContext context, V item, bool isSelected)
      itemBuilder;
  final T Function(V value) viewToModel;
  final Future<List<V>> Function(List<T> ids) itemLoader;
  final Future<List<V>> Function(String query, int page, int pageSize)
      paginateBuilder;
  final String Function(V value) stringify;

  final String? label;
  final InputDecoration decoration;
  final BoxDecoration? chipDecoration;
  final TextStyle? chipTextStyle;
  final Widget? deleteIcon;
  final BoxDecoration? dropdownDecoration;

  final int pageSize;
  final int? maxSelections;
  final bool searchEnabled;
  final InputDecoration? searchDecoration;
  final Duration debounceDuration;
  final double dropdownMaxHeight;
  final bool enableSearchAutofocus;

  final Widget Function(BuildContext)? loadingBuilder;
  final Widget Function(BuildContext)? emptyBuilder;
  final Widget Function(BuildContext, Object?)? errorBuilder;
  final Widget Function(BuildContext, V)? selectedItemBuilder;

  @override
  ReactiveFormFieldState<List<T>, List<V>> createState() =>
      _ReactiveMultiDropdownState<T, V>();
}

class _ReactiveMultiDropdownState<T, V>
    extends ReactiveFormFieldState<List<T>, List<V>> {
  final LayerLink _layerLink = LayerLink();
  final OverlayPortalController _overlayController = OverlayPortalController();
  late FocusNode _focusNode;

  late PagingController<int, V> _pagingController;
  String _currentQuery = '';
  bool _isLoadingInitial = false;

  // Local state to track View Objects independently of Control Value
  List<V> _selectedItems = [];

  bool get _isOverlayOpen => _overlayController.isShowing;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _pagingController = PagingController(
      getNextPageKey: (state) {
        if (state.pages == null) return state.nextIntPageKey;
        return (state.pages!.last.length) <
                (widget as ReactiveMultiDropdown<T, V>).pageSize
            ? null
            : state.nextIntPageKey;
      },
      fetchPage: _fetchPage,
    );

    // Initial load from control value
    final initialValue = control.value;
    if (initialValue != null && initialValue.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _syncModelToView(initialValue);
      });
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  ControlValueAccessor<List<T>, List<V>> selectValueAccessor() {
    return _MultiDropdownValueAccessor<T, V>(
      (widget as ReactiveMultiDropdown<T, V>).viewToModel,
    );
  }

  void _toggleDropdown() {
    if (_isOverlayOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    _pagingController.refresh();
    _overlayController.show();
    _focusNode.requestFocus();
    if (mounted) setState(() {});
  }

  void _closeDropdown() {
    _overlayController.hide();
    _currentQuery = '';
    _focusNode.unfocus();
    if (mounted) setState(() {});
  }

  Future<List<V>> _fetchPage(int pageKey) async {
    final widget = this.widget as ReactiveMultiDropdown<T, V>;
    try {
      return await widget.paginateBuilder(
        _currentQuery,
        pageKey,
        widget.pageSize,
      );
    } catch (error) {
      rethrow;
    }
  }

  void _onSearchChanged(String query) {
    if (_currentQuery == query) return;
    _currentQuery = query;
    _pagingController.refresh();
  }

  void _toggleItem(V item) {
    final widget = this.widget as ReactiveMultiDropdown<T, V>;
    final currentList = List<V>.from(_selectedItems);
    final itemId = widget.viewToModel(item);

    final index =
        currentList.indexWhere((e) => widget.viewToModel(e) == itemId);

    if (index >= 0) {
      currentList.removeAt(index);
    } else {
      if (widget.maxSelections != null &&
          currentList.length >= widget.maxSelections!) {
        return;
      }
      currentList.add(item);
    }

    _updateSelectedItems(currentList, updateControl: true);
  }

  void _removeItem(V item) {
    final widget = this.widget as ReactiveMultiDropdown<T, V>;
    final currentList = List<V>.from(_selectedItems)
      ..removeWhere((e) => widget.viewToModel(e) == widget.viewToModel(item));

    _updateSelectedItems(currentList, updateControl: true);
  }

  // ignore: must_call_super
  @override
  void onControlValueChanged(dynamic value) {
    super.onControlValueChanged(value);
    final newIds = value as List<T>?;
    // Only sync if IDs mismatch what we currently show
    if (newIds == null || newIds.isEmpty) {
      if (_selectedItems.isNotEmpty) {
        _updateSelectedItems([], updateControl: false);
      }
      return;
    }

    final widget = this.widget as ReactiveMultiDropdown<T, V>;
    final currentIds = _selectedItems.map(widget.viewToModel).toList();

    // Simple equality check for lists
    if (newIds.length == currentIds.length &&
        newIds.every(currentIds.contains)) {
      return; // No change in IDs
    }

    _syncModelToView(newIds);
  }

  /// Updates local state and optionally the control value
  void _updateSelectedItems(List<V> items, {required bool updateControl}) {
    if (mounted) {
      setState(() {
        _selectedItems = items;
      });
    }

    if (updateControl) {
      // This triggers onControlValueChanged, so we must ensure equality check passes
      didChange(items);
    }
  }

  Future<void> _syncModelToView(List<T> newIds) async {
    final widget = this.widget as ReactiveMultiDropdown<T, V>;
    final idsToLoad = <T>[];
    final newViewItems = <V>[];

    // 1. Try to find objects in current selection
    for (final id in newIds) {
      V? found;
      try {
        found = _selectedItems.firstWhereOrNull(
          (v) => widget.viewToModel(v) == id,
        );
      } catch (_) {}

      // 2. Try to find in pagination cache
      if (found == null && _pagingController.items != null) {
        try {
          found = _pagingController.items!.firstWhereOrNull(
            (v) => widget.viewToModel(v) == id,
          );
        } catch (_) {}
      }

      if (found != null) {
        newViewItems.add(found);
      } else {
        idsToLoad.add(id);
      }
    }

    if (idsToLoad.isEmpty) {
      _updateSelectedItems(newViewItems, updateControl: false);
    } else {
      _loadMissingItems(newViewItems, idsToLoad);
    }
  }

  Future<void> _loadMissingItems(List<V> existing, List<T> missingIds) async {
    if (_isLoadingInitial) return;
    if (!mounted) return;

    setState(() => _isLoadingInitial = true);
    final widget = this.widget as ReactiveMultiDropdown<T, V>;

    try {
      final loaded = await widget.itemLoader(missingIds);
      final combined = [...existing, ...loaded];
      _updateSelectedItems(combined, updateControl: false);
    } catch (e) {
      debugPrint('ReactiveMultiDropdown Error loading items: $e');
    } finally {
      if (mounted) setState(() => _isLoadingInitial = false);
    }
  }
}

class _DropdownOverlay<T, V> extends StatelessWidget {
  const _DropdownOverlay({
    required this.state,
    required this.maxHeight,
  });
  final _ReactiveMultiDropdownState<T, V> state;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    final widget = state.widget as ReactiveMultiDropdown<T, V>;
    final renderBox = state.context.findRenderObject() as RenderBox?;

    if (renderBox == null || !renderBox.attached) return const SizedBox();

    final width = renderBox.size.width;
    final offset = renderBox.localToGlobal(Offset.zero);
    final screenHeight = MediaQuery.of(context).size.height;

    final spaceBottom = screenHeight - offset.dy - renderBox.size.height;
    final showAbove = spaceBottom < maxHeight && offset.dy > maxHeight;

    final verticalOffset =
        showAbove ? -(maxHeight + 5) : (renderBox.size.height + 5);

    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: state._closeDropdown,
            child: Container(color: Colors.transparent),
          ),
        ),
        CompositedTransformFollower(
          link: state._layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, verticalOffset),
          child: Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(8),
              clipBehavior: Clip.antiAlias,
              color: AppColors.white,
              child: Container(
                width: width,
                height: maxHeight,
                decoration: widget.dropdownDecoration ??
                    BoxDecoration(
                      border: Border.all(color: Theme.of(context).dividerColor),
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.white,
                    ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.searchEnabled)
                      _DropdownSearchField(
                        hintText: 'Search...',
                        decoration: widget.searchDecoration,
                        debounceDuration: widget.debounceDuration,
                        onChanged: state._onSearchChanged,
                        autoFocus: widget.enableSearchAutofocus,
                      ),
                    if (widget.searchEnabled) const Divider(height: 1),
                    Expanded(
                      child: PagingListener(
                        controller: state._pagingController,
                        builder: (context, pagingState, fetchNextPage) {
                          return PagedListView<int, V>(
                            state: pagingState,
                            fetchNextPage: fetchNextPage,
                            padding: EdgeInsets.zero,
                            builderDelegate: PagedChildBuilderDelegate<V>(
                              itemBuilder: (context, item, index) {
                                final itemId = widget.viewToModel(item);
                                final isSelected = state._selectedItems.any(
                                  (selected) =>
                                      widget.viewToModel(selected) == itemId,
                                );

                                return InkWell(
                                  onTap: () => state._toggleItem(item),
                                  child: widget.itemBuilder(
                                    context,
                                    item,
                                    isSelected,
                                  ),
                                );
                              },
                              firstPageProgressIndicatorBuilder:
                                  widget.loadingBuilder,
                              newPageProgressIndicatorBuilder:
                                  widget.loadingBuilder,
                              noItemsFoundIndicatorBuilder:
                                  widget.emptyBuilder ??
                                      (_) => const Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(16),
                                              child: Text('No items found'),
                                            ),
                                          ),
                              firstPageErrorIndicatorBuilder: (ctx) =>
                                  widget.errorBuilder
                                      ?.call(ctx, pagingState.error) ??
                                  const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Text('Error loading data'),
                                    ),
                                  ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DropdownSearchField extends StatefulWidget {
  const _DropdownSearchField({
    required this.hintText,
    required this.onChanged,
    required this.debounceDuration,
    required this.autoFocus,
    this.decoration,
  });
  final String hintText;
  final ValueChanged<String> onChanged;
  final Duration debounceDuration;
  final InputDecoration? decoration;
  final bool autoFocus;

  @override
  State<_DropdownSearchField> createState() => _DropdownSearchFieldState();
}

class _DropdownSearchFieldState extends State<_DropdownSearchField> {
  Timer? _debounce;
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(widget.debounceDuration, () {
      widget.onChanged(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        controller: _controller,
        onChanged: _onChanged,
        autofocus: widget.autoFocus,
        style: theme.textTheme.bodyMedium,
        decoration: (widget.decoration ??
                const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  border: OutlineInputBorder(),
                  isDense: true,
                ))
            .copyWith(hintText: widget.hintText),
      ),
    );
  }
}

class _SelectedItemsList<V> extends StatelessWidget {
  const _SelectedItemsList({
    required this.items,
    required this.stringify,
    this.onDelete,
    this.chipDecoration,
    this.chipTextStyle,
    this.deleteIcon,
    this.customBuilder,
  });
  final List<V> items;
  final String Function(V) stringify;
  final void Function(V)? onDelete;
  final BoxDecoration? chipDecoration;
  final TextStyle? chipTextStyle;
  final Widget? deleteIcon;
  final Widget Function(BuildContext, V)? customBuilder;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: items.map((item) {
        if (customBuilder != null) {
          return GestureDetector(
            onTap: onDelete != null ? () => onDelete!(item) : null,
            child: customBuilder!(context, item),
          );
        }

        return Container(
          decoration: chipDecoration ??
              BoxDecoration(
                color: AppColors.grey.withOpacity(.2),
                borderRadius: BorderRadius.circular(5),
              ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                stringify(item),
                style: chipTextStyle ??
                    const TextStyle(
                      color: AppColors.black,
                      fontSize: 14,
                    ),
              ),
              if (onDelete != null) ...[
                const SizedBox(width: 8),
                InkWell(
                  onTap: () => onDelete!(item),
                  child: deleteIcon ??
                      Icon(
                        Icons.close,
                        size: 16,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
              ],
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _MultiDropdownValueAccessor<T, V>
    extends ControlValueAccessor<List<T>, List<V>> {
  _MultiDropdownValueAccessor(this.viewToModel);
  final T Function(V value) viewToModel;

  @override
  List<V>? modelToViewValue(List<T>? modelValue) {
    // We handle view updates in the State's onControlValueChanged
    return null;
  }

  @override
  List<T>? viewToModelValue(List<V>? viewValue) {
    return viewValue?.map(viewToModel).toList();
  }
}
