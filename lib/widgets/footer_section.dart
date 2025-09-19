import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterSection extends StatefulWidget {
  const FooterSection({super.key});

  @override
  State<FooterSection> createState() => _FooterSectionState();
}

class _FooterSectionState extends State<FooterSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
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

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 80 : (isTablet ? 40 : 20),
          vertical: 60,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF0A0A0A),
          border: const Border(
            top: BorderSide(
              color: Color(0xFF00D4FF),
              width: 1,
            ),
          ),
        ),
        child: Column(
          children: [
            if (isDesktop) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 2, child: _buildBrandSection()),
                  const SizedBox(width: 60),
                  Expanded(flex: 1, child: _buildQuickLinks()),
                  const SizedBox(width: 60),
                  Expanded(flex: 1, child: _buildSocialSection()),
                ],
              ),
            ] else ...[
              _buildBrandSection(),
              const SizedBox(height: 40),
              if (isTablet) ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildQuickLinks()),
                    const SizedBox(width: 40),
                    Expanded(child: _buildSocialSection()),
                  ],
                ),
              ] else ...[
                _buildQuickLinks(),
                const SizedBox(height: 30),
                _buildSocialSection(),
              ],
            ],

            const SizedBox(height: 40),

            _buildDivider(),

            const SizedBox(height: 30),

            _buildCopyright(),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mukul Kalambe',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Flutter Developer | Mobile App Expert',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: const Color(0xFF00D4FF),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Crafting beautiful, high-performance mobile applications that bring ideas to life. Let\'s build something amazing together.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white.withValues(alpha: 0.8),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 24),
        _buildContactInfo(),
      ],
    );
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildContactItem(
          Icons.email,
          'mukul@example.com',
              () => _launchURL('mailto:mukul@example.com'),
        ),
        const SizedBox(height: 8),
        _buildContactItem(
          Icons.phone,
          '+1 (555) 123-4567',
              () => _launchURL('tel:+15551234567'),
        ),
        const SizedBox(height: 8),
        _buildContactItem(
          Icons.location_on,
          'Mumbai, India',
              () {},
        ),
      ],
    );
  }

  Widget _buildContactItem(IconData icon, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: const Color(0xFF9D4EDD),
            ),
            const SizedBox(width: 12),
            Text(
              text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickLinks() {
    final links = [
      {'title': 'About', 'action': () {}},
      {'title': 'Services', 'action': () {}},
      {'title': 'Projects', 'action': () {}},
      {'title': 'Resume', 'action': () {}},
      {'title': 'Contact', 'action': () {}},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Links',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        ...links.map((link) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: link['action'] as VoidCallback,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.arrow_right,
                    size: 16,
                    color: const Color(0xFF00FFA3),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    link['title'] as String,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildSocialSection() {
    final socialLinks = [
      {
        'icon': FontAwesomeIcons.github,
        'label': 'GitHub',
        'url': 'https://github.com/mukulkalambe',
        'color': Color(0xFF00D4FF),
      },
      {
        'icon': FontAwesomeIcons.linkedin,
        'label': 'LinkedIn',
        'url': 'https://linkedin.com/in/mukulkalambe',
        'color': Color(0xFF9D4EDD),
      },
      {
        'icon': FontAwesomeIcons.instagram,
        'label': 'Instagram',
        'url': 'https://instagram.com/mukulkalambe',
        'color': Color(0xFF00FFA3),
      },
      {
        'icon': FontAwesomeIcons.twitter,
        'label': 'Twitter',
        'url': 'https://twitter.com/mukulkalambe',
        'color': Color(0xFF00D4FF),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Follow Me',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: socialLinks.map((social) => _buildSocialButton(
            social['icon'] as IconData,
            social['label'] as String,
            social['url'] as String,
            social['color'] as Color,
          )).toList(),
        ),
        const SizedBox(height: 30),
        Text(
          'Available for freelance projects',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: const Color(0xFF00FFA3),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton(IconData icon, String label, String url, Color color) {
    return InkWell(
      onTap: () => _launchURL(url),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color.withValues(alpha: 0.1),
          border: Border.all(
            color: color.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              icon,
              size: 16,
              color: color,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            const Color(0xFF00D4FF).withValues(alpha: 0.5),
            const Color(0xFF9D4EDD).withValues(alpha: 0.5),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  Widget _buildCopyright() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '© 2025 Mukul Kalambe. All rights reserved.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.white.withValues(alpha: 0.6),
          ),
        ),
        Row(
          children: [
            Text(
              'Made with ',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.6),
              ),
            ),
            Icon(
              Icons.favorite,
              size: 14,
              color: const Color(0xFFFF4081),
            ),
            Text(
              ' in Flutter',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}