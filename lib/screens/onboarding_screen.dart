import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dashboard_screen.dart';

class OnboardingScreen extends StatefulWidget {
  final String userRole;
  const OnboardingScreen({Key? key, required this.userRole}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  late final List<Widget> _pages;
  final _personalDetailsFormKey = GlobalKey<FormState>();
  final _addressFormKey = GlobalKey<FormState>();
  final _emergencyContactFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _pages = [
      _OnboardingStep(
        key: const ValueKey('page1'),
        icon: Icons.person_search_rounded,
        title: "Student's Personal Details",
        subtitle: "Let's start with the basics.",
        child: _PersonalDetailsForm(formKey: _personalDetailsFormKey),
      ),
      _OnboardingStep(
        key: const ValueKey('page2'),
        icon: Icons.home_work_outlined,
        title: "Student's Address",
        subtitle: "Where can we reach you?",
        child: _AddressDetailsForm(formKey: _addressFormKey),
      ),
      _OnboardingStep(
        key: const ValueKey('page3'),
        icon: Icons.contact_emergency_outlined,
        title: 'Emergency Contact',
        subtitle: "Who should we contact in case of an emergency?",
        child: _EmergencyContactForm(formKey: _emergencyContactFormKey),
      ),
      _WelcomeStep(userRole: widget.userRole, key: const ValueKey('page4')),
    ];
  }

  void _onNextPage() {
    // Validate the current form before proceeding
    bool isFormValid = false;
    if (_currentPage == 0) {
      isFormValid = _personalDetailsFormKey.currentState?.validate() ?? false;
    } else if (_currentPage == 1) {
      isFormValid = _addressFormKey.currentState?.validate() ?? false;
    } else if (_currentPage == 2) {
      isFormValid = _emergencyContactFormKey.currentState?.validate() ?? false;
    } else {
      isFormValid = true; // Welcome screen doesn't have a form
    }

    if (!isFormValid) return; // Stop if form is not valid

    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => DashboardScreen(userRole: widget.userRole)));
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor.withOpacity(0.9), const Color(0xFF2D3748)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) =>
                      setState(() => _currentPage = index),
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    // Apply animation to each page
                    return _pages[index]
                        .animate(key: ValueKey(index))
                        .fadeIn(duration: 500.ms)
                        .scale(
                            begin: const Offset(0.95, 0.95),
                            end: const Offset(1, 1),
                            curve: Curves.easeOut);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: List.generate(_pages.length, (index) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.only(right: 8),
                          height: 10,
                          width: _currentPage == index ? 30 : 10,
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? Colors.white
                                : Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        );
                      }),
                    ),
                    ElevatedButton(
                      onPressed: _onNextPage,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: primaryColor),
                      child: Text(_currentPage == _pages.length - 1
                          ? 'Go to Dashboard'
                          : 'Next'),
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

class _OnboardingStep extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget child;

  const _OnboardingStep(
      {required this.icon,
      required this.title,
      required this.subtitle,
      required this.child,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Icon(icon, size: 80, color: Colors.white.withOpacity(0.8)),
          const SizedBox(height: 24),
          Text(title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 8),
          Text(subtitle,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.white.withOpacity(0.7))),
          const SizedBox(height: 32),
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: child),
            ),
          ),
        ],
      ),
    );
  }
}

// --- FORM WIDGETS ---
class _PersonalDetailsForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  const _PersonalDetailsForm({required this.formKey});

  @override
  State<_PersonalDetailsForm> createState() => _PersonalDetailsFormState();
}

