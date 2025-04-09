import 'dart:convert';

List<String>? parseStringList(String? jsonString) {
  if (jsonString == null) {
    return null;
  }


  try {
    // Try to decode the JSON string and cast it to List<String>
    List<String> parsedList = List<String>.from(json.decode(jsonString));
    return parsedList;
  } catch (e) {
    // Handle any parsing errors and return null
    return null;
  }
}


List<String>? parseStringListWithQuotes(String? jsonString) {
  if (jsonString == null) {
    return null;
  }
  // Remove double quotes from the string
  String cleanedString = jsonString.replaceAll('"', '');

  // Use your existing parseStringList function to parse the modified string
  return parseStringList(cleanedString);
}