//
//  Observable.swift
//  Stories
//
//  Created by Чистяков Вадим Евгеньевич on 25/05/2019.
//  Copyright © 2019 ChistProduction. All rights reserved.
//


final class Observable<T> {

    typealias Observer = (T) -> Void

    private var observers: [Int: Observer] = [:]
    private var uniqueID = (0...).makeIterator()

    var value: T {
        didSet {
            observers.values.forEach { $0(value) }
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func observe(_ observer: @escaping Observer) -> Disposable {
        guard let id = uniqueID.next() else { fatalError("There should always be a next unique id") }

        observers[id] = observer
        observer(value)

        let disposable = Disposable { [weak self] in
            self?.observers[id] = nil
        }

        return disposable
    }

    func removeAllObservers() {
        observers.removeAll()
    }

}
