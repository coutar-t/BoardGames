//
//  AdapterInjector.swift
//  BoardGameList
//
//  Created by Thibaut Coutard on 31/01/2022.
//

import Foundation
import Swinject

protocol AdapterInjector {
    func getAdapter<T>(type: T.Type) -> T
    func getAdapter<T>(type: T.Type, name: String) -> T
    func getAdapter<T, Arg1, Arg2>(_ serviceType: T.Type, arguments arg1: Arg1, _ arg2: Arg2) -> T
}

class AdapterAppInjector: AdapterInjector {
    private let container: Container

    init() {
        container = Container()
        container.register(ImageFetcher.self) { _ in
            SimpleImageFetcher()
        }
    }

    func getAdapter<T>(type: T.Type) -> T {
        return container.synchronize().resolve(type)!
    }

    func getAdapter<T>(type: T.Type, name: String) -> T {
        return container.synchronize().resolve(type, name: name)!
    }

    func getAdapter<T, Arg1, Arg2>(_ serviceType: T.Type, arguments arg1: Arg1, _ arg2: Arg2) -> T {
        return container.synchronize().resolve(serviceType, arguments: arg1, arg2)!
    }
}

#if DEBUG

class AdapterMockInjector: AdapterAppInjector {
    private let container: Container

    static var `default`: AdapterMockInjector {
        let mock = AdapterMockInjector()
        mock.saveAdapter(adapter: ImageFetcherMock(image: UIImage(named: "ExampleImage")))
        return mock
    }

    override init() {
        container = Container()
    }

    func saveAdapter<T>(adapter: T) {
        container.register(T.self) { _ in
            return adapter
        }
    }

    override func getAdapter<T>(type: T.Type) -> T {
        return container.synchronize().resolve(type)!
    }

    override func getAdapter<T>(type: T.Type, name: String) -> T {
        return container.synchronize().resolve(type, name: name)!
    }

    override func getAdapter<T, Arg1, Arg2>(_ serviceType: T.Type, arguments arg1: Arg1, _ arg2: Arg2) -> T {
        return container.synchronize().resolve(serviceType, arguments: arg1, arg2)!
    }
}

#endif
