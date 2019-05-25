//
//  Disposable.swift
//  Stories
//
//  Created by Чистяков Вадим Евгеньевич on 25/05/2019.
//  Copyright © 2019 ChistProduction. All rights reserved.
//


typealias Disposal = [Disposable]

final class Disposable {

    private let dispose: () -> Void

    init(_ dispose: @escaping () -> Void) {
        self.dispose = dispose
    }

    deinit {
        dispose()
    }

    func add(to disposal: inout Disposal) {
        disposal.append(self)
    }
}
