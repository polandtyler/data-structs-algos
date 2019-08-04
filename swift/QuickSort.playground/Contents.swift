import UIKit

// In swift, the '&' is used to represent a mutating value
// and since we are doing an in-place mutation/swap/whatever, it is necessary to use
// the '&' operator
func quickSortHoare<T:Comparable>(arr: inout [T], startIndex: Int, endIndex: Int) -> [T] {
    if startIndex < endIndex {
        let pivotValue: Int = partitionHoare(array: &arr, startIndex: startIndex, endIndex: endIndex)
        
        quickSortHoare(arr: &arr, startIndex: startIndex, endIndex: pivotValue)
        quickSortHoare(arr: &arr, startIndex: pivotValue + 1, endIndex: endIndex)
    }
    
    return arr
}

/**
 Partition is the algorithm used to return a pivot index,
 from which all values will be placed to one side of (divide and conquer)
 */

// This is Hoare's partitioning algorithm, which is generally considered the most efficient
// Pivot is always expected to be the first element in the array
func partitionHoare<T:Comparable>(array: inout [T], startIndex: Int, endIndex: Int) -> Int {
    let pivot: T = array[startIndex + (endIndex - startIndex) / 2]
    var start: Int = startIndex - 1
    var end: Int = endIndex + 1
    
    while true {
        repeat { end -= 1 } while array[end] > pivot
        repeat { start += 1 } while array[start] < pivot
        
        if start < end {
            array.swapAt(start, end)
        } else {
            return end
        }
    }
}

// Another version:
// Lomuto's algorithm (which may or may not be easier to reason about ¯\_(ツ)_/¯
// - Still in place sorting, still divide and conquer
// - Difference: Uses last element in the array as a pivot value
func partitionLomuto<T: Comparable>(array: inout [T], start: Int, end: Int) -> Int {
    let pivot = array[end]
    
    var start = start
    for j in start..<end {
        if array[j] <= pivot {
            (array[start], array[j]) = (array[j], array[start])
            start += 1
        }
    }
    
    (array[start], array[end]) = (array[end], array[start])
    return start
}

func quickSortLomuto<T: Comparable>(array: inout [T], start: Int, end: Int) -> [T] {
    if start < end {
        let pivot = partitionLomuto(array: &array, start: start, end: end)
        quickSortLomuto(array: &array, start: start, end: pivot - 1)
        quickSortLomuto(array: &array, start: pivot + 1, end: end)
    }
    
    return array
}

// Simply return a random element from within the range as a pivot
// Performs efficiently under all (most?) circumstances
//
/** Quote from raywenderlich.com (https://github.com/raywenderlich/swift-algorithm-club/tree/master/Quicksort):
 It may seem strange to use random numbers in something like a sorting function, but it is necessary to make quicksort behave efficiently under all circumstances. With bad pivots, the performance of quicksort can be quite horrible, O(n^2). But if you choose good pivots on average, for example by using a random number generator, the expected running time becomes O(n log n), which is as good as sorting algorithms get.
 */
func partitionRandomPivot(start: Int, end: Int) -> Int {
    let range = ClosedRange(uncheckedBounds: (start, end))
    return Int.random(in: range)
}

func quickSortRandom<T:Comparable>(array: inout Array<T>, start: Int, end: Int) -> [T] {
    if start < end {
        let pivotIndex = partitionRandomPivot(start: start, end: end)
        (array[pivotIndex], array[end]) = (array[end], array[pivotIndex])
        
        let p = partitionLomuto(array: &array, start: start, end: end)
        quickSortRandom(array: &array, start: start, end: p - 1)
        quickSortRandom(array: &array, start: p + 1, end: end)
    }
    
    return array
}

// "Dutch flag partitioning"
// WHY? -> With Lomuto, if the pivot occurs more than once the duplicates end up in the left half
// -> and with Hoare's the pivot can be all over the place
func partitionDutchFlag<T: Comparable>(_ array: inout [T], startIndex: Int, endIndex: Int, pivotIndex: Int) -> (Int, Int) {
    let pivot = array[pivotIndex]
    
    var smaller = startIndex
    var equal = startIndex
    var larger = endIndex
    
    while equal <= larger {
        if array[equal] < pivot {
            array.swapAt(smaller, equal)
            smaller += 1
            equal += 1
        } else if array[equal] == pivot {
            equal += 1
        } else {
            array.swapAt(equal, larger)
            larger -= 1
        }
    }
    return (smaller, larger)
}

func dutchQuickSort<T: Comparable>(array: inout [T], start: Int, end: Int) -> [T] {
    if start < end {
        let pivotIndex = partitionRandomPivot(start: start, end: end)
        let (p, q) = partitionDutchFlag(&array, startIndex: start, endIndex: end, pivotIndex: pivotIndex)
        dutchQuickSort(array: &array, start: start, end: p - 1)
        dutchQuickSort(array: &array, start: q + 1, end: end)
    }
    
    return array
}

// Tests
var testArr = [ 10, 0, 3, 9, 2, 14, 8, 27, 1, 5, 8, 3, -1, 26 ]
//quickSortHoare(arr: &testArr, startIndex: 0, endIndex: testArr.count - 1)
quickSortLomuto(array: &testArr, start: 0, end: testArr.count - 1)
quickSortRandom(array: &testArr, start: 0, end: testArr.count - 1)
dutchQuickSort(array: &testArr, start: 0, end: testArr.count - 1)
