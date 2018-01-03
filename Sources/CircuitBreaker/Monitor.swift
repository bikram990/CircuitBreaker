/**
 * Copyright IBM Corporation 2017, 2018
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/

import Foundation

/// Protocol identifying a stats monitor
public protocol StatsMonitor {

  /// References to monitored CircuitBreaker instances
  var refs: [Weak] { get set }

  /// Method to register a stats provider
  ///
  /// - Parameters:
  ///   - breakerRef: The StatsProvider to monitor
  func register(breakerRef: StatsProvider)

}

public extension StatsMonitor {

  // Default register method to add weak reference to pointer array
  public mutating func register(breakerRef: StatsProvider) {
    self.refs.append(Weak(value: breakerRef))
  }
}
/// Protocol identifying a stats provider
public protocol StatsProvider: class {

  /// Registers a monitor for a breaker reference
  static func addMonitor(monitor: StatsMonitor)

  /// Histrix compliant instance
  var snapshot: Snapshot { get }
}

/// Wrapper for a weak reference
public class Weak {

  /// The weak circuit breaker instance
  public weak var value: StatsProvider?

  /// Initializer
  ///
  /// - Parameters:
  ///   - value: StatsProvider
  public init (value: StatsProvider) {
    self.value = value
  }
}
