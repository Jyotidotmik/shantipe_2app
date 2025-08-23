import 'package:flutter/material.dart';

class R {
  static late double _w;
  static late double _h;
  static void init(BuildContext context) {
    final s = MediaQuery.of(context).size;
    _w = s.width; _h = s.height;
  }

  /// Reference width = 390 (iPhone 14 width)
  static double rw(double v) => v * (_w / 390.0);
  /// Reference height = 844
  static double rh(double v) => v * (_h / 844.0);
  /// Font scale (avg of w/h scaling to feel balanced)
  static double rf(double v) => v * ((_w / 390.0 + _h / 844.0) / 2);
}

/// Demo transaction model
class Txn {
  final String name;
  final DateTime date;
  final double amount; // negative for debit
  final TxnDirection direction; // for the arrow & color
  Txn({
    required this.name,
    required this.date,
    required this.amount,
    required this.direction,
  });
}

enum TxnDirection { upRight, downLeft }

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen>
    with SingleTickerProviderStateMixin {
  int _chipIndex = 0; // 0: All Categories, 1: Payment Status
  late final TabController _tab;

  final List<Txn> _all = List.generate(14, (i) {
    // alternating sample data
    final isCredit = i.isOdd;
    return Txn(
      name: 'Candice Norman',
      date: DateTime(2024, 10, 9),
      amount: isCredit ? 952 : -952,
      direction: isCredit ? TxnDirection.downLeft : TxnDirection.upRight,
    );
  });

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    R.init(context);
    final theme = Theme.of(context);
    // ignore: unused_local_variable
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar (custom to match design)
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: R.rw(16),
                vertical: R.rh(10),
              ),
              child: Row(
                children: [
                  _RoundIconButton(
                    icon: Icons.arrow_back_ios_new_rounded,
                    onTap: () => Navigator.maybePop(context),
                  ),
                  SizedBox(width: R.rw(12)),
                  Expanded(
                    child: Text(
                      'Transaction History',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontSize: R.rf(18),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // placeholder to balance back button space
                  SizedBox(width: R.rw(44)),
                ],
              ),
            ),
            // Filter chips row (acts like tabs)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: R.rw(16)),
              child: _SegmentedChips(
                index: _chipIndex,
                onChanged: (i) {
                  setState(() => _chipIndex = i);
                  _tab.index = i;
                },
              ),
            ),
            SizedBox(height: R.rh(8)),
            Expanded(
              child: TabBarView(
                controller: _tab,
                physics: const BouncingScrollPhysics(),
                children: [
                  // All Categories
                  _TxnList(
                    txns: _all,
                  ),

                  _TxnList(
                    txns: _all
                        .where((t) => t.amount > 0)
                        .toList(growable: false),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Segmented chips like in the screenshot
class _SegmentedChips extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChanged;
  const _SegmentedChips({
    required this.index,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bg = theme.colorScheme.surface;
    final border = theme.dividerColor.withOpacity(0.25);

    return Container(
      padding: EdgeInsets.all(R.rw(6)),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(R.rw(14)),
        border: Border.all(color: border),
      ),
      child: Row(
        children: [
          _ChipBtn(
            text: 'All Categories',
            selected: index == 0,
            onTap: () => onChanged(0),
          ),
          SizedBox(width: R.rw(6)),
          _ChipBtn(
            text: 'Payment Status',
            selected: index == 1,
            onTap: () => onChanged(1),
          ),
        ],
      ),
    );
  }
}

class _ChipBtn extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onTap;
  const _ChipBtn({
    required this.text,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selColor = theme.colorScheme.primary.withOpacity(0.1);
    final txtSel = theme.colorScheme.primary;
    final txt = theme.textTheme.labelLarge?.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: R.rf(12.5),
      color: selected ? txtSel : theme.textTheme.bodyMedium?.color,
    );

    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(R.rw(10)),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: R.rw(10),
            vertical: R.rh(10),
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? selColor : Colors.transparent,
            borderRadius: BorderRadius.circular(R.rw(10)),
          ),
          child: Text(text, style: txt, maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
      ),
    );
  }
}

/// List of transactions
class _TxnList extends StatelessWidget {
  final List<Txn> txns;
  const _TxnList({required this.txns});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: R.rw(16), vertical: R.rh(8)),
      physics: const BouncingScrollPhysics(),
      itemCount: txns.length,
      separatorBuilder: (_, __) => SizedBox(height: R.rh(8)),
      itemBuilder: (_, i) => _TxnTile(t: txns[i]),
    );
  }
}

/// Single transaction row
class _TxnTile extends StatelessWidget {
  final Txn t;
  const _TxnTile({required this.t});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCredit = t.amount > 0;

    // icon + soft colored circle to match screenshot
    final Color base = isCredit ? Colors.green : Colors.red;
    final Color soft = base.withOpacity(0.12);

    final IconData arrow = switch (t.direction) {
      TxnDirection.upRight => Icons.north_east_rounded,
      TxnDirection.downLeft => Icons.south_west_rounded,
    };

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: R.rw(12),
        vertical: R.rh(10),
      ),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(R.rw(14)),
        boxShadow: [
          BoxShadow(
            blurRadius: R.rw(16),
            spreadRadius: 0,
            offset: const Offset(0, 4),
            color: Colors.black.withOpacity(0.05),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: R.rw(40),
            height: R.rw(40),
            decoration: BoxDecoration(
              color: soft,
              shape: BoxShape.circle,
            ),
            child: Icon(arrow, size: R.rf(20), color: base),
          ),
          SizedBox(width: R.rw(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.name,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: R.rf(14.5),
                  ),
                ),
                SizedBox(height: R.rh(2)),
                Text(
                  _formatDate(t.date),
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: R.rf(12),
                    color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          Text(
            (isCredit ? '+' : '-') + '₹${t.amount.abs().toStringAsFixed(0)}',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: R.rf(14.5),
              color: isCredit ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime d) {
    // Oct 9th, 2024
    const months = [
      'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'
    ];
    final m = months[d.month - 1];
    final day = d.day;
    final suffix = (day >= 11 && day <= 13)
        ? 'th'
        : {1: 'st', 2: 'nd', 3: 'rd'}[day % 10] ?? 'th';
    return '$m ${d.day}$suffix, ${d.year}';
  }
}

/// Small circular back button
class _RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _RoundIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(R.rw(10)),
          child: Icon(icon, size: R.rf(18)),
        ),
      ),
    );
  }
}
