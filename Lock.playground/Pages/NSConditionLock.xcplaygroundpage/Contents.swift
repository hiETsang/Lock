//: [Previous](@previous)

import Foundation

//NSConditionLock是Foundation框架提供的条件锁，可以确保线程仅在满足特定条件时才能获取锁。
//NSConditionLock其实是对NSCondition条件变量的封装，内置了Int类型的cond条件。相比来说还是NSCondition可定制自由度高一点。

/////加锁
//func lock()
/////解锁
//func unlock()
/////获取锁，条件变量等于指定的值，才能获取锁，一直等待
//open func lock(whenCondition condition: Int)
/////尝试加锁，返回是否成功，不阻塞
//open func `try`() -> Bool
/////如果条件变量等于某个值，尝试加锁，返回是否成功
//open func tryLock(whenCondition condition: Int) -> Bool
/////解锁，并设置条件变量的值
//open func unlock(withCondition condition: Int)
/////在指定时间内一直尝试加锁，返回是否成功
//open func lock(before limit: Date) -> Bool
/////尝试在指定的时间之前获取锁，此方法将阻止线程的执行，直到可以获取锁或达到限制为止。
//open func lock(whenCondition condition: Int, before limit: Date) -> Bool

print("start")
//初始化锁，设置 cond = 3
let conditionLock = NSConditionLock(condition: 3)
DispatchQueue.global(qos: .default).async {
    //获取锁，等待 cond == 1
    conditionLock.lock(whenCondition: 1)
    print("1:"+Thread.current.description,Date());
    conditionLock.unlock(withCondition: 2)
}
DispatchQueue.global(qos: .default).async {
    //获取锁，等待 cond == 4，最多等待10秒
    conditionLock.lock(whenCondition: 4, before: Date().advanced(by: 10))
    print("2:"+Thread.current.description,Date());
    conditionLock.unlock(withCondition: 2)
}
DispatchQueue.global(qos: .default).async {
    //获取锁，等待 cond == 3
    conditionLock.lock(whenCondition:3)
    sleep(5)
    print("3:"+Thread.current.description,Date());
    conditionLock.unlock(withCondition: 1)
}
print("end")

//: [Next](@next)
