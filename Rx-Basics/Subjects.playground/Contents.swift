//: Playground - noun: a place where people can play

import UIKit
import RxSwift

example(of: "PublishSubject")
{
    let subject = PublishSubject<String>()
    
    subject.onNext("First Event")
//: Ignore all events before subscribe and after subscription only feature event is notified and all previous events are not tracket/notified
    let subscriptionOne = subject
        .subscribe(onNext: { string in
            print(string)
        })
    
     subject.onNext("Listeninng")
    
    let subscriptionTwo = subject
        .subscribe { event in
            print("2)", event.element ?? event)
    }
   
    subject.on(.next("1"))
    
    subject.on(.next("3"))
    subject.onNext("vishwas")
    
    subscriptionOne.dispose()
    subject.onNext("vishwas1")
    
    subject.onCompleted()
    
    // 2
    subject.onNext("5")
    
    // 3
    subscriptionTwo.dispose()
    
}

enum MyError: Error {
    case anError
}

// 2
func print<T: CustomStringConvertible>(label: String, event: Event<T>) {
    print(label, event.element ?? event.error ?? event)
}
example(of: "BehaviorSubject") {

//: Ignore all events before subscribe but for last one and after subscription only feature event is notified
    
// 4
let subject = BehaviorSubject(value: "Initial value")
    subject.onNext("vis")
  

let disposeBag = DisposeBag()
    
subject
        .subscribe {
        print(label: "1)", event: $0)
        }
        .disposed(by: disposeBag)
    
    subject.on(.next("bghs"))
    subject.on(.next("bgh"))
    
    // 2
    subject
        .subscribe {
        print(label: "2)", event: $0)
        }
        .disposed(by: disposeBag)
}

example(of: "ReplaySubject") {

    
    //: ReplaySubject is a combination of both Publish and behaviour subject where reply buffer will set by user ie user will decide how many previous events thats need to be notified when subscribed
// 1
let subject = ReplaySubject<String>.create(bufferSize: 2)

let disposeBag = DisposeBag()

// 2
subject.onNext("1")

subject.onNext("2")

subject.onNext("3")

    subject
    .subscribe
        {
    print(label: "1)", event: $0)
    }
    .disposed(by: disposeBag)
    
    subject.onNext("4")
    subject.onNext("5")
        subject.onNext("6")
    
    subject
    .subscribe {
    print(label: "2)", event: $0)
    }
    .disposed(by: disposeBag)
}

example(of: "Variable") {

    
    //: Like in any other languague variable is just a placeholder for value and will notify when there is change of value inside variable
// 1
let variable = Variable("Initial value")

let disposeBag = DisposeBag()

// 2
variable.value = "New initial value"

// 3
variable.asObservable()
    .subscribe {
        print(label: "1)", event: $0)
    }
    .disposed(by: disposeBag)
    
    variable.value = "1"
    
    // 2
    variable.asObservable()
        .subscribe {
            print(label: "2)", event: $0)
        }
        .disposed(by: disposeBag)
    
    // 3
    variable.value = "2"
    
    variable.value = "5"
}

example(of: "Variable_myOwn")
{
    // 1
    let variable = Variable<[Int]>([])
    
    let disposeBag = DisposeBag()
    
    variable.value.append(1)
    
    variable.asObservable()
        .subscribe(onNext: { (value) in
            print(value.count)
        }, onError: { (err) in
            
        }, onCompleted: {
            print("compleated")
        }, onDisposed: {
            print("Disposed")
        }).disposed(by: disposeBag)
    
    variable.value = [1,2,4]
}

