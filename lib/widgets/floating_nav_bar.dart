import 'package:flutter/material.dart';

class FloatingNavBar extends StatefulWidget {
  final Function(int) onItemTapped;

  const FloatingNavBar({
    super.key,
    required this.onItemTapped,
  });

  @override
  State<FloatingNavBar> createState() => _FloatingNavBarState();
}

class _FloatingNavBarState extends State<FloatingNavBar>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;
  int _selectedIndex = 0;
  bool _isVisible = true;

  final List<Map<String, dynamic>> navItems = [
    {'icon': Icons.home, 'label': 'Home'},
    {'icon': Icons.person, 'label': 'About'},
    {'icon': Icons.code, 'label': 'Skills'},
    {'icon': Icons.work, 'label': 'Services'},
    {'icon': Icons.apps, 'label': 'Projects'},
    {'icon': Icons.star, 'label': 'Reviews'},
    {'icon': Icons.description, 'label': 'Resume'},
    {'icon': Icons.contact_mail, 'label': 'Contact'},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));

    _slideController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1024;
    final isTablet = size.width > 768 && size.width <= 1024;

    if (!_isVisible) return const SizedBox.shrink();

    return SlideTransition(
      position: _slideAnimation,
      child: Positioned(
        bottom: 20,
        left: isDesktop ? 50 : (isTablet ? 30 : 20),
        right: isDesktop ? 50 : (isTablet ? 30 : 20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color(0xFF1A1A2E).withValues(alpha: 0.9),
            border: Border.all(
              color: const Color(0xFF00D4FF).withValues(alpha: 0.3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00D4FF).withValues(alpha: 0.2),
                blurRadius: 20,
                spreadRadius: 5,
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: isDesktop
              ? _buildDesktopNavBar()
              : _buildMobileNavBar(),
        ),
      ),
    );
  }

  Widget _buildDesktopNavBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: navItems.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final isSelected = _selectedIndex == index;

        return _buildNavItem(
          index: index,
          icon: item['icon'] as IconData,
          label: item['label'] as String,
          isSelected: isSelected,
          showLabel: true,
        );
      }).toList(),
    );
  }

  Widget _buildMobileNavBar() {
    // Show only essential navigation items on mobile
    final essentialItems = [
      {'icon': Icons.home, 'label': 'Home', 'index': 0},
      {'icon': Icons.person, 'label': 'About', 'index': 1},
      {'icon': Icons.apps, 'label': 'Projects', 'index': 4},
      {'icon': Icons.contact_mail, 'label': 'Contact', 'index': 7},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: essentialItems.map((item) {
        final index = item['index'] as int;
        final isSelected = _selectedIndex == index;

        return _buildNavItem(
          index: index,
          icon: item['icon'] as IconData,
          label: item['label'] as String,
          isSelected: isSelected,
          showLabel: false,
        );
      }).toList(),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
    required bool isSelected,
    required bool showLabel,
  }) {
    final colors = [
      const Color(0xFF00D4FF),
      const Color(0xFF9D4EDD),
      const Color(0xFF00FFA3),
      const Color(0xFF00D4FF),
      const Color(0xFF9D4EDD),
      const Color(0xFF00FFA3),
      const Color(0xFF00D4FF),
      const Color(0xFF9D4EDD),
    ];
    final color = colors[index % colors.length];

    return GestureDetector(
      onTap: () => _onNavItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(
          horizontal: showLabel ? (isSelected ? 16 : 12) : 12,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected
              ? color.withValues(alpha: 0.2)
              : Colors.transparent,
          border: isSelected
              ? Border.all(color: color.withValues(alpha: 0.5), width: 1)
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? color.withValues(alpha: 0.3)
                    : Colors.transparent,
              ),
              child: Icon(
                icon,
                size: 20,
                color: isSelected ? color : Colors.white.withValues(alpha: 0.7),
              ),
            ),
            if (showLabel && isSelected) ...[
              const SizedBox(width: 8),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: isSelected ? 1.0 : 0.0,
                child: Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Add haptic feedback
    // HapticFeedback.lightImpact();

    widget.onItemTapped(index);

    // Animate the selection
    _controller.forward().then((_) {
      _controller.reverse();
    });
  }

  void hide() {
    setState(() {
      _isVisible = false;
    });
  }

  void show() {
    setState(() {
      _isVisible = true;
    });
  }
}