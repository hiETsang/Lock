//: [Previous](@previous)

import Foundation

//DispatchSemaphore信号量是持有计数的信号，通过计数来控制多线程对资源的访问。
//关于信号量有个很容易理解的例子。信号量类似停车场空位，车辆出去发送signal，空位+1，车辆进入发送wait，空位-1，当空位<=0，车辆不能进入，wait会阻塞。

/////发送信号，信号量+1
//public func signal() -> Int
/////等待信号，信号量-1
//public func wait()
/////等待信号，设置最晚等待时间
//public func wait(timeout: DispatchTime) -> DispatchTimeoutResult
//public func wait(wallTimeout: DispatchWallTime) -> DispatchTimeoutResult

//swift
print("start")
//初始化，初始信号2，同时允许两个thread访问
let semaphore = DispatchSemaphore(value: 2)
for i in 1...4 {
    DispatchQueue.global(qos: .default).async {
        //等待信号
        semaphore.wait()
        sleep(2)
        print("\(i):"+Thread.current.description,Date());
        //释放信号
        semaphore.signal()
    }
}
print("end")

//: [Next](@next)
