import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _formController;
  late List<AnimationController> _inputControllers;
  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _textControllers;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _formController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _inputControllers = List.generate(4, (_) => AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    ));

    _focusNodes = List.generate(4, (_) => FocusNode());
    _textControllers = List.generate(4, (_) => TextEditingController());

    for (int i = 0; i < _focusNodes.length; i++) {
      _focusNodes[i].addListener(() {
        if (_focusNodes[i].hasFocus) {
          _inputControllers[i].forward();
        } else {
          _inputControllers[i].reverse();
        }
      });
    }

    _controller.forward();
    _formController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _formController.dispose();
    for (var controller in _inputControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    for (var textController in _textControllers) {
      textController.dispose();
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
          if (isDesktop) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 1, child: _buildContactInfo()),
                const SizedBox(width: 60),
                Expanded(flex: 2, child: _buildContactForm()),
              ],
            ),
          ] else ...[
            _buildContactForm(),
            const SizedBox(height: 40),
            _buildContactInfo(),
          ],
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
            'Let\'s Build Something Together',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
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
            'Have a project in mind? Let\'s discuss how we can bring your vision to life.',
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

  Widget _buildContactForm() {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
          .animate(_formController),
      child: Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: const Color(0xFF1A1A2E).withValues(alpha: 0.6),
          border: Border.all(
            color: const Color(0xFF00D4FF).withValues(alpha: 0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF00D4FF).withValues(alpha: 0.1),
              blurRadius: 25,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Send Message',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),

              _buildAnimatedTextField(
                controller: _textControllers[0],
                focusNode: _focusNodes[0],
                animationController: _inputControllers[0],
                label: 'Full Name',
                icon: Icons.person,
                validator: (value) => value?.isEmpty ?? true ? 'Please enter your name' : null,
              ),

              const SizedBox(height: 24),

              _buildAnimatedTextField(
                controller: _textControllers[1],
                focusNode: _focusNodes[1],
                animationController: _inputControllers[1],
                label: 'Email Address',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value?.isEmpty ?? true ? 'Please enter your email' : null,
              ),

              const SizedBox(height: 24),

              _buildAnimatedTextField(
                controller: _textControllers[2],
                focusNode: _focusNodes[2],
                animationController: _inputControllers[2],
                label: 'Subject',
                icon: Icons.subject,
                validator: (value) => value?.isEmpty ?? true ? 'Please enter a subject' : null,
              ),

              const SizedBox(height: 24),

              _buildAnimatedTextField(
                controller: _textControllers[3],
                focusNode: _focusNodes[3],
                animationController: _inputControllers[3],
                label: 'Message',
                icon: Icons.message,
                maxLines: 5,
                validator: (value) => value?.isEmpty ?? true ? 'Please enter your message' : null,
              ),

              const SizedBox(height: 40),

              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required AnimationController animationController,
    required String label,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00D4FF).withValues(alpha: animationController.value * 0.2),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            maxLines: maxLines,
            keyboardType: keyboardType,
            validator: validator,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(
                color: const Color(0xFF00D4FF).withValues(alpha: 0.7),
                fontWeight: FontWeight.w500,
              ),
              prefixIcon: Icon(
                icon,
                color: const Color(0xFF00D4FF),
              ),
              filled: true,
              fillColor: const Color(0xFF0A0A0A).withValues(alpha: 0.8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: const Color(0xFF00D4FF).withValues(alpha: 0.3),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: const Color(0xFF00D4FF).withValues(alpha: 0.3),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Color(0xFF00D4FF),
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Color(0xFFFF4081),
                  width: 2,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _submitForm,
        icon: const Icon(Icons.send, size: 20),
        label: const Text(
          'Send Message',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00D4FF),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 5,
        ),
      ),
    );
  }

  Widget _buildContactInfo() {
    final contactItems = [
      {
        'icon': FontAwesomeIcons.envelope,
        'title': 'Email',
        'subtitle': 'mukul@example.com',
        'action': () => _launchURL('mailto:mukul@example.com'),
        'color': Color(0xFF00D4FF),
      },
      {
        'icon': FontAwesomeIcons.phone,
        'title': 'Phone',
        'subtitle': '+1 (555) 123-4567',
        'action': () => _launchURL('tel:+15551234567'),
        'color': Color(0xFF9D4EDD),
      },
      {
        'icon': FontAwesomeIcons.locationDot,
        'title': 'Location',
        'subtitle': 'Mumbai, India',
        'action': () {},
        'color': Color(0xFF00FFA3),
      },
      {
        'icon': FontAwesomeIcons.linkedin,
        'title': 'LinkedIn',
        'subtitle': '/in/mukulkalambe',
        'action': () => _launchURL('https://linkedin.com/in/mukulkalambe'),
        'color': Color(0xFF00D4FF),
      },
    ];

    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(-0.3, 0), end: Offset.zero)
          .animate(_formController),
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: const Color(0xFF1A1A2E).withValues(alpha: 0.6),
          border: Border.all(
            color: const Color(0xFF9D4EDD).withValues(alpha: 0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF9D4EDD).withValues(alpha: 0.1),
              blurRadius: 25,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Get In Touch',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Feel free to reach out through any of these channels. I\'m always excited to discuss new opportunities and interesting projects.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white.withValues(alpha: 0.8),
                height: 1.6,
              ),
            ),
            const SizedBox(height: 30),

            ...contactItems.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _buildContactItem(
                item['icon'] as IconData,
                item['title'] as String,
                item['subtitle'] as String,
                item['color'] as Color,
                item['action'] as VoidCallback,
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(
      IconData icon,
      String title,
      String subtitle,
      Color color,
      VoidCallback onTap,
      ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: color.withValues(alpha: 0.1),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: color,
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Handle form submission
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Color(0xFF00FFA3)),
              const SizedBox(width: 12),
              const Text('Message sent successfully!'),
            ],
          ),
          backgroundColor: const Color(0xFF1A1A2E),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(
              color: Color(0xFF00FFA3),
              width: 1,
            ),
          ),
        ),
      );

      // Clear form
      for (var controller in _textControllers) {
        controller.clear();
      }
    }
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}