import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
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
        vertical: 40,
      ),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            _buildSectionTitle(),
            const SizedBox(height: 60),
            if (isDesktop) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: _buildBioContent()),
                  const SizedBox(width: 60),
                  Expanded(flex: 1, child: _buildSocialLinks()),
                ],
              ),
            ] else ...[
              _buildBioContent(),
              const SizedBox(height: 40),
              _buildSocialLinks(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle() {
    return Column(
      children: [
        Text(
          'About Me',
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
      ],
    );
  }

  Widget _buildBioContent() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 5,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primaryContainer,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mukul Kalambe',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    Text(
                      'Flutter Developer & Mobile App Expert',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Passionate Flutter Developer',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            'With over 3+ years of experience in mobile app development, I specialize in creating beautiful, performant, and user-friendly applications using Flutter. My journey in software development has led me to work with various technologies, but Flutter has become my passion.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                  height: 1.6,
                ),
          ),
          const SizedBox(height: 20),
          Text(
            'I believe in writing clean, maintainable code and creating intuitive user experiences. Whether it\'s a startup looking to build their first mobile app or an enterprise seeking to modernize their mobile presence, I\'m here to bring your vision to life.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                  height: 1.6,
                ),
          ),
          const SizedBox(height: 30),
          Wrap(
            spacing: 20,
            runSpacing: 10,
            children: [
              _buildStatCard('10+', 'Projects Completed'),
              _buildStatCard('3+', 'Years Experience'),
              _buildStatCard('5+', 'Happy Clients'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String number, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Text(
            number,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialLinks() {
    final socialLinks = [
      {
        'icon': FontAwesomeIcons.github,
        'color': Theme.of(context).colorScheme.primary,
        'url': 'https://github.com/Mukul-Kalambe'
      },
      {
        'icon': FontAwesomeIcons.linkedin,
        'color': Theme.of(context).colorScheme.secondary,
        'url': 'https://www.linkedin.com/in/mukul-kalambe-2322601a6'
      },
      {
        'icon': FontAwesomeIcons.instagram,
        'color': Theme.of(context).colorScheme.tertiary,
        'url':
            'https://www.instagram.com/the_mr.developer?igsh=MWw2aW10M2Y5OTFyeQ=='
      },
      {
        'icon': FontAwesomeIcons.twitter,
        'color': Theme.of(context).colorScheme.primary,
        'url': 'https://twitter.com/'
      },
    ];

    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 5,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Let\'s Connect',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 30),
          ...socialLinks.map((social) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: _buildSocialButton(
                  social['icon'] as IconData,
                  social['color'] as Color,
                  social['url'] as String,
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, Color color, String url) {
    return InkWell(
      onTap: () => _launchURL(url),
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: color.withOpacity(0.1),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(0.2),
              ),
              child: FaIcon(
                icon,
                size: 20,
                color: color,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                _getSocialName(icon),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            Icon(
              Icons.open_in_new,
              size: 16,
              color: color,
            ),
          ],
        ),
      ),
    );
  }

  String _getSocialName(IconData icon) {
    if (icon == FontAwesomeIcons.github) return 'GitHub';
    if (icon == FontAwesomeIcons.linkedin) return 'LinkedIn';
    if (icon == FontAwesomeIcons.instagram) return 'Instagram';
    if (icon == FontAwesomeIcons.twitter) return 'Twitter';
    return '';
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
