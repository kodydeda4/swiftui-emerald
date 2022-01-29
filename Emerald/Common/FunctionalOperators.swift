import Foundation

precedencegroup ForwardApplication {
  associativity: left
}
infix operator |>: ForwardApplication
public func |> <A, B>(x: A, f: (A) -> B) -> B {
  return f(x)
}

precedencegroup ForwardComposition {
  associativity: left
  higherThan: ForwardApplication
}
infix operator >>>: ForwardComposition
public func >>> <A, B, C>(
  f: @escaping (A) -> B,
  g: @escaping (B) -> C
  ) -> ((A) -> C) {

  return { g(f($0)) }
}
