import 'package:flutter/material.dart';
import './custom_button.dart';
import './custom_text_field.dart';

class SearchCard extends StatefulWidget {
  final ThemeData? theme;
  final Function()? onSearchPressed;

  const SearchCard({
    Key? key,
    this.theme,
    this.onSearchPressed,
  }) : super(key: key);

  @override
  _SearchCardState createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  final TextEditingController destinationController = TextEditingController();

  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  int _rooms = 1;
  int _adults = 2;
  int _children = 0;
  bool _hasPets = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = widget.theme ?? Theme.of(context);

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: themeData.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          CustomTextField(
            controller: destinationController,
            label: 'الوجهة في اليمن',
            hintText: 'ابحث عن مدينة أو فندق في اليمن...',
            icon: Icons.location_on,
            iconSize: themeData.iconTheme.size,
            theme: themeData,
          ),
          SizedBox(height: 16),

          // تواريخ الحجز
          _buildDateSelection(themeData),
          SizedBox(height: 16),

          // الغرف والضيوف
          _buildGuestsAndRoomsSelection(themeData),
          SizedBox(height: 16),

          CustomButton(
            text: 'بحث في اليمن',
            onPressed: widget.onSearchPressed ?? () {},
            icon: Icons.search,
            iconSize: themeData.iconTheme.size,
            theme: themeData,
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelection(ThemeData themeData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'التواريخ',
          style: themeData.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: themeData.hintColor,
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => _showDatePicker(isCheckIn: true, themeData: themeData),
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _checkInDate != null
                            ? '${_checkInDate!.day}/${_checkInDate!.month}/${_checkInDate!.year}'
                            : 'اختر تاريخ الوصول',
                        style: themeData.textTheme.bodyMedium?.copyWith(
                          color: _checkInDate != null
                              ? themeData.textTheme.bodyMedium?.color
                              : themeData.hintColor,
                        ),
                      ),
                      Icon(Icons.calendar_today,
                          size: 20,
                          color: themeData.primaryColor),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: () => _showDatePicker(isCheckIn: false, themeData: themeData),
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _checkOutDate != null
                            ? '${_checkOutDate!.day}/${_checkOutDate!.month}/${_checkOutDate!.year}'
                            : 'اختر تاريخ المغادرة',
                        style: themeData.textTheme.bodyMedium?.copyWith(
                          color: _checkOutDate != null
                              ? themeData.textTheme.bodyMedium?.color
                              : themeData.hintColor,
                        ),
                      ),
                      Icon(Icons.calendar_today,
                          size: 20,
                          color: themeData.primaryColor),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        if (_checkInDate != null && _checkOutDate != null) ...[
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: themeData.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.info_outline,
                    size: 16,
                    color: themeData.primaryColor),
                SizedBox(width: 4),
                Text(
                  '${_checkInDate!.day}/${_checkInDate!.month} - ${_checkOutDate!.day}/${_checkOutDate!.month} (${_checkOutDate!.difference(_checkInDate!).inDays} ليالي)',
                  style: themeData.textTheme.bodySmall?.copyWith(
                    color: themeData.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildGuestsAndRoomsSelection(ThemeData themeData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الغرف والضيوف',
          style: themeData.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: themeData.hintColor,
          ),
        ),
        SizedBox(height: 8),
        GestureDetector(
          onTap: _showGuestsAndRoomsDialog,
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$_rooms غرفة، $_adults بالغين، $_children أطفال${_hasPets ? "، مع حيوانات أليفة" : ""}',
                  style: themeData.textTheme.bodyMedium,
                ),
                Icon(Icons.people,
                    size: 20,
                    color: themeData.primaryColor),
              ],
            ),
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.pets, size: 16, color: themeData.hintColor),
            SizedBox(width: 4),
            Text(
              'هل تصطحب معك حيوانات أليفة؟',
              style: themeData.textTheme.bodySmall?.copyWith(
                color: themeData.hintColor,
              ),
            ),
            Spacer(),
            Switch(
              value: _hasPets,
              onChanged: (value) {
                setState(() {
                  _hasPets = value;
                });
              },
              activeColor: themeData.primaryColor,
            ),
          ],
        ),
      ],
    );
  }

  void _showDatePicker({required bool isCheckIn, required ThemeData themeData}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2026, 12, 31),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: themeData.primaryColor,
            colorScheme: ColorScheme.light(primary: themeData.primaryColor),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          _checkInDate = picked;
          // إذا كان تاريخ المغادرة قبل تاريخ الوصول، نعيد تعيينه
          if (_checkOutDate != null && _checkOutDate!.isBefore(picked)) {
            _checkOutDate = null;
          }
        } else {
          if (_checkInDate == null || picked.isAfter(_checkInDate!)) {
            _checkOutDate = picked;
          }
        }
      });
    }
  }

  void _showGuestsAndRoomsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'حدد الغرف والضيوف',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.grey),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // عدد الغرف
                    _buildCounterItem(
                      themeData: Theme.of(context),
                      title: 'الغرف',
                      value: _rooms,
                      onIncrement: () {
                        if (_rooms < 5) {
                          setStateDialog(() {
                            _rooms++;
                          });
                        }
                      },
                      onDecrement: () {
                        if (_rooms > 1) {
                          setStateDialog(() {
                            _rooms--;
                          });
                        }
                      },
                    ),
                    Divider(),

                    // عدد البالغين
                    _buildCounterItem(
                      themeData: Theme.of(context),
                      title: 'بالغون',
                      subtitle: 'من عمر 18 سنة فأكثر',
                      value: _adults,
                      onIncrement: () {
                        if (_adults < 10) {
                          setStateDialog(() {
                            _adults++;
                          });
                        }
                      },
                      onDecrement: () {
                        if (_adults > 1) {
                          setStateDialog(() {
                            _adults--;
                          });
                        }
                      },
                    ),
                    Divider(),

                    // عدد الأطفال
                    _buildCounterItem(
                      themeData: Theme.of(context),
                      title: 'أطفال',
                      subtitle: 'الأعمار: من 0 إلى 17',
                      value: _children,
                      onIncrement: () {
                        if (_children < 10) {
                          setStateDialog(() {
                            _children++;
                          });
                        }
                      },
                      onDecrement: () {
                        if (_children > 0) {
                          setStateDialog(() {
                            _children--;
                          });
                        }
                      },
                    ),
                    SizedBox(height: 16),

                    // حيوانات أليفة
                    Row(
                      children: [
                        Icon(Icons.pets, size: 20, color: Colors.grey[600]),
                        SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'هل تصطحب معك حيوانات أليفة؟',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                              ),
                              Text(
                                'لا تعتبر الحيوانات المساعدة حيوانات أليفة',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: _hasPets,
                          onChanged: (value) {
                            setStateDialog(() {
                              _hasPets = value;
                            });
                          },
                          activeColor: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'إلغاء',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      // القيم محفوظة بالفعل في المتغيرات
                    });
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'تطبيق',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildCounterItem({
    required ThemeData themeData,
    required String title,
    String? subtitle,
    required int value,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: value > (title == 'الغرف' ? 1 : (title == 'بالغون' ? 1 : 0))
                      ? themeData.primaryColor
                      : Colors.grey[300],
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.remove, size: 18),
                  color: Colors.white,
                  onPressed: value > (title == 'الغرف' ? 1 : (title == 'بالغون' ? 1 : 0))
                      ? onDecrement
                      : null,
                  padding: EdgeInsets.all(4),
                ),
              ),
              SizedBox(width: 16),
              Text(
                value.toString(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(width: 16),
              Container(
                decoration: BoxDecoration(
                  color: value < (title == 'الغرف' ? 5 : 10)
                      ? themeData.primaryColor
                      : Colors.grey[300],
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.add, size: 18),
                  color: Colors.white,
                  onPressed: value < (title == 'الغرف' ? 5 : 10)
                      ? onIncrement
                      : null,
                  padding: EdgeInsets.all(4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}