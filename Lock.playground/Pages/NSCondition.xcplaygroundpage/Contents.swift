//: [Previous](@previous)

import Foundation

//NSCondition是Foundation框架提供的条件变量，也是一种互斥锁，底层是对POSIX的pthread_cond条件变量和pthread_mutex互斥量的封装。
//pthread_mutex保证了访问pthread_cond和lock()操作的线程安全。pthread_cond通过信号量的方式，通知其他线程恢复或者挂起当前线程。

/////加锁
//func lock()
/////解锁
//func unlock()
/////挂起当前线程，直到收到signal
//open func wait()
/////在指定时间内，挂起当前线程，直到收到signal
//open func wait(until limit: Date) -> Bool
/////发送条件信号，唤醒一个（优先级最高或者等待时间最长的）等待线程
//open func signal()
/////广播条件信号，唤醒所有等待线程
//open func broadcast()

var i = 0

print("start")
let condition = NSCondition()
DispatchQueue.global(qos: .default).async {
    condition.lock()
    while(i == 0) {
        condition.wait()
    }
    print("1:"+Thread.current.description,Date());
    condition.unlock()
}
DispatchQueue.global(qos: .default).async {
    condition.lock()
    while(i == 0) {
        condition.wait()
    }
    print("2:"+Thread.current.description,Date());
    condition.unlock()
}
DispatchQueue.global(qos: .default).async {
    condition.lock()
    sleep(3)
    i += 1
    // 释放一个
//    condition.signal()
    // 全部释放
    condition.broadcast()
    print("3:"+Thread.current.description,Date());
    condition.unlock()
}
print("end")


//: [Next](@next)
