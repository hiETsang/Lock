import UIKit

////互斥锁属性，支持递归
//pthread_mutexattr_init(&attr) 可选，初始化互斥锁属性
//pthread_mutexattr_settype(&attr) 可选，设置互斥锁属性类型，PTHREAD_MUTEX_RECURSIVE:递归
////互斥锁
//pthread_mutex_init(&mutex,&attr) 初始化互斥锁
//pthread_mutex_lock(&mutex) 加锁，阻塞
//pthread_mutex_trylock(&mutex) 尝试加锁，不阻塞，成功返回0
//pthread_mutex_unlock(&mutex) 解锁
//pthread_mutex_destroy(&mutex) 销毁锁

// 互斥锁
print("pthread_mutex start")
var mutex = pthread_mutex_t()
pthread_mutex_init(&(mutex), nil)

//trylock  如果放到 for 循环下方，那么尝试加锁会失败
DispatchQueue.global(qos: .default).async {
    let retCode = pthread_mutex_trylock(&(mutex))
    // 尝试加锁成功 返回0
    if(retCode == 0) {
        sleep(2)
        print("3:"+Thread.current.description,Date())
        pthread_mutex_unlock(&(mutex))
    }
    print("3-1:"+Thread.current.description,Date())
}
for i in 1...2 {
    DispatchQueue.global(qos: .default).async {
        pthread_mutex_lock(&(mutex))
        sleep(2)
        print("\(i):"+Thread.current.description,Date())
        pthread_mutex_unlock(&(mutex))
    }
}

print("pthread_mutex end")
