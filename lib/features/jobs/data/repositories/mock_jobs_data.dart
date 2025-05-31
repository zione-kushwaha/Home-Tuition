import '../models/index.dart';

/// Mock data provider for jobs and applications
class MockJobsData {
  // Private constructor
  MockJobsData._();

  /// Get mock jobs for testing and development
  static List<Job> getMockJobs() {
    return [
      Job(
        id: "job-001",
        title: "Mathematics Teacher",
        institutionId: "inst-001",
        institutionName: "Excellence Academy",
        description:
            "We're looking for an experienced mathematics teacher for grades 9-12, specializing in CBSE curriculum. The candidate should have strong knowledge of advanced mathematics concepts and ability to prepare students for competitive exams.",
        salary: "₹35,000 - ₹45,000 per month",
        location: "Delhi",
        subjects: ["Mathematics"],
        requirements: [
          "B.Sc/M.Sc in Mathematics",
          "B.Ed degree",
          "Minimum 3 years of teaching experience",
          "Good communication skills",
          "Proficiency in English",
        ],
        postedDate: DateTime.now().subtract(const Duration(days: 5)),
        applicationDeadline: DateTime.now().add(const Duration(days: 15)),
        jobType: "Full-time",
        applicationsCount: 12,
        contactEmail: "careers@excellenceacademy.edu",
        contactPhone: "9876543210",
      ),
      Job(
        id: "job-002",
        title: "Science Faculty",
        institutionId: "inst-002",
        institutionName: "Bright Future School",
        description:
            "We are hiring Science teachers (Physics, Chemistry, Biology) for grades 8-10. The ideal candidate will have hands-on experience with laboratory demonstrations and can make difficult concepts easy to understand.",
        salary: "₹30,000 - ₹40,000 per month",
        location: "Mumbai",
        subjects: ["Physics", "Chemistry", "Biology"],
        requirements: [
          "B.Sc/M.Sc in relevant science field",
          "B.Ed degree preferred",
          "2+ years teaching experience",
          "Strong laboratory skills",
          "Ability to create engaging lesson plans",
        ],
        postedDate: DateTime.now().subtract(const Duration(days: 3)),
        applicationDeadline: DateTime.now().add(const Duration(days: 20)),
        jobType: "Full-time",
        applicationsCount: 8,
        contactEmail: "hr@brightfuture.edu",
        contactPhone: "9876123450",
      ),
      Job(
        id: "job-003",
        title: "Home Tutor for IIT-JEE",
        institutionId: "inst-003",
        institutionName: "Success Point Coaching",
        description:
            "Looking for experienced tutors for home tutoring services focusing on IIT-JEE preparation. The tutor will be responsible for personalized coaching to students at their homes.",
        salary: "₹600 - ₹800 per hour",
        location: "Bangalore",
        subjects: ["Physics", "Mathematics"],
        requirements: [
          "M.Sc in Physics/Mathematics",
          "Prior experience in IIT-JEE coaching",
          "Excellent command over subject",
          "Willing to travel within the city",
          "Flexible schedule",
        ],
        postedDate: DateTime.now().subtract(const Duration(days: 1)),
        jobType: "Part-time",
        applicationsCount: 5,
        contactEmail: "tutors@successpoint.com",
      ),
      Job(
        id: "job-004",
        title: "English Language Trainer",
        institutionId: "inst-004",
        institutionName: "Global Language School",
        description:
            "We are looking for proficient English language trainers to conduct classes for spoken English, writing, and grammar for students of all age groups.",
        salary: "₹25,000 - ₹35,000 per month",
        location: "Hyderabad",
        subjects: ["English"],
        requirements: [
          "Bachelor's degree in English/Literature",
          "TEFL/TESOL certification preferred",
          "Native-like fluency in English",
          "Prior teaching experience",
          "Creative teaching methodology",
        ],
        postedDate: DateTime.now().subtract(const Duration(days: 7)),
        applicationDeadline: DateTime.now().add(const Duration(days: 10)),
        jobType: "Full-time",
        applicationsCount: 15,
        contactEmail: "jobs@globallanguage.in",
        contactPhone: "9712345678",
      ),
      Job(
        id: "job-005",
        title: "Computer Science Teacher",
        institutionId: "inst-001",
        institutionName: "Excellence Academy",
        description:
            "Seeking a computer science teacher for grades 11-12 with expertise in programming languages (Python, Java) and computer fundamentals.",
        salary: "₹40,000 - ₹50,000 per month",
        location: "Delhi",
        subjects: ["Computer Science"],
        requirements: [
          "B.Tech/M.Tech in Computer Science",
          "Teaching experience preferred",
          "Strong programming skills",
          "Knowledge of latest technologies",
          "Ability to conduct practical classes",
        ],
        postedDate: DateTime.now().subtract(const Duration(days: 2)),
        applicationDeadline: DateTime.now().add(const Duration(days: 25)),
        jobType: "Full-time",
        applicationsCount: 7,
        contactEmail: "careers@excellenceacademy.edu",
      ),
    ];
  }

  /// Get mock job applications for testing and development
  static List<JobApplication> getMockApplications() {
    return [
      JobApplication(
        id: "app-001",
        jobId: "job-001",
        userId: "user-001",
        userName: "Rahul Sharma",
        userProfileImage: "https://randomuser.me/api/portraits/men/32.jpg",
        coverLetter:
            "I am an experienced mathematics teacher with 8 years of experience teaching CBSE curriculum. I have helped many students achieve excellent results in board exams and competitive examinations.",
        resumeUrl: "https://example.com/resumes/rahul_sharma.pdf",
        appliedDate: DateTime.now().subtract(const Duration(days: 3)),
        status: ApplicationStatus.shortlisted,
        statusUpdatedDate: DateTime.now().subtract(const Duration(days: 1)),
      ),
      JobApplication(
        id: "app-002",
        jobId: "job-001",
        userId: "user-002",
        userName: "Priya Patel",
        userProfileImage: "https://randomuser.me/api/portraits/women/44.jpg",
        coverLetter:
            "As a mathematics educator with 5 years of experience, I specialize in making complex mathematical concepts accessible to students of all learning styles.",
        resumeUrl: "https://example.com/resumes/priya_patel.pdf",
        appliedDate: DateTime.now().subtract(const Duration(days: 4)),
        status: ApplicationStatus.pending,
      ),
      JobApplication(
        id: "app-003",
        jobId: "job-003",
        userId: "user-001",
        userName: "Rahul Sharma",
        userProfileImage: "https://randomuser.me/api/portraits/men/32.jpg",
        coverLetter:
            "I have been coaching students for IIT-JEE for the past 6 years with excellent results. Many of my students have secured admissions in top IITs.",
        resumeUrl: "https://example.com/resumes/rahul_sharma.pdf",
        appliedDate: DateTime.now().subtract(const Duration(hours: 12)),
        status: ApplicationStatus.pending,
      ),
      JobApplication(
        id: "app-004",
        jobId: "job-002",
        userId: "user-003",
        userName: "Amit Kumar",
        userProfileImage: "https://randomuser.me/api/portraits/men/68.jpg",
        coverLetter:
            "I am a passionate science teacher with expertise in physics and chemistry. I believe in practical demonstrations to make concepts clear.",
        resumeUrl: "https://example.com/resumes/amit_kumar.pdf",
        appliedDate: DateTime.now().subtract(const Duration(days: 2)),
        status: ApplicationStatus.reviewed,
        statusUpdatedDate: DateTime.now().subtract(const Duration(hours: 6)),
      ),
    ];
  }
}
