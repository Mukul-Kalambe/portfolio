import 'package:flutter/material.dart';

class ServicesSection extends StatefulWidget {
  const ServicesSection({super.key});

  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<AnimationController> _cardControllers;

  final List<Map<String, dynamic>> services = [
    {
      'title': 'Mobile App Development',
      'description': 'Cross-platform mobile applications using Flutter with native performance and beautiful UI',
      'icon': Icons.phone_android,
      'color': Color(0xFF00D4FF),
      'features': ['Cross-platform', 'Native Performance', 'Custom UI/UX', 'App Store Ready']
    },
    {
      'title': 'UI/UX Design',
      'description': 'User-centered design solutions that create engaging and intuitive digital experiences',
      'icon': Icons.design_services,
      'color': Color(0xFF9D4EDD),
      'features': ['User Research', 'Wireframing', 'Prototyping', 'Visual Design']
    },
    {
      'title': 'Freelance Projects',
      'description': 'Custom software solutions tailored to your specific business needs and requirements',
      'icon': Icons.work,
      'color': Color(0xFF00FFA3),
      'features': ['Consultation', 'Custom Development', 'Project Management', 'Support']
    },
    {
      'title': 'API Integration',
      'description': 'Seamless integration with third-party services and custom backend solutions',
      'icon': Icons.api,
      'color': Color(0xFF00D4FF),
      'features': ['REST APIs', 'GraphQL', 'Firebase', 'Custom Backends']
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _cardControllers = services
        .map((service) => AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    ))
        .toList();

    _controller.forward();
    _startCardAnimations();
  }

  void _startCardAnimations() {
    for (int i = 0; i < _cardControllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 200), () {
        if (mounted) {
          _cardControllers[i].forward();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    for (var controller in _cardControllers) {
      controller.dispose();
    }
    super.dispose();
  }

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
          _buildSectionTitle(),
          const SizedBox(height: 60),
          _buildServicesGrid(isDesktop, isTablet),
        ],
      ),
    );
  }

  Widget _buildSectionTitle() {
    return FadeTransition(
      opacity: _controller,
      child: Column(
        children: [
          Text(
            'Services',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: 100,
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              gradient: const LinearGradient(
                colors: [Color(0xFF00FFA3), Color(0xFF00D4FF)],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Comprehensive solutions for your digital needs',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white.withValues(alpha: 0.8),
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildServicesGrid(bool isDesktop, bool isTablet) {
    final crossAxisCount = isDesktop ? 2 : 1;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
        childAspectRatio: isDesktop ? 1.3 : (isTablet ? 1.5 : 0.8),
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        return _buildServiceCard(index);
      },
    );
  }

  Widget _buildServiceCard(int index) {
    final service = services[index];
    final controller = _cardControllers[index];
    final color = service['color'] as Color;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - controller.value)),
          child: Opacity(
            opacity: controller.value,
            child: MouseRegion(
              onEnter: (_) => _onHover(index, true),
              onExit: (_) => _onHover(index, false),
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color(0xFF1A1A2E).withValues(alpha: 0.6),
                  border: Border.all(
                    color: color.withValues(alpha: 0.3),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.1),
                      blurRadius: 25,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon and title row
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: color.withValues(alpha: 0.2),
                            border: Border.all(
                              color: color.withValues(alpha: 0.5),
                              width: 1,
                            ),
                          ),
                          child: Icon(
                            service['icon'] as IconData,
                            size: 32,
                            color: color,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            service['title'] as String,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Description
                    Text(
                      service['description'] as String,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white.withValues(alpha: 0.8),
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Features
                    Text(
                      'Key Features:',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: (service['features'] as List<String>)
                          .map((feature) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: color.withValues(alpha: 0.1),
                          border: Border.all(
                            color: color.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          feature,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: color,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ))
                          .toList(),
                    ),

                    const SizedBox(height: 30),

                    // CTA Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle service inquiry
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color.withValues(alpha: 0.1),
                          foregroundColor: color,
                          side: BorderSide(color: color, width: 1),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Get Started',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: color,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward,
                              size: 18,
                              color: color,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _onHover(int index, bool isHovering) {
    // Add hover animation if needed
    if (isHovering) {
      _cardControllers[index].forward();
    }
  }
}