import Foundation

class Dependencies {
  
  static let shared = Dependencies()
  
  private var values = [String: AnyObject]()
  
  func add(name: String?, value: AnyObject) {
    let name = name ?? String(describing: value)
    self.values[name] = value
  }
  
  func resolve<T>(name: String?) -> T {
    let name = name ?? String(describing: T.self)
    guard let value = self.values[name] as? T else {
      fatalError("Could not solve \(name) with type \(T.self)")
    }
    
    return value
  }
}

@propertyWrapper
class Inject<Value> {
  private let name: String?
  
  init(_ name: String?) {
    self.name = name
  }
  
  public var wrappedValue: Value {
    return Dependencies.shared.resolve(name: self.name)
  }
}
