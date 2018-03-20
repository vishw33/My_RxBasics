//: Please build the scheme 'RxSwiftPlayground' first
import RxSwift


example(of: "just, of, from") {
    
    // 1
    let one = 1
    let two = 2
    let three = 3
    
    // 2
    let observable: Observable<Int> = Observable<Int>.just(one)
    print(observable)
    
    let observable2:Observable = Observable.of(one,two,three)
    let observeArray = Observable.of([one,two,three])
    let observeArrayIndividual = Observable.from([one,two,three])
    
    let bag = DisposeBag()
    observable2.subscribe{event in print(event)}.disposed(by: bag)
    observeArray.subscribe{event in print(event)}
    observeArrayIndividual.subscribe{event in print(event)}
    
    
    //: #Subscribing to observables
    let keyBoardNotification = NotificationCenter.default.addObserver(forName: .UIKeyboardDidChangeFrame, object: nil, queue: nil) { (notification) in
        if (notification.name == .UIKeyboardDidChangeFrame)
        {
            print("KeyBoard")
        }
    }
    print(keyBoardNotification)
    
    let sequence = 1..<10
    print(sequence)
    sequence.map{print($0)}
    
    let iterator = sequence.makeIterator()
    print(iterator)
    
}

example(of: "subscribe") {
    
    let one = 1
    let two = 2
    let three = 3
    
    let observable = Observable.of(one, two, three)
    
    observable.subscribe({ (event) in
        
        if let element = event.element {
            print(element)
        }
    })
    
    observable.subscribe(onNext: { element in
        print(element)
    })
    
}

example(of: "empty")
{
    let observable = Observable<Void>.empty()
    
    observable.subscribe
    ( onNext:{event in print(event) },
      onCompleted:{print("observed") }
    )
}

example(of: "range") {
    
    // 1
    let observable = Observable<Int>.range(start: 1, count: 10)
    
    observable
        .subscribe(onNext: { i in
            
            // 2
            let n = Double(i)
            let fibonacci = Int(((pow(1.61803, n) - pow(0.61803, n)) / 2.23606).rounded())
            print(fibonacci)
        })
}

example(of: "dispose") {
    
    // 1
    let observable = Observable.of("A", "B", "C")
    
    // 2
    let subscription = observable.subscribe { event in
        
        // 3
        print(event)
    }
    
    subscription.dispose()
}

example(of: "DisposeBag") {
    
    // 1
    let disposeBag = DisposeBag()
    
    // 2
    Observable.of("A", "B", "C")
        .subscribe { // 3
            print($0)
        }
        .disposed(by: disposeBag) // 4
}

example(of: "create") {
    
    let disposeBag = DisposeBag()
    
    Observable<String>.create { observer in
        
        observer.onNext("1")
        print(observer.onNext("1"))
        
        // 2
        observer.onCompleted()
        
        // 3
        observer.onNext("?")
        
        // 4
        return Disposables.create()
        
        }
        
        .subscribe(
            onNext: { print($0) },
            onError: { print($0) },
            onCompleted: { print("Completed") },
            onDisposed: { print("Disposed") }
        )
        .disposed(by: disposeBag)
    
    enum MyError: Error {
        case anError
    }
}

example(of: "deferred") {
    
    let disposeBag = DisposeBag()
    
    // 1
    var flip = false
    
    // 2
    let factory: Observable<Int> = Observable.deferred {
        
        // 3
        flip = !flip
        
        // 4
        if flip {
            return Observable.of(1, 2, 3)
        } else {
            return Observable.of(4, 5, 6)
        }
    }
    for _ in 0...3 {
        factory.subscribe(onNext: {
            print($0, terminator: "")
        })
            .disposed(by: disposeBag)
        
        print()
    }
}

example(of: "Single") {
    
    // 1
    let disposeBag = DisposeBag()
    
    // 2
    enum FileReadError: Error {
        case fileNotFound, unreadable, encodingFailed
    }
    
    // 3
    func loadText(from name: String) -> Single<String> {
        // 4
        return Single.create { single in
            
            // 1
            let disposable = Disposables.create()
            
            // 2
            guard let path = Bundle.main.path(forResource: name, ofType: "txt") else {
                single(.error(FileReadError.fileNotFound))
                return disposable
            }
            
            // 3
            guard let data = FileManager.default.contents(atPath: path) else {
                single(.error(FileReadError.unreadable))
                return disposable
            }
            
            // 4
            guard let contents = String(data: data, encoding: .utf8) else {
                single(.error(FileReadError.encodingFailed))
                return disposable
            }
            
            // 5
            single(.success(contents))
            return disposable
            
        }
    }
    
    // 1
    loadText(from: "Copyright")
        // 2
        .subscribe {
            // 3
            switch $0 {
            case .success(let string):
                print(string)
            case .error(let error):
                print(error)
            }
        }
        .disposed(by: disposeBag)
}
