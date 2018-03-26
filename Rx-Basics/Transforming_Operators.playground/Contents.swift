//: Playground - noun: a place where people can play

import RxSwift

example(of: "toArray") {
    
    //: toArray will convert the individual value to array value
    let disposeBag = DisposeBag()
    
    // 1
    Observable.of("A", "B", "C","D")
        // 2
        .toArray()
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
    
    
    let subject = PublishSubject<String>()
    subject.toArray()
    
    subject.subscribe(onNext: {
        print($0)
    }, onCompleted: {
        print("Completed")
    })
    .disposed(by: disposeBag)
    
    subject.onNext("V")
    subject.onNext("I")
    subject.onNext("S")
    subject.onNext("H")
    subject.onNext("U")
    subject.onCompleted()
    
}
