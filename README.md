# Emotion-Detector-Assembly-Proj
Multi-User Emotion Detector Using 8086 Microprocessor  

The objective of this project is to implement a text-based multi-user emotion detector using the 
Intel 8086 microprocessor. It integrates multi-level access control (Admin, User, Guest), password 
authentication with XOR-based encryption, and emotion detection via weighted keyword analysis. 
Students gain hands-on experience in assembly-level string handling, memory management, and 
logical decision-making while exploring basic human-computer interaction concepts. 
Specifications and Requirements: 
Emotion detection is a growing area of human-computer interaction. This project simulates a text
based emotion detection system entirely in 8086 assembly language. Users are authenticated via 
passwords, and statements they input are analyzed for emotion using keyword-based scoring. 
Scores are presented numerically and visually using block characters, and users receive advice 
based on their detected mood. 
1. System Overview 
The system has three main modules: 
A. Access Mode Selection: Admin, User, Guest. \
Admin: Enroll new user, manage encrypted passwords. \ 
User: Authenticate and input sentences for emotion detection. \ 
Guest: Test emotion detection without authentication, visualization, or advice. \ 
B. Password Authentication: XOR-based encryption and validation with masking of input. \ 
C. Emotion Detection: Keyword-based scoring of user input with visual output and advice. 
3. Access Mode Selection 
• Admin Mode: 
• Add new users and passwords to memory. 
• Encrypt all passwords using an XOR key derived from the last non-zero digit of the 
students’ IDs in the team (see detailed description below). 
• The system will support three username–password pairs: two hard-coded accounts 
(representing the two teammates; both usernames and passwords must be explicitly 
1 
stated in the report) and one initially empty account that can be created at runtime 
through the Admin access mode. 
• Each team may choose the maximum allowed lengths for usernames and passwords 
in their system, but these limits must be clearly stated in the report. 
• User Mode: 
• Enter username and password. 
• Password entry displays * for each character for privacy reasons. (Echo a * on the 
screen instead of the actual entered character) 
• Validate password against stored encrypted values. (Hint: Don’t forget the XOR 
encryption). 
• Three attempts allowed; session terminates after three failures. 
• Display a message that indicate whether the access is granted or denied. 
• Once authenticated, the user is asked to enter a statement that define his mood , the 
emotion detection will then output an emotion score numerically and visually (as 
in the examples) to represent it on the screen with suggested advice based on that 
score. 
• Guest Mode: 
• Input statement without authentication. 
• No visualization or advice output. 
4. XOR Key Generation 
• An XOR single-byte key is derived from the last non-zero digit of students’ IDs, 
converted to hex. 
• Example:  
Student#1 → ID: 20181234  
Student#2 → ID: 20230050 
The encryption key: 45h 
Plain password: 50h, 41h, 53h, 53h 
Encrypted password: 15h, 04h, 16h, 16h (using XOR with 45h) 
2 
5. Emotion Detection Design 
Emotion detection is based on weighted keyword scanning. Each user’s input statement (max 
length is 80) is scanned word-by-word to match predefined positive and negative keywords stored 
in the data segment. Each word carries a score between +1 and +3 for positive or -1 and -3 for 
negative emotions. See examples on Table 1. The cumulative score defines the overall mood as 
positive, neutral, or negative.  
• Customize this by choosing your own set of positive and negative words. Create similar 
table as below with your emotional selected words and their scores.   
• Visualize the overall emotion score detected in the statement using a centered bar with 
block characters (review the ASCII table in emu86) as follows: center = 0, right = positive, 
left = negative. 
• Output an advice or suggestion based on that overall score.  
• List all possible overall emotion scores with an example sentence, the corresponding visual 
representation, and your customized advice in another table. Also, provide screenshots of 
your output for each case of these cases.
