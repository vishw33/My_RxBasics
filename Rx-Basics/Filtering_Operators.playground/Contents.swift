//: Playground - noun: a place where people can play

import UIKit
import RxSwift

example(of: "ignoreElements") {

// 1
let strikes = PublishSubject<String>()

let disposeBag = DisposeBag()

// 2
strikes
    .ignoreElements()
    .subscribe { _ in
        print("You're out!")
    }
    .disposed(by: disposeBag)
    
    strikes.subscribe(onNext: { (element) in
        print(element)
        print("NE")
    }, onError: { (_) in
        print("Error")
    }, onCompleted: {
        print("compleated")
    })
        .disposed(by: disposeBag)
    
    strikes.onNext("Vishwas")
    strikes.onCompleted()
}

example(of: "elementAt") {

// 1
let strikes = PublishSubject<String>()

let disposeBag = DisposeBag()

//  2
strikes
    .elementAt(2)
    .subscribe(onNext: { ele in
        print(ele)
        print("You're out!")
    }, onCompleted:{print("completed")})
    .disposed(by: disposeBag)
    
    strikes.onNext("Vishwas")
    strikes.onNext("Vishwas")
    strikes.onNext("Vishwas")
        strikes.onNext("Vishwas")
        strikes.onNext("Vishwas")
        strikes.onNext("Vishwas")
    strikes.onCompleted()
}

example(of: "filter") {

let disposeBag = DisposeBag()

// 1
Observable.of(1, 2, 3, 4, 5, 6)
    // 2
    .filter { integer in
        integer % 2 == 0
    }
    // 3
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
    
    let strike = PublishSubject<Int>()
    strike.filter({ (int) -> Bool in
        int % 2 == 0
    }).subscribe(onNext: {
        print($0)
    })
        .disposed(by: disposeBag)
    strike.onNext(1)
    strike.onNext(10)
}

example(of: "skip") {

let disposeBag = DisposeBag()

// 1
Observable.of("A", "B", "C", "D", "E", "F")
    // 2
    .skip(3)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
    
     let strike = PublishSubject<[Int]>()
    strike.skip(3)
    
   Observable.from([  1,2,3,4])
    .skip(2)
    .subscribe(onNext: { (int) in
        print(int)
    }, onCompleted: {
        print("Completed")
    })
   // strike.onNext([1,2,3])
}

example(of: "skipWhile") {

//:  #Only first Element is Skipped if it satisfy the condition
let disposeBag = DisposeBag()

// 1
Observable.of(2, 2, 3, 4, 4, 8, 12)
    // 2
    .skipWhile { integer in
        integer % 2 == 0
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
    
    let subject = Variable([])
    subject.value.append([1,2,3,4,5])
    
}

example(of: "skipUntil") {

let disposeBag = DisposeBag()

// Subject will not notify unless trigger gets onnext event , and all subject before trigger on next will be lost
    
// 1
let subject = PublishSubject<String>()
let trigger = PublishSubject<String>()

// 2
subject
    .skipUntil(trigger)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
    
    subject.onNext("Vishwas")
    subject.onNext("N.G")
    
    trigger.onNext("Triggred")
    
    subject.onNext("SubEvent")
}

example(of: "take") {

let disposeBag = DisposeBag()

    
    //: Will notify the number of events take subscribed to
// 1
Observable.of(1, 2, 3, 4, 5, 6)
    // 2
    .take(3)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
    
    var arr = [11,12,13,14,15,16,17]
    let sub = Observable.from(arr)
    sub.take(10)
    sub.subscribe(onNext:{print($0)})
    
    arr.append(1)
    
     sub.subscribe(onNext:{print($0)})
    
}
