import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<AnimationController> _projectControllers;

  final List<Map<String, dynamic>> projects = [
    {
      'title': 'E-Commerce Flutter App',
      'description': 'Complete mobile shopping experience with payment integration, user authentication, and admin panel.',
      'image': 'https://pixabay.com/get/g628b88b9c6662bb5db57fed9b8fb167ab6b34f083582e5afd422ad1803813ae754a674bcdd5f18aa8b7bd4f95ee3e11d13a82794a5347f259deaec7055ad1ef0_1280.png',
      'techStack': ['Flutter', 'Firebase', 'Stripe API', 'Provider'],
      'liveUrl': 'https://play.google.com/store',
      'githubUrl': 'https://github.com/mukulkalambe/ecommerce-app',
      'color': Color(0xFF00D4FF),
      'category': 'Mobile App',
    },
    {
      'title': 'Social Media Dashboard',
      'description': 'Analytics dashboard for social media management with real-time data visualization and reporting.',
      'image': 'https://pixabay.com/get/g6c609e1285fd5e57210a517e73e5adc22124335e1d016af88dcb9fa86665c5fb14907e111469e988df70ae77d4ebbb06844bdc1e12355dbc93a21013b5d5a105_1280.png',
      'techStack': ['Flutter', 'REST API', 'Chart.js', 'SQLite'],
      'liveUrl': 'https://socialdashboard.example.com',
      'githubUrl': 'https://github.com/mukulkalambe/social-dashboard',
      'color': Color(0xFF9D4EDD),
      'category': 'Web App',
    },
    {
      'title': 'Fitness Tracker App',
      'description': 'Comprehensive fitness tracking with workout plans, nutrition tracking, and progress analytics.',
      'image': 'https://pixabay.com/get/g2e114e677205d220c5ed1efe01ced41b31cf09240aa04da4f2ce788c740d802c6254ef857e99c1597497d1c5d6876a04af131f0257b4983d9513da6fa6d14e28_1280.png',
      'techStack': ['Flutter', 'Firebase', 'Health APIs', 'BLoC'],
      'liveUrl': 'https://play.google.com/store',
      'githubUrl': 'https://github.com/mukulkalambe/fitness-tracker',
      'color': Color(0xFF00FFA3),
      'category': 'Mobile App',
    },
    {
      'title': 'Restaurant POS System',
      'description': 'Point of sale system for restaurants with inventory management and sales reporting.',
      'image': 'https://pixabay.com/get/g0b88e1d88fca846afaedec4931240ecfa3e62d0a907364f2d7748b05eb929066f0448ec296c12b43a2fce1d0ae873edd09686dc7ea27f0ec7abee4969e21aafe_1280.png',
      'techStack': ['Flutter', 'Node.js', 'MongoDB', 'Socket.io'],
      'liveUrl': 'https://restaurant-pos.example.com',
      'githubUrl': 'https://github.com/mukulkalambe/restaurant-pos',
      'color': Color(0xFF00D4FF),
      'category': 'Desktop App',
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _projectControllers = projects
        .map((project) => AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    ))
        .toList();

    _controller.forward();
    _startProjectAnimations();
  }

  void _startProjectAnimations() {
    for (int i = 0; i < _projectControllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 150), () {
        if (mounted) {
          _projectControllers[i].forward();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    for (var controller in _projectControllers) {
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
          _buildProjectsGrid(isDesktop, isTablet),
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
            'Featured Projects',
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
                colors: [Color(0xFF00D4FF), Color(0xFF00FFA3)],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Showcasing innovative solutions and creative implementations',
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

  Widget _buildProjectsGrid(bool isDesktop, bool isTablet) {
    final crossAxisCount = isDesktop ? 2 : 1;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
        childAspectRatio: isDesktop ? 1.2 : (isTablet ? 1.1 : 0.75),
      ),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        return _buildProjectCard(index);
      },
    );
  }

  Widget _buildProjectCard(int index) {
    final project = projects[index];
    final controller = _projectControllers[index];
    final color = project['color'] as Color;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.8 + (0.2 * controller.value),
          child: Opacity(
            opacity: controller.value,
            child: GestureDetector(
              onTap: () => _showProjectModal(project),
              child: MouseRegion(
                onEnter: (_) => _onHover(index, true),
                onExit: (_) => _onHover(index, false),
                child: Container(
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
                      // Project image
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(project['image'] as String),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withValues(alpha: 0.7),
                                ],
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: color.withValues(alpha: 0.9),
                                  ),
                                  child: Text(
                                    project['category'] as String,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Project details
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                project['title'] as String,
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 12),

                              Expanded(
                                child: Text(
                                  project['description'] as String,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.8),
                                    height: 1.5,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              const SizedBox(height: 16),

                              // Tech stack
                              Wrap(
                                spacing: 6,
                                runSpacing: 6,
                                children: (project['techStack'] as List<String>)
                                    .take(3)
                                    .map((tech) => Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: color.withValues(alpha: 0.2),
                                  ),
                                  child: Text(
                                    tech,
                                    style: TextStyle(
                                      color: color,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ))
                                    .toList(),
                              ),

                              const SizedBox(height: 20),

                              // Action buttons
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildActionButton(
                                      'Live Demo',
                                      FontAwesomeIcons.externalLinkAlt,
                                      color,
                                          () => _launchURL(project['liveUrl'] as String),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: _buildActionButton(
                                      'GitHub',
                                      FontAwesomeIcons.github,
                                      Colors.white.withValues(alpha: 0.7),
                                          () => _launchURL(project['githubUrl'] as String),
                                    ),
                                  ),
                                ],
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
          ),
        );
      },
    );
  }

  Widget _buildActionButton(
      String text,
      IconData icon,
      Color color,
      VoidCallback onPressed,
      ) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: FaIcon(icon, size: 14, color: color),
      label: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withValues(alpha: 0.1),
        side: BorderSide(color: color.withValues(alpha: 0.3)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _onHover(int index, bool isHovering) {
    // Add hover animation if needed
  }

  void _showProjectModal(Map<String, dynamic> project) {
    showDialog(
      context: context,
      builder: (context) => _ProjectModal(project: project),
    );
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

class _ProjectModal extends StatelessWidget {
  final Map<String, dynamic> project;

  const _ProjectModal({required this.project});

  @override
  Widget build(BuildContext context) {
    final color = project['color'] as Color;

    return Dialog(
      backgroundColor: const Color(0xFF1A1A2E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: color.withValues(alpha: 0.3)),
      ),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 600,
          minWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    project['title'] as String,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close, color: Colors.white.withValues(alpha: 0.7)),
                ),
              ],
            ),
            const SizedBox(height: 20),

            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                project['image'] as String,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 24),

            Text(
              project['description'] as String,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white.withValues(alpha: 0.9),
                height: 1.6,
              ),
            ),

            const SizedBox(height: 24),

            Text(
              'Technologies Used:',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: (project['techStack'] as List<String>)
                  .map((tech) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: color.withValues(alpha: 0.2),
                  border: Border.all(color: color.withValues(alpha: 0.3)),
                ),
                child: Text(
                  tech,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ))
                  .toList(),
            ),

            const SizedBox(height: 30),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _launchURL(project['liveUrl'] as String),
                    icon: FaIcon(FontAwesomeIcons.externalLinkAlt, size: 16),
                    label: const Text('Live Demo'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _launchURL(project['githubUrl'] as String),
                    icon: FaIcon(FontAwesomeIcons.github, size: 16),
                    label: const Text('View Code'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withValues(alpha: 0.1),
                      foregroundColor: Colors.white,
                      side: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}