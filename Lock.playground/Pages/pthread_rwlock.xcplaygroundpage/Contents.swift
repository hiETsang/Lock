//: [Previous](@previous)

import Foundation

/////销毁
//public func pthread_rwlock_destroy(_: UnsafeMutablePointer<pthread_rwlock_t>) -> Int32
/////初始化
//public func pthread_rwlock_init(_: UnsafeMutablePointer<pthread_rwlock_t>
//, _: UnsafePointer<pthread_rwlockattr_t>?) -> Int32
/////获取读锁
//public func pthread_rwlock_rdlock(_: UnsafeMutablePointer<pthread_rwlock_t>) -> Int32
/////尝试获取读锁
//public func pthread_rwlock_tryrdlock(_: UnsafeMutablePointer<pthread_rwlock_t>) -> Int32
/////尝试获取写锁
//public func pthread_rwlock_trywrlock(_: UnsafeMutablePointer<pthread_rwlock_t>) -> Int32
/////获取写锁
//public func pthread_rwlock_wrlock(_: UnsafeMutablePointer<pthread_rwlock_t>) -> Int32
/////解锁
//public func pthread_rwlock_unlock(_: UnsafeMutablePointer<pthread_rwlock_t>) -> Int32

// 多读一写，可以同时读，但是不能同时读写

print("start")
var rwlock = pthread_rwlock_t()
//初始化读写锁
pthread_rwlock_init(&(rwlock), nil)
DispatchQueue.global(qos: .default).async {
    //读
    pthread_rwlock_rdlock(&(rwlock))
    sleep(3)
    print("read1:"+Thread.current.description,Date())
    pthread_rwlock_unlock(&(rwlock))
}
DispatchQueue.global(qos: .default).async {
    //读
    pthread_rwlock_rdlock(&(rwlock))
    sleep(3)
    print("read2:"+Thread.current.description,Date())
    pthread_rwlock_unlock(&(rwlock))
}
DispatchQueue.global(qos: .default).async {
    //写
    pthread_rwlock_wrlock(&(rwlock))
    sleep(3)
    print("write1:"+Thread.current.description,Date())
    pthread_rwlock_unlock(&(rwlock))
}
DispatchQueue.global(qos: .default).async {
    //写
    pthread_rwlock_wrlock(&(rwlock))
    sleep(3)
    print("write2:"+Thread.current.description,Date())
    pthread_rwlock_unlock(&(rwlock))
}
DispatchQueue.global(qos: .default).async {
    //读
    pthread_rwlock_rdlock(&(rwlock))
    sleep(3)
    print("read3:"+Thread.current.description,Date())
    pthread_rwlock_unlock(&(rwlock))
}
print("end")

//: [Next](@next)
