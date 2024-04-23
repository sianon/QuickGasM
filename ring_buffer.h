//
// Created by cao on 24-4-17.
//

#ifndef QUICK_DEMO_RING_BUFFER_H
#define QUICK_DEMO_RING_BUFFER_H

#include <atomic>
#include <iostream>
#include "common.h"

#define LOCK_FREE_Q_DEFAULT_SIZE 25
#define QUEUE_INT unsigned int

template<typename ELEM_T, QUEUE_INT Q_SIZE = LOCK_FREE_Q_DEFAULT_SIZE>
class RingBuffer{
public:
    RingBuffer()
    :write_index_(0)
    ,read_index_(0)
    ,maximum_readindex_(0)
    ,count_(0){

    }
    virtual ~RingBuffer(){

    }

    QUEUE_INT size(){
        return count_;
    }
    bool enqueue(const ELEM_T& a_data);
    bool dequeue(ELEM_T& a_data);
//    bool try_dequeue(ELEM_T& a_data);

private:
    ELEM_T thequeue_[Q_SIZE];
    volatile std::atomic<int> count_;
    volatile QUEUE_INT write_index_;
    volatile QUEUE_INT read_index_;
    volatile QUEUE_INT maximum_readindex_;

    inline QUEUE_INT countToIndex(QUEUE_INT count){
        return count % LOCK_FREE_Q_DEFAULT_SIZE;
    }
};

template<typename ELEM_T, unsigned int Q_SIZE>
bool RingBuffer<ELEM_T, Q_SIZE>::enqueue(const ELEM_T& a_data){
    QUEUE_INT current_write_index;
    QUEUE_INT current_read_index;
    do{
        current_write_index = write_index_;
        current_read_index = read_index_;
        if(countToIndex(current_write_index + 1) == countToIndex(current_read_index)){
            std::cout << "RingBuffer is full:" << size() << std::endl;
            return false;
        }
    }while(!CAS(&write_index_, current_write_index, (current_write_index + 1)));

    thequeue_[countToIndex(current_write_index)] = a_data;
    while(!CAS(&maximum_readindex_, current_write_index, (current_write_index + 1))){
        sched_yield();
    }
    count_++;
//    std::cout << "En----RingBuffer size:" << size() << "count:" << count_ << std::endl;
    return true;
}

template<typename ELEM_T, QUEUE_INT Q_SIZE>
bool RingBuffer<ELEM_T, Q_SIZE>::dequeue(ELEM_T& a_data){
    QUEUE_INT current_maximum_readindex;
    QUEUE_INT current_read_index;
    do{
        current_read_index = read_index_;
        current_maximum_readindex = maximum_readindex_;

        if(countToIndex(current_read_index) == countToIndex(current_maximum_readindex)){
            return false;
        }

        a_data = thequeue_[countToIndex(current_read_index)];

//        std::cout << "Deq----RingBuffer size:" << size() << "count:" << count_ << std::endl;
        if(CAS(&read_index_, current_read_index, (current_read_index + 1))){
            count_--;
            return true;
        }
    }while(true);

    return false;

}

#endif //QUICK_DEMO_RING_BUFFER_H
