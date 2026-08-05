
// Title Case Start
// Capitilizes first letter of each word (seperayed by a space) of the string provided
// Returns:  capitilized string
String titleCase(String text) {
  return text
      .split(' ')
      .map((word) => word.isEmpty
          ? word
          : word[0].toUpperCase() + word.substring(1).toLowerCase())
      .join(' ');
}
// Capitilize First End