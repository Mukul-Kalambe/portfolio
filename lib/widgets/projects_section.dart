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
      "title": "Job Jugad",
      "description":
          "A job search platform connecting employers and job seekers with advanced filtering and application tracking.",
      "image": "assets/img/jobjugad.png",
      "techStack": ["Flutter", "Firebase", "REST API", "Provider"],
      "liveUrl":
          "https://play.google.com/store/apps/details?id=com.eliora.jobportal&pcampaignid=web_share",
      "githubUrl": "https://github.com/username/job-jugad",
      "category": "Mobile App"
    },
    {
      "title": "Washionic",
      "description":
          "A laundry service app offering scheduling, payment integration, and real-time order tracking.",
      "image": "assets/img/washionic.png",
      "techStack": ["Flutter", "Stripe API", "Firebase", "Google Maps API"],
      "liveUrl": "https://play.google.com/store",
      "githubUrl": "https://github.com/username/washionic",
      "category": "Mobile App"
    },
    {
      "title": "Moms Magic Meal",
      "description":
          "A meal planning app with recipe suggestions, grocery lists, and nutritional tracking for home cooking.",
      "image": "assets/img/mmm.png",
      "techStack": ["Flutter", "Firebase", "REST API", "SQLite"],
      "liveUrl": "https://play.google.com/store",
      "githubUrl": "https://github.com/username/moms-magic-meal",
      "category": "Mobile App"
    },
    {
      "title": "CRM Portal",
      "description":
          "A customer relationship management portal for tracking leads, managing customer data, and automating workflows.",
      "image": "assets/img/crm.jpeg",
      "techStack": ["Flutter", "Firebase", "REST API", "Chart.js"],
      "liveUrl": "https://crmportal.example.com",
      "githubUrl": "https://github.com/username/crm-portal",
      "category": "Mobile App"
    }
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
            'Showcasing innovative solutions and creative implementations',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
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

    // Use theme colors for consistency
    final colors = [
      Theme.of(context).colorScheme.primary,
      Theme.of(context).colorScheme.secondary,
      Theme.of(context).colorScheme.tertiary,
    ];
    final color = colors[index % colors.length];

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
                    color: Theme.of(context).colorScheme.surface,
                    border: Border.all(
                      color: color.withOpacity(0.2),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.1),
                        blurRadius: 25,
                        spreadRadius: 5,
                        offset: const Offset(0, 10),
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
                                  Colors.black.withOpacity(0.7),
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
                                    color: color.withOpacity(0.9),
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
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                      fontWeight: FontWeight.bold,
                                    ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 12),

                              Expanded(
                                child: Text(
                                  project['description'] as String,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withOpacity(0.7),
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
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: color.withOpacity(0.1),
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
                                      Colors.white,
                                      () => _launchURL(
                                          project['liveUrl'] as String),
                                    ),
                                  ),
                                  // const SizedBox(width: 12),
                                  // Expanded(
                                  //   child: _buildActionButton(
                                  //     'GitHub',
                                  //     FontAwesomeIcons.github,
                                  //     Colors.white.withOpacity(0.7),
                                  //         () => _launchURL(project['githubUrl'] as String),
                                  //   ),
                                  // ),
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
        backgroundColor: Colors.indigo.withOpacity(0.5),
        side: BorderSide(color: color.withOpacity(0.3)),
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
    // Use theme colors for consistency
    final colors = [
      Theme.of(context).colorScheme.primary,
      Theme.of(context).colorScheme.secondary,
      Theme.of(context).colorScheme.tertiary,
    ];
    final color = colors[0]; // Use primary color for modal

    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: color.withOpacity(0.3)),
      ),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
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
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.7)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                project['image'].toString(),
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.image_not_supported,
                      size: 50,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            Text(
              project['description'] as String,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.8),
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
                          color: color.withOpacity(0.1),
                          border: Border.all(color: color.withOpacity(0.3)),
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
                      backgroundColor: Colors.white.withOpacity(0.1),
                      foregroundColor: Theme.of(context).colorScheme.onSurface,
                      side: BorderSide(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.3)),
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
