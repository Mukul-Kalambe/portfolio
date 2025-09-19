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
        vertical: 80,
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
              colors: [Color(0xFF00D4FF), Color(0xFF9D4EDD)],
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
        color: const Color(0xFF1A1A2E).withValues(alpha: 0.5),
        border: Border.all(
          color: const Color(0xFF00D4FF).withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00D4FF).withValues(alpha: 0.1),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Passionate Flutter Developer',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: const Color(0xFF00D4FF),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'With over 5+ years of experience in mobile app development, I specialize in creating beautiful, performant, and user-friendly applications using Flutter. My journey in software development has led me to work with various technologies, but Flutter has become my passion.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'I believe in writing clean, maintainable code and creating intuitive user experiences. Whether it\'s a startup looking to build their first mobile app or an enterprise seeking to modernize their mobile presence, I\'m here to bring your vision to life.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 30),
          Wrap(
            spacing: 20,
            runSpacing: 10,
            children: [
              _buildStatCard('50+', 'Projects Completed'),
              _buildStatCard('5+', 'Years Experience'),
              _buildStatCard('30+', 'Happy Clients'),
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
        color: const Color(0xFF9D4EDD).withValues(alpha: 0.1),
        border: Border.all(
          color: const Color(0xFF9D4EDD).withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          Text(
            number,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: const Color(0xFF9D4EDD),
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialLinks() {
    final socialLinks = [
      {'icon': FontAwesomeIcons.github, 'color': Color(0xFF00D4FF), 'url': 'https://github.com/mukulkalambe'},
      {'icon': FontAwesomeIcons.linkedin, 'color': Color(0xFF9D4EDD), 'url': 'https://linkedin.com/in/mukulkalambe'},
      {'icon': FontAwesomeIcons.instagram, 'color': Color(0xFF00FFA3), 'url': 'https://instagram.com/mukulkalambe'},
      {'icon': FontAwesomeIcons.twitter, 'color': Color(0xFF00D4FF), 'url': 'https://twitter.com/mukulkalambe'},
    ];

    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF1A1A2E).withValues(alpha: 0.5),
        border: Border.all(
          color: const Color(0xFF9D4EDD).withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF9D4EDD).withValues(alpha: 0.1),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Let\'s Connect',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
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
          color: color.withValues(alpha: 0.1),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withValues(alpha: 0.2),
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
                  color: Colors.white,
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