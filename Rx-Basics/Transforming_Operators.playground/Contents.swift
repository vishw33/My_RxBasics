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

example(of: "enumerated and map") {

let disposeBag = DisposeBag()
    //: here each obserber is enumurated and mapped if given condition is satisfied
// 1
Observable.of(1, 2, 3, 4, 5, 6)
    // 2
    .enumerated()
    // 3
    .map { index, integer in
        index > 2 ? integer * 2 : integer
    }
    // 4
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
    
}

struct Student {
    
    var score: BehaviorSubject<Int>
}

example(of: "flatMap") {

let disposeBag = DisposeBag()

// 1
let ryan = Student(score: BehaviorSubject(value: 80))
let charlotte = Student(score: BehaviorSubject(value: 90))

// 2
let student = PublishSubject<Student>()

// 3
student
    .flatMap {
        $0.score
    }
    // 4
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
    
    student.onNext(ryan)
    
    ryan.score.onNext(85)
    
    student.onNext(charlotte)
    
    charlotte.score.onNext(85)

}