class _PersonalDetailsFormState extends State<_PersonalDetailsForm> {
  DateTime? _selectedDate;
  final List<String> _bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-'
  ];
  String? _selectedBloodGroup;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate ?? DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now());
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          _buildTextField(
              label: "Full Name",
              hint: "Enter student's full name",
              validator: (v) =>
                  (v == null || v.isEmpty) ? "Please enter a name" : null),
          const SizedBox(height: 20),
          _buildDatePickerField(context),
          const SizedBox(height: 20),
          _buildDropdownField(),
        ],
      ),
    );
  }

  Widget _buildDatePickerField(BuildContext context) {
    return FormField<DateTime>(
        validator: (value) =>
            _selectedDate == null ? 'Please select a date' : null,
        builder: (formFieldState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () async {
                  await _selectDate(context);
                  formFieldState.didChange(_selectedDate);
                },
                child: InputDecorator(
                  decoration:
                      _buildInputDecoration(label: "Date of Birth").copyWith(
                    errorText: formFieldState.errorText,
                  ),
                  child: Text(
                    _selectedDate != null
                        ? DateFormat.yMMMd().format(_selectedDate!)
                        : 'Select Date',
                    style: TextStyle(
                        color: _selectedDate != null
                            ? Colors.white
                            : Colors.white.withOpacity(0.7)),
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget _buildDropdownField() {
    return DropdownButtonFormField<String>(
      value: _selectedBloodGroup,
      validator: (value) =>
          value == null ? 'Please select a blood group' : null,
      decoration: _buildInputDecoration(label: "Blood Group"),
      dropdownColor: const Color(0xFF4A5568),
      icon: const Icon(Icons.arrow_drop_down, color: Colors.white70),
      style: const TextStyle(color: Colors.white),
      items: _bloodGroups
          .map((group) => DropdownMenuItem(value: group, child: Text(group)))
          .toList(),
      onChanged: (value) => setState(() => _selectedBloodGroup = value),
    );
  }
}

class _AddressDetailsForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const _AddressDetailsForm({required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          _buildTextField(
              label: "Street Address",
              hint: "Enter student's address",
              maxLines: 2,
              validator: (v) =>
                  (v == null || v.isEmpty) ? "Please enter an address" : null),
          const SizedBox(height: 20),
          _buildTextField(
              label: "City",
              hint: "Enter city",
              validator: (v) =>
                  (v == null || v.isEmpty) ? "Please enter a city" : null),
          const SizedBox(height: 20),
          _buildTextField(
              label: "Postal Code",
              hint: "Enter postal code",
              keyboardType: TextInputType.number,
              validator: (v) => (v == null || v.isEmpty)
                  ? "Please enter a postal code"
                  : null),
        ],
      ),
    );
  }
}

class _EmergencyContactForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const _EmergencyContactForm({required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          _buildTextField(
              label: "Contact's Full Name",
              hint: "e.g., John Doe",
              validator: (v) =>
                  (v == null || v.isEmpty) ? "Please enter a name" : null),
          const SizedBox(height: 20),
          _buildTextField(
              label: "Relationship",
              hint: "e.g., Father, Mother",
              validator: (v) => (v == null || v.isEmpty)
                  ? "Please enter a relationship"
                  : null),
          const SizedBox(height: 20),
          _buildTextField(
              label: "Phone Number",
              hint: "Enter phone number",
              keyboardType: TextInputType.phone,
              validator: (v) => (v == null || v.isEmpty)
                  ? "Please enter a phone number"
                  : null),
        ],
      ),
    );
  }
}

class _WelcomeStep extends StatelessWidget {
  final String userRole;
  const _WelcomeStep({required this.userRole, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle_outline_rounded,
              size: 120, color: Colors.white),
          const SizedBox(height: 32),
          Text("You're All Set!",
              style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              textAlign: TextAlign.center),
          const SizedBox(height: 16),
          Text(
              "Thank you for providing the necessary information. Let's proceed to the dashboard.",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.white.withOpacity(0.8)),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

// --- SHARED HELPER WIDGETS ---
Widget _buildTextField(
    {required String label,
    required String hint,
    int? maxLines,
    TextInputType? keyboardType,
    String? Function(String?)? validator}) {
  return TextFormField(
    decoration: _buildInputDecoration(label: label, hint: hint),
    keyboardType: keyboardType,
    maxLines: maxLines ?? 1,
    style: const TextStyle(color: Colors.white),
    validator: validator,
  );
}

InputDecoration _buildInputDecoration({required String label, String? hint}) {
  return InputDecoration(
    labelText: label,
    hintText: hint,
    labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
    hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
    filled: true,
    fillColor: Colors.black.withOpacity(0.2),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white, width: 1.5)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.3))),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.5)),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 2)),
  );
}
