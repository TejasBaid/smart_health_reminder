import '../../modules/water_tracking/model/water_option_model.dart';
import '../const_imports.dart';

class WaterOptionsModal extends StatefulWidget {
  final List<WaterOption> options;
  final String initialSelection;
  final ValueChanged<String> onSelectionChanged;

  const WaterOptionsModal({
    super.key,
    required this.options,
    required this.initialSelection,
    required this.onSelectionChanged,
  });

  @override
  State<WaterOptionsModal> createState() => _WaterOptionsModalState();
}

class _WaterOptionsModalState extends State<WaterOptionsModal> {
  late String _selectedAmount;

  @override
  void initState() {
    super.initState();
    _selectedAmount = widget.initialSelection;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 30),
      decoration: BoxDecoration(
        color: ColorConsts.whiteCl,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHandleIndicator(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Select Water Amount',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildOptionsList(),
          _buildDoneButton(),
        ],
      ),
    );
  }

  Widget _buildHandleIndicator() {
    return Container(
      width: 40,
      height: 4,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: ColorConsts.greyLight,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildOptionsList() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: widget.options.length,
        itemBuilder: (context, index) {
          final option = widget.options[index];
          final isSelected = _selectedAmount == option.label;

          return _buildOptionItem(option, isSelected);
        },
      ),
    );
  }

  Widget _buildOptionItem(WaterOption option, bool isSelected) {
    return Container(
      margin: EdgeInsets.only(
        bottom: option == widget.options.last ? 0 : 6,
        left: 4,
        right: 4,
      ),
      child: InkWell(
        onTap: () => setState(() => _selectedAmount = option.label),
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          decoration: BoxDecoration(
            color: isSelected ? ColorConsts.tealPopAccent : ColorConsts.whiteCl,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? ColorConsts.tealPopAccent : ColorConsts.greyLight,
              width: 1.0,
            ),
            boxShadow: isSelected ? [
              BoxShadow(
                color: ColorConsts.tealPopAccent.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ] : null,
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: isSelected
                      ? ColorConsts.greenAccent
                      : option.color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  option.icon,
                  color: isSelected ? ColorConsts.tealPopAccent : option.color,
                  size: 18,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      option.label,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? ColorConsts.whiteCl : ColorConsts.blackText,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${option.amount} milliliters',
                      style: TextStyle(
                        fontSize: 12,
                        color: isSelected
                            ? ColorConsts.whiteCl.withOpacity(0.8)
                            : ColorConsts.greySubtitle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDoneButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            widget.onSelectionChanged(_selectedAmount);
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorConsts.tealPopAccent,
            foregroundColor: ColorConsts.whiteCl,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 0,
          ),
          child: const Text(
            'Done',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
