class Term extends Shape {
  String content;

  Term() {
    this(3, 8);
  }

  Term(String content, float scale) {
    setcontent(content);
    setScale(scale);
  }

  Term(int content, float scale) {
    setcontent(content);
    setScale(scale);
  }

  @Override
  void aspect() {
    
    noStroke();
    text(content, 0, 0);
  }

  String content() {
    return content;
  }

  void setcontent(String c) {
    content = c;
  }

  void setcontent(int c) {
    content = new String();
    // see: https://discourse.processing.org/t/get-random-letters-and-put-into-a-string/28585/10
    for (int i = 0; i < c; i++) {
      content += char (int(random (65, 65+24)));
    }
  }
}
