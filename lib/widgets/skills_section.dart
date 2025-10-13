import 'package:flutter/material.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _skillAnimations;
  int _hoveredIndex = -1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _skillAnimations = List.generate(
      12,
          (index) => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval((index * 0.08), (index * 0.08) + 0.6,
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

  final List<Map<String, dynamic>> skills = [
    {'name': 'Flutter', 'level': 95, 'icon': '🚀', 'color': Colors.teal},
    {'name': 'Dart', 'level': 92, 'icon': '💎', 'color': Colors.blue},
    {'name': 'Firebase', 'level': 88, 'icon': '🔥', 'color': Colors.orange},
    {'name': 'REST APIs', 'level': 90, 'icon': '🌐', 'color': Colors.green},
    {'name': 'UI/UX Design', 'level': 85, 'icon': '🎨', 'color': Colors.purple},
    {
      'name': 'State Management',
      'level': 88,
      'icon': '⚙️',
      'color': Colors.indigo
    },
    {'name': 'Git & GitHub', 'level': 90, 'icon': '📦', 'color': Colors.brown},
    {'name': 'Android Studio', 'level': 92, 'icon': '🛠️', 'color': Colors.red},
    {
      'name': 'iOS Development',
      'level': 87,
      'icon': '🍎',
      'color': Colors.blueGrey
    },
    {'name': 'SQLite', 'level': 85, 'icon': '🗄️', 'color': Colors.grey},
    {
      'name': 'Problem Solving',
      'level': 94,
      'icon': '🧩',
      'color': Colors.amber
    },
    {
      'name': 'Team Collaboration',
      'level': 91,
      'icon': '👥',
      'color': Colors.cyan
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
        vertical: 40,
      ),
      child: Column(
        children: [
          _buildSectionHeader(),
          const SizedBox(height: 60),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isDesktop ? 4 : (isTablet ? 3 : 2),
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1.1,
            ),
            itemCount: skills.length,
            itemBuilder: (context, index) {
              return ScaleTransition(
                scale: _skillAnimations[index],
                child: _buildSkillCard(skills[index], index),
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
          'My Skills',
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
          'Expertise in modern mobile development with cutting-edge technologies',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildSkillCard(Map<String, dynamic> skill, int index) {
    final isHovered = _hoveredIndex == index;
    final color = skill['color'] as Color;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredIndex = index),
      onExit: (_) => setState(() => _hoveredIndex = -1),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isHovered
                ? [
              color.withOpacity(0.15),
              color.withOpacity(0.05),
            ]
                : [
              Colors.transparent,
              Colors.transparent,
            ],
          ),
          border: Border.all(
            color: isHovered
                ? color.withOpacity(0.5)
                : Theme.of(context).colorScheme.primary.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(isHovered ? 0.2 : 0.1),
                ),
                child: Text(
                  skill['icon'],
                  style: TextStyle(
                    fontSize: 40,
                    color: color,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                skill['name'],
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 6,
                      decoration: BoxDecoration(
                        color: isHovered
                            ? color.withOpacity(0.2)
                            : Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: skill['level'] / 100,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: 6,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: isHovered
                                ? [
                              color,
                              color.withOpacity(0.7),
                            ]
                                : [
                              Theme.of(context).colorScheme.primary,
                              Theme.of(context).colorScheme.secondary,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
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
}
