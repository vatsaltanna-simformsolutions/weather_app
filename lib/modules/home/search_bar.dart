import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/model/locations.dart';
import 'package:weather_app/modules/home/home_store.dart';
import 'package:weather_app/utils/extensions.dart';
import 'package:weather_app/values/app_colors.dart';
import 'package:weather_app/values/strings.dart';

class SearchBarWithSuggestions extends StatefulWidget {
  const SearchBarWithSuggestions({
    super.key,
    required this.itemClick,
    this.debounceTime = 600,
    required this.hint,
    this.focusNode,
  });

  final void Function(Result) itemClick;
  final String hint;
  final FocusNode? focusNode;

  final int debounceTime;

  @override
  SearchBarWithSuggestionsState createState() =>
      SearchBarWithSuggestionsState();
}

class SearchBarWithSuggestionsState extends State<SearchBarWithSuggestions> {
  TextStyle darkColorText = const TextStyle(color: Color(0xffFEDEB6));
  TextStyle lowerDarkText = const TextStyle(color: Color(0xffd1c7ba));
  TextStyle lightColorText = const TextStyle(color: Color(0xfff7f3f0));
  Color searchBarColor = const Color(0xff322821);
  Color scaffoldColor = const Color(0xff453b32);
  Color containerColor = const Color(0xff261F14);

  final subject = PublishSubject<String>();
  OverlayEntry? _overlayEntry;
  List<String> alPredictions = [];

  final TextEditingController _searchController = TextEditingController();
  final LayerLink _layerLink = LayerLink();
  bool isSearched = false;

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Theme(
        data: Theme.of(context).copyWith(
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: lowerDarkText.color,
          ),
        ),
        child: SearchBar(
          focusNode: widget.focusNode,
          elevation: MaterialStateProperty.all(0),
          controller: _searchController,
          textStyle: MaterialStateProperty.all(
            lowerDarkText.copyWith(
              fontSize: 20,
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(
              Icons.search,
              color: lowerDarkText.color,
            ),
          ),
          trailing: [
            InkWell(
              onTap: () {
                widget.focusNode?.unfocus();
                context.pushNamed(AppRoutes.txtSettings);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.settings,
                  color: AppColors.lowerDarkText.color,
                  size: 26,
                ),
              ),
            )
          ],
          backgroundColor: MaterialStateProperty.all(searchBarColor),
          hintText: widget.hint,
          hintStyle: MaterialStateProperty.all(
            lowerDarkText.copyWith(
              fontSize: 20,
            ),
          ),
          onChanged: textChanged,
        ),
      ),
    );
  }

  Future<void> getLocation(String text) async {
    if (_overlayEntry != null && _overlayEntry!.mounted) {
      _overlayEntry!.remove();
    }
    if (text.isEmpty) {
      alPredictions.clear();
      return;
    }

    isSearched = false;

    final homeStore = getIt<HomeStore>();
    await homeStore.getCityNames(text);
    final list = homeStore.locations?.results?.map((e) => e.name ?? '');
    alPredictions
      ..clear()
      ..addAll((list ?? []));

    _overlayEntry = null;
    _overlayEntry = _createOverlayEntry();
    if (mounted) {
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  @override
  void initState() {
    super.initState();
    subject.stream
        .distinct()
        .debounceTime(Duration(milliseconds: widget.debounceTime))
        .listen(textChanged);
    widget.focusNode?.addListener(_showOverlay);
  }

  @override
  void dispose() {
    widget.focusNode?.removeListener(_showOverlay);

    super.dispose();
  }

  void _showOverlay() {
    if (!(widget.focusNode?.hasFocus ?? false)) {
      removeOverlay();
    }
  }

  Future<void> textChanged(String text) async {
    await getLocation(text);
  }

  OverlayEntry? _createOverlayEntry() {
    if (context.findRenderObject() != null) {
      final renderBox = context.findRenderObject()! as RenderBox;
      final size = renderBox.size;
      final offset = renderBox.localToGlobal(Offset.zero);
      return OverlayEntry(
        builder: (context) => Positioned(
          left: offset.dx,
          top: size.height + offset.dy,
          width: size.width,
          child: CompositedTransformFollower(
            showWhenUnlinked: false,
            link: _layerLink,
            offset: Offset(0, size.height + 5.0),
            child: Material(
              elevation: 1,
              color: searchBarColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(16),
                ),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: alPredictions.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        if (index < alPredictions.length) {
                          _searchController.text = alPredictions[index];
                          widget.itemClick(
                              getIt<HomeStore>().locations!.results![index]);
                          removeOverlay();
                          return;
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        color: searchBarColor,
                        child: Text(
                          alPredictions[index],
                          style: lowerDarkText.copyWith(fontSize: 16),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );
    }
    return null;
  }

  void removeOverlay() {
    alPredictions.clear();
    if (_overlayEntry != null && _overlayEntry!.mounted) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }
}
