// Generated using Sourcery 1.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import Foundation
@testable import BoardGameList
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
import AVKit
#elseif os(OSX)
import AppKit
#endif

private func objectDidNotCallAnyMethod(_ object: Any) -> Bool {
  let mirror = Mirror(reflecting: object)
  for case let (label?, value) in mirror.children where label.hasSuffix("CallsCount") {
    if let count = value as? Int, count > 0 {
      return false
    }
  }
  return true
}

private func objectDidNotCallAnyMethod(_ object: Any, except methodName: String) -> Bool {
  let mirror = Mirror(reflecting: object)
  for case let (label?, value) in mirror.children where label.hasSuffix("CallsCount") {
    let methodCallsCountName = methodName + "CallsCount"
    if let count = value as? Int, (label == methodCallsCountName && count == 0) || (label != methodCallsCountName && count > 0) { return false }
  }
  return true
}













class APIAdapterMock: APIAdapter {
    var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)

    var noMethodCalled: Bool {
        return objectDidNotCallAnyMethod(self)
    }

    //MARK: - get

    var getUrlCompletionCallsCount = 0
    var getUrlCompletionCalled: Bool {
        return getUrlCompletionCallsCount > 0
    }
    var getUrlCompletionReceivedArguments: (url: URL, completion: (Result<Data, APIError>) -> Void)?
    var getUrlCompletionReceivedInvocations: [(url: URL, completion: (Result<Data, APIError>) -> Void)] = []
        var getUrlCompletionCalledOnly: Bool {
        return objectDidNotCallAnyMethod(self, except: "getUrlCompletion")
    }
    var getUrlCompletionCalledOnlyAndOnce: Bool {
        return getUrlCompletionCalledOnly && getUrlCompletionCallsCount == 1
    }

    var getUrlCompletionClosure: ((URL, @escaping (Result<Data, APIError>) -> Void) -> Void)?

    func get(url: URL, completion: @escaping (Result<Data, APIError>) -> Void) {
        getUrlCompletionCallsCount += 1
        getUrlCompletionReceivedArguments = (url: url, completion: completion)
        self.queue.sync {
        getUrlCompletionReceivedInvocations.append((url: url, completion: completion))
        }
        getUrlCompletionClosure?(url, completion)
    }

}

// swiftlint:enable all