class Quote {
  final String quote;
  final String author;
  Quote({required this.quote, required this.author, quoteAuthor});

  factory Quote.fromJson(Map<String, dynamic> json){
    return Quote(
      quote: json["quote"]["body"],
      author: json["quote"]["author"],
    );
  }
}