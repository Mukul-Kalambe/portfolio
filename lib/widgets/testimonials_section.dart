import 'package:flutter/material.dart';

class TestimonialsSection extends StatefulWidget {
  const TestimonialsSection({super.key});

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late PageController _pageController;
  int _currentIndex = 0;

  final List<Map<String, dynamic>> testimonials = [
    {
      'name': 'Sarah Johnson',
      'role': 'CEO, TechStart Inc.',
      'message': 'Mukul delivered an exceptional Flutter app that exceeded our expectations. His attention to detail and technical expertise made our project a huge success.',
      'rating': 5,
      'image': 'https://images.unsplash.com/photo-1494790108755-2616b612b5c5?w=400&h=400&fit=crop&crop=face',
      'color': Color(0xFF00D4FF),
      'experience': '6 months project'
    },
    {
      'name': 'David Chen',
      'role': 'Product Manager, FinanceApp',
      'message': 'Working with Mukul was a game-changer for our startup. He transformed our complex requirements into a beautiful, intuitive mobile experience.',
      'rating': 5,
      'image': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=400&fit=crop&crop=face',
      'color': Color(0xFF9D4EDD),
      'experience': '4 months project'
    },
    {
      'name': 'Emily Rodriguez',
      'role': 'Founder, HealthTech Solutions',
      'message': 'Mukul\'s Flutter development skills are outstanding. He delivered our healthcare app on time and with features that our users absolutely love.',
      'rating': 5,
      'image': 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=400&h=400&fit=crop&crop=face',
      'color': Color(0xFF00FFA3),
      'experience': '8 months project'
    },
    {
      'name': 'Michael Thompson',
      'role': 'CTO, EduPlatform',
      'message': 'The e-learning app Mukul built for us has been a tremendous success. His expertise in Flutter and user experience design really shows in the final product.',
      'rating': 5,
      'image': 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=400&h=400&fit=crop&crop=face',
      'color': Color(0xFF00D4FF),
      'experience': '5 months project'
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _pageController = PageController();
    _controller.forward();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        _nextTestimonial();
        _startAutoSlide();
      }
    });
  }

  void _nextTestimonial() {
    if (_currentIndex < testimonials.length - 1) {
      _currentIndex++;
    } else {
      _currentIndex = 0;
    }
    _pageController.animateToPage(
      _currentIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
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
          _buildTestimonialsCarousel(isDesktop, isTablet),
          const SizedBox(height: 40),
          _buildPageIndicator(),
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
            'Client Testimonials',
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
                colors: [Color(0xFF9D4EDD), Color(0xFF00D4FF)],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'What clients say about working with me',
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

  Widget _buildTestimonialsCarousel(bool isDesktop, bool isTablet) {
    return SizedBox(
      height: isDesktop ? 400 : (isTablet ? 450 : 500),
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemCount: testimonials.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildTestimonialCard(testimonials[index], isDesktop, isTablet),
          );
        },
      ),
    );
  }

  Widget _buildTestimonialCard(
      Map<String, dynamic> testimonial,
      bool isDesktop,
      bool isTablet,
      ) {
    final color = testimonial['color'] as Color;

    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color(0xFF1A1A2E).withValues(alpha: 0.6),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 30,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          if (isDesktop) ...[
            Row(
              children: [
                _buildClientInfo(testimonial, color),
                const SizedBox(width: 40),
                Expanded(child: _buildTestimonialContent(testimonial, color)),
              ],
            ),
          ] else ...[
            _buildClientInfo(testimonial, color),
            const SizedBox(height: 30),
            _buildTestimonialContent(testimonial, color),
          ],
        ],
      ),
    );
  }

  Widget _buildClientInfo(Map<String, dynamic> testimonial, Color color) {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 3),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.4),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: Image.network(
              testimonial['image'] as String,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: color.withValues(alpha: 0.2),
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: color,
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          testimonial['name'] as String,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          testimonial['role'] as String,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: color.withValues(alpha: 0.2),
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: Text(
            testimonial['experience'] as String,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTestimonialContent(Map<String, dynamic> testimonial, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Quote icon
        Icon(
          Icons.format_quote,
          size: 40,
          color: color.withValues(alpha: 0.7),
        ),
        const SizedBox(height: 16),

        // Message
        Row(
          children: [
            Expanded(
              child: Text(
                testimonial['message'] as String,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                  height: 1.6,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Rating stars
        Row(
          children: [
            Row(
              children: List.generate(
                testimonial['rating'] as int,
                    (index) => Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Icon(
                    Icons.star,
                    color: color,
                    size: 24,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '${testimonial['rating']}/5 Stars',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        testimonials.length,
            (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: _currentIndex == index ? 32 : 8,
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: _currentIndex == index
                ? const Color(0xFF00D4FF)
                : Colors.white.withValues(alpha: 0.3),
          ),
        ),
      ),
    );
  }
}