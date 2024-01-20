part of 'shared_widgets.dart';

enum SortingOption { lastMessage, alphabeticalOrder, dateAdded }

class SortingOptionButton extends StatefulWidget {
  const SortingOptionButton({super.key, required this.isSelected, required this.sortingOption, this.onPressed});

  final bool isSelected;
  final SortingOption sortingOption;
  final VoidCallback? onPressed;

  @override
  State<SortingOptionButton> createState() => _SortingOptionButtonState();
}

class _SortingOptionButtonState extends State<SortingOptionButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: GestureDetector(
          onTap: widget.onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: widget.isSelected
                  ? const Color(0xFF09CE1C)
                  : isHovered ? const Color(0xFF008E14) : const Color(0xFF05E15D),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              getSortingOptionDisplayText(widget.sortingOption),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        )
    );
  }

  String getSortingOptionDisplayText(SortingOption sortingOption) {
    switch (sortingOption) {
      case SortingOption.lastMessage:
        return 'Last message';
      case SortingOption.alphabeticalOrder:
        return 'Alphabetical order';
      case SortingOption.dateAdded:
        return 'Date added';
    }
  }
}