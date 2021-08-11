//: [Previous](@previous)

import Foundation

// 自旋锁/忙等锁，iOS10之后替换OSSpinLock,OSSpinLock因为有优先级反转导致的性能问题

////加锁，阻塞
//os_unfair_lock_lock()
////尝试加锁，不阻塞，成功返回false
//os_unfair_lock_trylock()
////解锁
//os_unfair_lock_unlock()

print("start")
let unfairlock = os_unfair_lock_t.allocate(capacity: 1)
unfairlock.initialize(to: os_unfair_lock())
for i in 1...2 {
    DispatchQueue.global(qos: .default).async {
        os_unfair_lock_lock(unfairlock)
        sleep(2)
        print("\(i):"+Thread.current.description,Date());
        os_unfair_lock_unlock(unfairlock)
    }
}
//trylock
DispatchQueue.global(qos: .default).async {
    if (os_unfair_lock_trylock(unfairlock)) {
        sleep(2)
        print("3:"+Thread.current.description,Date());
        os_unfair_lock_unlock(unfairlock)
    }
}
print("end")

//: [Next](@next)
