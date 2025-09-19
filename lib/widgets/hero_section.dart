import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _glowAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
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
      height: size.height,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : (isTablet ? 40 : 20),
        vertical: 40,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isDesktop) ...[
            Row(
              children: [
                Expanded(child: _buildTextContent()),
                const SizedBox(width: 60),
                _buildProfileImage(),
              ],
            ),
          ] else ...[
            _buildProfileImage(),
            const SizedBox(height: 40),
            _buildTextContent(),
          ],
          const SizedBox(height: 60),
          _buildActionButtons(isDesktop),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Container(
          width: 280,
          height: 280,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00D4FF).withValues(alpha: _glowAnimation.value * 0.6),
                blurRadius: 30,
                spreadRadius: 10,
              ),
              BoxShadow(
                color: const Color(0xFF9D4EDD).withValues(alpha: _glowAnimation.value * 0.4),
                blurRadius: 50,
                spreadRadius: 15,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(140),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF00D4FF),
                  width: 3,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(137),
                child: Image.network(
                  'https://pixabay.com/get/g415016eb6b3335170fbfdc254d66f66d9b28ef78e61fdb0875996e0bcb7ebfcdaf732eca2fac35a228e87cfe929af0fac3e2dccb617f6ac73e68db2663ca8cc0_1280.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFF1A1A2E),
                      child: const Icon(
                        Icons.person,
                        size: 100,
                        color: Color(0xFF00D4FF),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mukul Kalambe',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 56,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Flutter Developer | Mobile App Expert | Freelancer',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: const Color(0xFF00D4FF),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: 80,
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'Building apps that inspire.',
                textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: const Color(0xFF9D4EDD),
                  fontWeight: FontWeight.w400,
                ),
                speed: const Duration(milliseconds: 100),
              ),
            ],
            repeatForever: true,
            pause: const Duration(milliseconds: 2000),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'We translate your dreams into reality.',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: const Color(0xFF00FFA3),
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(bool isDesktop) {
    return Wrap(
      spacing: 20,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: [
        _buildGlowButton(
          'Download Resume',
          const Color(0xFF00D4FF),
              () => _launchURL('https://example.com/resume.pdf'),
        ),
        _buildGlowButton(
          'Hire Me',
          const Color(0xFF9D4EDD),
              () => _launchURL('mailto:mukul@example.com'),
        ),
        _buildGlowButton(
          'Explore Projects',
          const Color(0xFF00FFA3),
              () {},
        ),
      ],
    );
  }

  Widget _buildGlowButton(String text, Color color, VoidCallback onPressed) {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: _glowAnimation.value * 0.5),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: color.withValues(alpha: 0.1),
              foregroundColor: color,
              side: BorderSide(color: color, width: 2),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}