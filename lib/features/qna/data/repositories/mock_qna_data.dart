import '../models/index.dart';

/// Mock data for Q&A feature
class MockQnaData {
  // Private constructor
  MockQnaData._();
  
  /// Get mock questions for testing and development
  static List<Question> getMockQuestions() {
    return [
      Question(
        id: "q-001",
        title: "How to solve quadratic equations using the quadratic formula?",
        content: "I'm struggling with quadratic equations. Can someone explain how to use the quadratic formula step by step? I especially have trouble with complex roots.",
        userId: "user-004",
        userName: "Sunita Verma",
        userProfileImage: "https://randomuser.me/api/portraits/women/65.jpg",
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        tags: ["Mathematics", "Algebra", "Quadratic Equations"],
        upvotes: 15,
        downvotes: 2,
        viewCount: 87,
        answerCount: 3,
        isSolved: true,
        acceptedAnswerId: "a-001",
        comments: [
          Comment(
            id: "c-001",
            content: "I'm having the same issue! Looking forward to answers.",
            userId: "user-006",
            userName: "Vikram Singh",
            createdAt: DateTime.now().subtract(const Duration(days: 3, hours: 2)),
          ),
          Comment(
            id: "c-002",
            content: "Have you tried watching Khan Academy videos? They have great explanations.",
            userId: "user-002",
            userName: "Priya Patel",
            userProfileImage: "https://randomuser.me/api/portraits/women/44.jpg",
            createdAt: DateTime.now().subtract(const Duration(days: 3, hours: 1)),
          ),
        ],
      ),
      Question(
        id: "q-002",
        title: "What are the best books for JEE Physics preparation?",
        content: "I'm currently preparing for JEE Main and Advanced. Need recommendations for physics books that cover both theoretical concepts and have good practice problems.",
        userId: "user-004",
        userName: "Sunita Verma",
        userProfileImage: "https://randomuser.me/api/portraits/women/65.jpg",
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
        tags: ["Physics", "JEE", "Books", "Competitive Exams"],
        upvotes: 28,
        downvotes: 0,
        viewCount: 215,
        answerCount: 5,
        isSolved: true,
        acceptedAnswerId: "a-003",
      ),
      Question(
        id: "q-003",
        title: "Tips for teaching English grammar to non-native speakers?",
        content: "I'm starting as an English teacher at a language school next month. Most students are non-native speakers. What approaches work best for teaching complex grammar rules?",
        userId: "user-007",
        userName: "Neha Gupta",
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
        tags: ["English", "Grammar", "Teaching", "ESL"],
        upvotes: 37,
        downvotes: 3,
        viewCount: 189,
        answerCount: 8,
        isSolved: false,
      ),
      Question(
        id: "q-004",
        title: "How to explain photosynthesis with simple experiments?",
        content: "Looking for simple experiments I can conduct in class to demonstrate photosynthesis to 8th-grade students. Ideally, something that can be done with basic materials.",
        userId: "user-003",
        userName: "Amit Kumar",
        userProfileImage: "https://randomuser.me/api/portraits/men/68.jpg",
        createdAt: DateTime.now().subtract(const Duration(days: 14)),
        tags: ["Science", "Biology", "Experiments", "Teaching"],
        upvotes: 42,
        downvotes: 1,
        viewCount: 275,
        answerCount: 6,
        isSolved: true,
        acceptedAnswerId: "a-010",
      ),
      Question(
        id: "q-005",
        title: "How to motivate students who are falling behind?",
        content: "I have a few students in my class who are consistently falling behind. They seem disinterested and don't complete assignments. How can I motivate them without singling them out?",
        userId: "user-001",
        userName: "Rahul Sharma",
        userProfileImage: "https://randomuser.me/api/portraits/men/32.jpg",
        createdAt: DateTime.now().subtract(const Duration(days: 21)),
        tags: ["Education", "Motivation", "Classroom Management"],
        upvotes: 56,
        downvotes: 2,
        viewCount: 342,
        answerCount: 12,
        isSolved: true,
        acceptedAnswerId: "a-014",
      ),
    ];
  }
  
  /// Get mock answers for a specific question
  static List<Answer> getMockAnswersForQuestion(String questionId) {
    switch (questionId) {
      case "q-001":
        return [
          Answer(
            id: "a-001",
            questionId: "q-001",
            content: "The quadratic formula is used to solve equations in the form ax² + bx + c = 0. The formula is x = (-b ± √(b² - 4ac)) / 2a. Here's how to use it step by step:\n\n1. Identify the values of a, b, and c from your equation\n2. Substitute these values into the formula\n3. Calculate the discriminant (b² - 4ac)\n4. If the discriminant is positive, you'll get two real solutions\n5. If it's zero, you'll get one real solution (repeated)\n6. If it's negative, you'll get complex solutions\n\nFor complex roots, when the discriminant is negative, you'll express the answer in the form p + qi and p - qi, where i is the square root of -1.\n\nExample: For 2x² + 5x + 2 = 0\na = 2, b = 5, c = 2\nx = (-5 ± √(25 - 16)) / 4\nx = (-5 ± √9) / 4\nx = (-5 ± 3) / 4\nSo x = -2 or x = -0.5",
            userId: "user-001",
            userName: "Rahul Sharma",
            userProfileImage: "https://randomuser.me/api/portraits/men/32.jpg",
            createdAt: DateTime.now().subtract(const Duration(days: 3, hours: 5)),
            upvotes: 22,
            downvotes: 0,
            isAccepted: true,
            comments: [
              Comment(
                id: "c-003",
                content: "This explanation really helped me! Thanks!",
                userId: "user-004",
                userName: "Sunita Verma",
                userProfileImage: "https://randomuser.me/api/portraits/women/65.jpg",
                createdAt: DateTime.now().subtract(const Duration(days: 3, hours: 3)),
              ),
            ],
          ),
          Answer(
            id: "a-002",
            questionId: "q-001",
            content: "I find it helpful to think of the discriminant (b² - 4ac) as a way to determine the number and type of solutions:\n\n- If b² - 4ac > 0, two distinct real solutions\n- If b² - 4ac = 0, one repeated real solution\n- If b² - 4ac < 0, two complex conjugate solutions\n\nFor complex roots, remember that √(negative number) = i√(positive number).\n\nFor example, if you have x² + 2x + 5 = 0:\na = 1, b = 2, c = 5\nDiscriminant = 4 - 20 = -16\n\nx = (-2 ± √(-16)) / 2\nx = (-2 ± 4i) / 2\nx = -1 ± 2i\n\nSo your solutions are -1 + 2i and -1 - 2i",
            userId: "user-002",
            userName: "Priya Patel",
            userProfileImage: "https://randomuser.me/api/portraits/women/44.jpg",
            createdAt: DateTime.now().subtract(const Duration(days: 2, hours: 8)),
            upvotes: 15,
            downvotes: 1,
            isAccepted: false,
          ),
        ];
      default:
        return [];
    }
  }
  
  /// Get all mock answers
  static List<Answer> getAllMockAnswers() {
    final List<Answer> allAnswers = [];
    
    // Add answers from each question
    allAnswers.addAll(getMockAnswersForQuestion("q-001"));
    // Add more answers for other questions as needed
    
    return allAnswers;
  }
}
