import 'package:flutter/material.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<AnimationController> _skillControllers;
  late List<Animation<double>> _skillAnimations;

  final List<Map<String, dynamic>> skills = [
    {'name': 'Flutter', 'level': 0.95, 'color': Color(0xFF00D4FF)},
    {'name': 'Dart', 'level': 0.92, 'color': Color(0xFF9D4EDD)},
    {'name': 'Firebase', 'level': 0.88, 'color': Color(0xFF00FFA3)},
    {'name': 'REST APIs', 'level': 0.90, 'color': Color(0xFF00D4FF)},
    {'name': 'Node.js', 'level': 0.75, 'color': Color(0xFF9D4EDD)},
    {'name': 'UI/UX Design', 'level': 0.85, 'color': Color(0xFF00FFA3)},
    {'name': 'Git', 'level': 0.87, 'color': Color(0xFF00D4FF)},
    {'name': 'MySQL', 'level': 0.80, 'color': Color(0xFF9D4EDD)},
    {'name': 'MongoDB', 'level': 0.78, 'color': Color(0xFF00FFA3)},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _skillControllers = skills
        .map((skill) => AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    ))
        .toList();

    _skillAnimations = _skillControllers
        .asMap()
        .entries
        .map((entry) => Tween<double>(begin: 0.0, end: skills[entry.key]['level'] as double)
        .animate(CurvedAnimation(
      parent: entry.value,
      curve: Curves.easeOutCubic,
    )))
        .toList();

    _startAnimations();
  }

  void _startAnimations() {
    _controller.forward();
    for (int i = 0; i < _skillControllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 200), () {
        if (mounted) {
          _skillControllers[i].forward();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    for (var controller in _skillControllers) {
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
          _buildSkillsGrid(isDesktop, isTablet),
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
            'Skills & Technologies',
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
                colors: [Color(0xFF9D4EDD), Color(0xFF00FFA3)],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsGrid(bool isDesktop, bool isTablet) {
    final crossAxisCount = isDesktop ? 3 : (isTablet ? 2 : 1);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: isDesktop ? 1.5 : (isTablet ? 1.3 : 2.5),
      ),
      itemCount: skills.length,
      itemBuilder: (context, index) {
        return _buildSkillCard(index);
      },
    );
  }

  Widget _buildSkillCard(int index) {
    final skill = skills[index];
    final animation = _skillAnimations[index];
    final color = skill['color'] as Color;

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xFF1A1A2E).withValues(alpha: 0.5),
            border: Border.all(
              color: color.withValues(alpha: 0.3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.1),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Skill icon/bubble
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withValues(alpha: 0.2),
                  border: Border.all(color: color, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.4),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    skill['name'].toString().substring(0, 1),
                    style: TextStyle(
                      color: color,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Skill name
              Text(
                skill['name'] as String,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Progress bar
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Proficiency',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white.withValues(alpha: 0.7),
                        ),
                      ),
                      Text(
                        '${(animation.value * 100).round()}%',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white.withValues(alpha: 0.1),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: animation.value,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              gradient: LinearGradient(
                                colors: [
                                  color,
                                  color.withValues(alpha: 0.7),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: color.withValues(alpha: 0.5),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}