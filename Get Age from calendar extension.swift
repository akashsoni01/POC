extension Date { 
  var age: Int {
  return Calendar.current.dateComponents([.year], from: self, to: Date()).year! }
}
