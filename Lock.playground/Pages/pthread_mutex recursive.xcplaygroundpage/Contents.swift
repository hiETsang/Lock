//: [Previous](@previous)

import Foundation

// 递归锁
print("start")
var mutex = pthread_mutex_t()
var attr = pthread_mutexattr_t()
pthread_mutexattr_init(&attr)
pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE)
pthread_mutex_init(&(mutex), &attr)
for i in 1...2 {
    DispatchQueue.global(qos: .default).async {
        pthread_mutex_lock(&(mutex))
        sleep(2)
        print("\(i):"+Thread.current.description,Date());
            pthread_mutex_lock(&(mutex))
            sleep(2)
            print("sub \(i):"+Thread.current.description,Date());
            pthread_mutex_unlock(&(mutex))
        pthread_mutex_unlock(&(mutex))
    }
}
print("end")

//: [Next](@next)
