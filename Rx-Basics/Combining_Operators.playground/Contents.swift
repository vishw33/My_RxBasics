//: Playground - noun: a place where people can play

import UIKit
import RxSwift

example(of: "startWith") {
    // 1
    let numbers = Observable.of(2, 3, 4)
    
    // 2
    let observable = numbers.startWith(1)
    observable.subscribe(onNext: { value in
        print(value)
    })
}
