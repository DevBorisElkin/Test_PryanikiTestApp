//
//  Relay.swift
//  PryanikiTestApp
//
//  Created by Boris on 25.08.2022.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UITableView {
    var delegate: UITableViewDelegateProxy {
        return UITableViewDelegateProxy.proxy(for: base)
    }

    var heightForRowAt: Binder<[IndexPath: CGFloat]> {
        Binder(delegate) { del, value in
            del.heightForRowAtRelay.accept(value)
        }
    }
}

class UITableViewDelegateProxy
: DelegateProxy<UITableView, UITableViewDelegate>
, DelegateProxyType
, UITableViewDelegate {
    static func currentDelegate(for object: UITableView) -> UITableViewDelegate? {
        object.delegate
    }

    static func setCurrentDelegate(_ delegate: UITableViewDelegate?, to object: UITableView) {
        object.delegate = delegate
    }

    public static func registerKnownImplementations() {
        self.register { UITableViewDelegateProxy(parentObject: $0) }
    }

    init(parentObject: UITableView) {
        super.init(
            parentObject: parentObject,
            delegateProxy: UITableViewDelegateProxy.self
        )
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        heightForRowAtRelay.value[indexPath] ?? 44
    }

    fileprivate let heightForRowAtRelay = BehaviorRelay<[IndexPath: CGFloat]>(value: [:])
}
