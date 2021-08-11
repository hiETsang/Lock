//: [Previous](@previous)

import Foundation

//NSRecursiveLock是Foundation框架提供的递归锁。作用是，一个锁可以由同一线程多次获取而不会导致死锁，和synchronized(objc_sync)一样，底层也是对pthread_mutex recursive的封装。

/////加锁
//func lock()
/////解锁
//func unlock()
/////尝试加锁，返回是否成功，不阻塞
//open func `try`() -> Bool
/////在指定时间内一直尝试加锁，返回是否成功
//open func lock(before limit: Date) -> Bool

print("start")
let recursiveLock = NSRecursiveLock()
DispatchQueue.global(qos: .default).async {
    recursiveLock.lock()
    sleep(3)
    //重复获取锁
    recursiveLock.lock()
    print("1:"+Thread.current.description);
    recursiveLock.unlock()
    sleep(3)
    print("2:"+Thread.current.description);
    recursiveLock.unlock()
}
DispatchQueue.global(qos: .default).async {
    recursiveLock.lock()
    sleep(3)
    print("3:"+Thread.current.description);
    recursiveLock.unlock()
}
print("end")


//: [Next](@next)
