class Categorizer {
  static String categorizeExpense(String description) {
    if (description.isEmpty) return 'Others';
    
    final text = description.toLowerCase();
    
    // Food (highest priority)
    if (RegExp(r'(coffee|pizza|chai|biryani|meal|lunch|dinner|cafe|food|zomato|swiggy|breakfast|snack|restaurant|burger|mcd|subway)').hasMatch(text)) {
      return 'Food';
    }
    
    // Transport
    if (RegExp(r'(uber|ola|auto|bus|fuel|petrol|parking|train|metro|rickshaw|taxi)').hasMatch(text)) {
      return 'Transport';
    }
    
    // Shopping
    if (RegExp(r'(h&m|lifestyle|myntra|shirt|t-shirt|jeans|pant|kurta|clothes)').hasMatch(text)) {
      return 'Clothes';
    }
    
    // Entertainment
    if (RegExp(r'(movie|netflix|game|concert|ticket|pickleball|cricket|badminton)').hasMatch(text)) {
      return 'Entertainment';
    }
    
    return 'Others';
  }
  
  static int getConfidence(String text) {
    // Simple confidence based on keyword matches
    int score = 0;
    if (RegExp(r'\d+(?:\.\d+)?\s*(?:rs|rupees?|₹)').hasMatch(text)) score += 20;
    if (text.length > 10) score += 10;
    return (score * 10).clamp(70, 95); // 70-95%
  }
}
