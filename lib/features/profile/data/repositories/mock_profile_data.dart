import '../models/index.dart';

/// Mock data provider for profiles
class MockProfileData {
  // Private constructor
  MockProfileData._();

  /// Get mock profiles for testing and development
  static List<Profile> getMockProfiles() {
    return [
      Profile(
        id: "profile-001",
        userId: "user-001",
        name: "Rahul Sharma",
        email: "rahul.sharma@example.com",
        role: "TEACHER",
        phoneNumber: "+91 9876543210",
        profileImageUrl: "https://randomuser.me/api/portraits/men/32.jpg",
        address: "123 Teacher Colony, Delhi",
        bio: "Experienced mathematics teacher with 8+ years of expertise in CBSE curriculum. Specialized in preparing students for competitive examinations like JEE and NEET.",
        education: [
          Education(
            id: "edu-001",
            institution: "Delhi University",
            degree: "Master of Science",
            fieldOfStudy: "Mathematics",
            startDate: DateTime(2012),
            endDate: DateTime(2014),
            isCurrentlyStudying: false,
            description: "Specialized in Applied Mathematics and Statistics",
          ),
          Education(
            id: "edu-002",
            institution: "Delhi University",
            degree: "Bachelor of Science",
            fieldOfStudy: "Mathematics",
            startDate: DateTime(2009),
            endDate: DateTime(2012),
            isCurrentlyStudying: false,
          ),
        ],
        experience: [
          Experience(
            id: "exp-001",
            title: "Mathematics Teacher",
            organization: "Excellence Academy",
            location: "Delhi",
            startDate: DateTime(2019),
            isCurrentPosition: true,
            description: "Teaching mathematics to grades 11-12, specialized in JEE preparation",
          ),
          Experience(
            id: "exp-002",
            title: "Mathematics Instructor",
            organization: "Success Point Coaching",
            location: "Delhi",
            startDate: DateTime(2015),
            endDate: DateTime(2019),
            isCurrentPosition: false,
            description: "Taught mathematics to grades 9-10, focusing on CBSE curriculum",
          ),
        ],
        skills: [
          Skill(id: "skill-001", name: "Mathematics", proficiencyLevel: 5, isVerified: true),
          Skill(id: "skill-002", name: "Calculus", proficiencyLevel: 5),
          Skill(id: "skill-003", name: "Algebra", proficiencyLevel: 5),
          Skill(id: "skill-004", name: "Statistics", proficiencyLevel: 4),
          Skill(id: "skill-005", name: "Physics", proficiencyLevel: 3),
        ],
        certificates: [
          Certificate(
            id: "cert-001",
            name: "Certified Mathematics Educator",
            issuingOrganization: "National Board of Education",
            issueDate: DateTime(2016),
            credentialId: "CME-123456",
          ),
          Certificate(
            id: "cert-002",
            name: "Advanced Teaching Methodologies",
            issuingOrganization: "Teacher Training Institute",
            issueDate: DateTime(2018),
          ),
        ],
      ),
      Profile(
        id: "profile-002",
        userId: "user-002",
        name: "Priya Patel",
        email: "priya.patel@example.com",
        role: "TEACHER",
        phoneNumber: "+91 9876543211",
        profileImageUrl: "https://randomuser.me/api/portraits/women/44.jpg",
        address: "456 Teacher Lane, Mumbai",
        bio: "Dedicated English language teacher with a passion for literature and creative writing. Specialized in helping students improve their communication skills.",
        education: [
          Education(
            id: "edu-003",
            institution: "Mumbai University",
            degree: "Master of Arts",
            fieldOfStudy: "English Literature",
            startDate: DateTime(2013),
            endDate: DateTime(2015),
            isCurrentlyStudying: false,
          ),
          Education(
            id: "edu-004",
            institution: "Mumbai University",
            degree: "Bachelor of Arts",
            fieldOfStudy: "English",
            startDate: DateTime(2010),
            endDate: DateTime(2013),
            isCurrentlyStudying: false,
          ),
        ],
        experience: [
          Experience(
            id: "exp-003",
            title: "English Teacher",
            organization: "Global Language School",
            location: "Mumbai",
            startDate: DateTime(2018),
            isCurrentPosition: true,
            description: "Teaching English language and literature to students of all levels",
          ),
          Experience(
            id: "exp-004",
            title: "Content Writer",
            organization: "EduPublish Inc.",
            location: "Mumbai",
            startDate: DateTime(2015),
            endDate: DateTime(2018),
            isCurrentPosition: false,
            description: "Created educational content for English textbooks and study materials",
          ),
        ],
        skills: [
          Skill(id: "skill-006", name: "English Language", proficiencyLevel: 5, isVerified: true),
          Skill(id: "skill-007", name: "Creative Writing", proficiencyLevel: 5),
          Skill(id: "skill-008", name: "Public Speaking", proficiencyLevel: 4),
          Skill(id: "skill-009", name: "Grammar", proficiencyLevel: 5),
        ],
        certificates: [
          Certificate(
            id: "cert-003",
            name: "TEFL Certification",
            issuingOrganization: "Cambridge English",
            issueDate: DateTime(2016),
            credentialId: "TEFL-789012",
          ),
        ],
      ),
      Profile(
        id: "profile-003",
        userId: "user-003",
        name: "Amit Kumar",
        email: "amit.kumar@example.com",
        role: "TEACHER",
        phoneNumber: "+91 9876543212",
        profileImageUrl: "https://randomuser.me/api/portraits/men/68.jpg",
        address: "789 Science Park, Bangalore",
        bio: "Passionate science teacher with expertise in physics and chemistry. I believe in practical demonstrations and hands-on learning to make concepts clear.",
        education: [
          Education(
            id: "edu-005",
            institution: "Indian Institute of Science",
            degree: "Master of Science",
            fieldOfStudy: "Physics",
            startDate: DateTime(2014),
            endDate: DateTime(2016),
            isCurrentlyStudying: false,
            description: "Specialized in Theoretical Physics",
          ),
          Education(
            id: "edu-006",
            institution: "Bangalore University",
            degree: "Bachelor of Science",
            fieldOfStudy: "Physics and Chemistry",
            startDate: DateTime(2011),
            endDate: DateTime(2014),
            isCurrentlyStudying: false,
          ),
        ],
        experience: [
          Experience(
            id: "exp-005",
            title: "Science Faculty",
            organization: "Bright Future School",
            location: "Bangalore",
            startDate: DateTime(2017),
            isCurrentPosition: true,
            description: "Teaching Physics and Chemistry to grades 9-12 with focus on laboratory experiments",
          ),
        ],
        skills: [
          Skill(id: "skill-010", name: "Physics", proficiencyLevel: 5, isVerified: true),
          Skill(id: "skill-011", name: "Chemistry", proficiencyLevel: 4),
          Skill(id: "skill-012", name: "Laboratory Management", proficiencyLevel: 4),
        ],
        certificates: [
          Certificate(
            id: "cert-004",
            name: "Advanced Laboratory Techniques",
            issuingOrganization: "National Science Academy",
            issueDate: DateTime(2017),
          ),
        ],
      ),
      Profile(
        id: "profile-004",
        userId: "user-004",
        name: "Sunita Verma",
        email: "sunita.verma@example.com",
        role: "STUDENT",
        phoneNumber: "+91 9876543213",
        profileImageUrl: "https://randomuser.me/api/portraits/women/65.jpg",
        address: "101 Student Hostel, Delhi",
        bio: "Aspiring computer scientist currently pursuing undergraduate studies. Interested in artificial intelligence and machine learning.",
        education: [
          Education(
            id: "edu-007",
            institution: "Delhi Technological University",
            degree: "Bachelor of Technology",
            fieldOfStudy: "Computer Science",
            startDate: DateTime(2021),
            isCurrentlyStudying: true,
            description: "Focusing on Artificial Intelligence and Machine Learning",
          ),
        ],
        skills: [
          Skill(id: "skill-013", name: "Python", proficiencyLevel: 4),
          Skill(id: "skill-014", name: "Java", proficiencyLevel: 3),
          Skill(id: "skill-015", name: "Machine Learning", proficiencyLevel: 2),
        ],
        certificates: [
          Certificate(
            id: "cert-005",
            name: "Python for Data Science",
            issuingOrganization: "Coursera",
            issueDate: DateTime(2022),
            credentialUrl: "https://coursera.org/verify/123456",
          ),
        ],
      ),
      Profile(
        id: "profile-005",
        userId: "user-005",
        name: "Excellence Academy",
        email: "info@excellenceacademy.edu",
        role: "COACHING_CENTER",
        phoneNumber: "+91 9876543214",
        profileImageUrl: "https://images.unsplash.com/photo-1577896851231-70ef18881754",
        address: "1 Excellence Way, Delhi",
        bio: "Premier coaching institute specializing in IIT-JEE and NEET preparation with a track record of success. Our students consistently achieve top ranks.",
        roleSpecificData: {
          "establishedYear": 2008,
          "studentCount": 500,
          "teacherCount": 25,
          "courses": ["IIT-JEE", "NEET", "Foundation Courses", "Olympiad Training"],
          "achievements": [
            "15 students in IIT-JEE Top 100 (2024)",
            "25+ students in NEET Top 500 (2024)",
            "Best Coaching Center Award (2023)"
          ],
          "facilities": ["Digital Classrooms", "Library", "Test Series", "Doubt Sessions"]
        },
      ),
    ];
  }
}
