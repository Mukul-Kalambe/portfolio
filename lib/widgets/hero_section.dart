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
      width: double.infinity,
      decoration: BoxDecoration(
          // color: Colors.black,
          image: DecorationImage(
              image: AssetImage('assets/img/image2.png'),
              fit: BoxFit.cover,
              opacity: 0.09)),
      height: size.height,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : (isTablet ? 40 : 20),
        // vertical: 40,
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
          // const SizedBox(height: 60),
          // _buildActionButtons(isDesktop),
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
                color: Theme.of(context)
                    .colorScheme
                    .primary
                    .withOpacity(_glowAnimation.value * 0.3),
                blurRadius: 30,
                spreadRadius: 10,
              ),
              BoxShadow(
                color: Theme.of(context)
                    .colorScheme
                    .secondary
                    .withOpacity(_glowAnimation.value * 0.2),
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
                  color: Colors.grey,
                  width: 3,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(137),
                child: Image.asset(
                  "assets/img/photo.jpeg", fit: BoxFit.cover,
                  // loadingBuilder: (context, child, loadingProgress) {
                  //   if (loadingProgress == null) return child;
                  //   return const Center(child: CircularProgressIndicator());
                  // },
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
          'Mukul R. Kalambe',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
                fontSize: 56,
              ),
        ),
        const SizedBox(height: 16),
        Text(
          'Flutter Developer',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: 80,
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'Building beautiful mobile apps with Flutter.',
                textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w400,
                    ),
                speed: const Duration(milliseconds: 100),
              ),
              TypewriterAnimatedText(
                'Creating seamless user experiences.',
                textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w400,
                    ),
                speed: const Duration(milliseconds: 100),
              ),
              TypewriterAnimatedText(
                'Turning ideas into reality.',
                textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
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
          'Passionate about creating innovative mobile solutions that make a difference.',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
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
          'View Projects',
          Theme.of(context).colorScheme.primary,
          () => _scrollToProjects(),
        ),
        _buildGlowButton(
          'Contact Me',
          Theme.of(context).colorScheme.secondary,
          () => _launchURL('mailto:mukul@example.com'),
        ),
        _buildGlowButton(
          'Download Resume',
          Theme.of(context).colorScheme.tertiary,
          () => _launchURL('https://example.com/resume.pdf'),
        ),
      ],
    );
  }

  void _scrollToProjects() {
    // This will be handled by the parent widget's scroll controller
    // For now, we'll just scroll to a specific offset
    // In a real implementation, you'd pass a callback from the parent
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
                color: color.withOpacity(_glowAnimation.value * 0.3),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: color.withOpacity(0.1),
              foregroundColor: color,
              side: BorderSide(color: color, width: 2),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 0,
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
