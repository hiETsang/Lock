//: [Previous](@previous)

import Foundation

//NSLock是Foundation框架提供的互斥锁，底层使用了POSIX的pthread_mutex互斥锁。

/////加锁
//func lock()
/////解锁
//func unlock()
/////尝试加锁，返回是否成功，不阻塞
//open func `try`() -> Bool
/////在指定时间内一直尝试加锁，返回是否成功
//open func lock(before limit: Date) -> Bool

print("start")
let lock = NSLock()
for i in 1...5 {
    DispatchQueue.global(qos: .default).async {
        lock.lock(before: Date().advanced(by: 100))
        sleep(5)
        print("\(i):"+Thread.current.description,Date());
        lock.unlock()
    }
}
print("end")

//: [Next](@next)
