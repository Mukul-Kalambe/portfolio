import 'package:flutter/material.dart';

class ServicesSection extends StatefulWidget {
  const ServicesSection({super.key});

  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<Offset>> _slideAnimations;
  int _hoveredIndex = -1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _slideAnimations = List.generate(
      6,
      (index) => Tween<Offset>(
        begin: Offset(0, 0.3),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval((index * 0.1), (index * 0.1) + 0.6,
              curve: Curves.easeOut),
        ),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> services = [
    {
      'title': 'Mobile App Development',
      'description':
          'Full-featured iOS and Android apps with Flutter. Cross-platform development for maximum reach.',
      'icon': Icons.phone_iphone,
      'color': Colors.blue,
    },
    {
      'title': 'UI/UX Implementation',
      'description':
          'Beautiful, intuitive interfaces. Converting designs to pixel-perfect, responsive Flutter applications.',
      'icon': Icons.palette,
      'color': Colors.purple,
    },
    {
      'title': 'Backend Integration',
      'description':
          'Seamless API integration, Firebase setup, database management, and real-time data synchronization.',
      'icon': Icons.cloud,
      'color': Colors.orange,
    },
    {
      'title': 'App Optimization',
      'description':
          'Performance tuning, reducing app size, improving load times, and battery optimization.',
      'icon': Icons.speed,
      'color': Colors.green,
    },
    {
      'title': 'App Maintenance',
      'description':
          'Ongoing support, bug fixes, updates, and feature enhancements for your existing applications.',
      'icon': Icons.build,
      'color': Colors.red,
    },
    {
      'title': 'Consulting',
      'description':
          'Expert advice on app strategy, architecture, best practices, and technology recommendations.',
      'icon': Icons.lightbulb,
      'color': Colors.amber,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1024;
    final isTablet = size.width > 768 && size.width <= 1024;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : (isTablet ? 40 : 20),
        vertical: 80,
      ),
      child: Column(
        children: [
          _buildSectionHeader(),
          const SizedBox(height: 60),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isDesktop ? 3 : (isTablet ? 2 : 1),
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
              childAspectRatio: 1.05,
            ),
            itemCount: services.length,
            itemBuilder: (context, index) {
              return SlideTransition(
                position: _slideAnimations[index],
                child: _buildServiceCard(services[index], index),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Column(
      children: [
        Text(
          'Services',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        Container(
          width: 100,
          height: 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Comprehensive solutions tailored to bring your vision to life',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
        ),
      ],
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service, int index) {
    final isHovered = _hoveredIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredIndex = index),
      onExit: (_) => setState(() => _hoveredIndex = -1),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isHovered
                ? [
                    service['color'].withOpacity(0.15),
                    service['color'].withOpacity(0.05),
                  ]
                : [
                    Colors.transparent,
                    Colors.transparent,
                  ],
          ),
          border: Border.all(
            color: isHovered
                ? service['color'].withOpacity(0.5)
                : Theme.of(context).colorScheme.primary.withOpacity(0.1),
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          service['color'].withOpacity(isHovered ? 0.2 : 0.1),
                    ),
                    child: Icon(
                      service['icon'],
                      size: 32,
                      color: service['color'],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    service['title'],
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    service['description'],
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.7),
                          height: 1.5,
                        ),
                  ),
                  const SizedBox(height: 20),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: TextStyle(
                      color: isHovered
                          ? service['color']
                          : Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Learn More'),
                        const SizedBox(width: 8),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          transform: Matrix4.translationValues(
                            isHovered ? 8 : 0,
                            0,
                            0,
                          ),
                          child: const Icon(Icons.arrow_right, size: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
