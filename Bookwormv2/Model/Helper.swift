//
//  Helper.swift
//  Bookwormv2
//
//  Created by Anthony Gibson on 23/12/2022.
//

import Foundation
import SwiftUI

struct Helper {
   
   static var genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
   
}

func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
   Binding(
      get: { lhs.wrappedValue ?? rhs },
      set: { lhs.wrappedValue = $0 }
   )
}

