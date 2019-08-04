import java.util.Arrays;
import java.util.concurrent.ThreadLocalRandom;

public class QuickSort {

    public static void main(String[] args) {
        Integer[] ints = { 10, 0, 3, 9, 2, 14, 8, 27, 1, 5, 8, 3, -1, 26 };
        String[] strings = {"Zebra", "Xylophone", "Enjoy", "Llama", "King Arthur", "Lannister", "America", "America"};

        System.out.println("HOARE'S ALGORITHM");
        System.out.println(Arrays.toString(quickSortHoare(ints, 0, ints.length - 1)));
        System.out.println(Arrays.toString(quickSortHoare(strings, 0, strings.length - 1)));

        System.out.println("LOMUTO'S ALGORITHM");
        System.out.println(Arrays.toString(quickSortLomuto(ints, 0, ints.length - 1)));
        System.out.println(Arrays.toString(quickSortLomuto(strings, 0, strings.length - 1)));

        System.out.println("RANDOM PIVOT GENERATION ALGORITHM");
        System.out.println(Arrays.toString(quickSortRandom(ints, 0, ints.length - 1)));
        System.out.println(Arrays.toString(quickSortRandom(strings, 0, strings.length - 1)));

        System.out.println("DUTCH FLAG ALGORITHM");
        System.out.println(Arrays.toString(quickSortDutchFlag(ints, 0, ints.length - 1)));
        System.out.println(Arrays.toString(quickSortDutchFlag(strings, 0, strings.length - 1)));
    }

    /*
    Partitioning using Hoare's algorithm to find the pivot
     */
    public static <T extends Comparable<T>> int partitionHoare(T[] array, int start, int end) {
        T pivot = array[start + (end - start) / 2];

        int startIndex = start - 1;
        int endIndex = end + 1;

        while (true) {
            do { endIndex -= 1; } while (array[endIndex].compareTo(pivot) > 0);
            do { startIndex += 1; } while (array[startIndex].compareTo(pivot) < 0);

            if (startIndex < endIndex) {
                ArraySwapHelper.swap(array, startIndex, endIndex);
            } else {
                return endIndex;
            }
        }


    }

    public static <T extends Comparable<T>> T[] quickSortHoare(T[] array, int start, int end) {
        if (start < end) {
            int pivotValue = partitionHoare(array, start, end);

            quickSortHoare(array, start, pivotValue);
            quickSortHoare(array, pivotValue + 1, end);
        }

        return array;
    }

    /*
    Partitioning using Lomuto's algorithm to find the pivot
     */
    public static <T extends Comparable<T>> int partitionLomuto(T[] array, int start, int end) {
        T pivot = array[end];

        for (int i = start; i <= end; i++) {
            if (array[i].compareTo(pivot) < 0) {
                array[start] = array[i];
                array[i] = array[start];
                start += 1;
            }
        }

        array[start] = array[end];
        array[end] = array[start];

        return start;
    }

    public static <T extends Comparable<T>> T[] quickSortLomuto(T[] array, int start, int end) {
        if (start < end) {
            int pivot = partitionLomuto(array, start, end);
            quickSortLomuto(array, start, pivot - 1);
            quickSortLomuto(array, pivot + 1, end);
        }

        return array;
    }

    /*
    Perform quicksort based on a random integer from within the range `(start, end)`
     */
    public static int partitionRandom(int start, int end) {
        if (start > end) { throw new IllegalArgumentException("Start index must be less than end index"); }
        return ThreadLocalRandom.current().nextInt(start, end);
    }

    public static <T extends Comparable<T>> T[] quickSortRandom(T[] array, int start, int end) {
        if (start < end) {
            int pivotIndex = partitionRandom(start, end);

            array[pivotIndex] = array[end];
            array[end] = array[pivotIndex];

            int p = partitionLomuto(array, start, end);
            quickSortRandom(array, start, p - 1);
            quickSortRandom(array, p + 1, end);
        }

        return array;
    }

    public static <T extends Comparable<T>> Tuple<Integer, Integer> dutchFlagPartition(T[] array, int start, int end, int pivotIndex) {
        T pivot = array[pivotIndex];

        int smaller = start;
        int equal = start;
        int larger = end;

        while (equal <= larger) {
            if (array[equal].compareTo(pivot) < 0) {
                ArraySwapHelper.swap(array, smaller, equal);
                smaller += 1;
                equal += 1;
            } else if (array[equal].compareTo(pivot) == 0) {
                equal += 1;
            } else {
                ArraySwapHelper.swap(array, equal, larger);
                larger += 1;
            }
        }

        return new Tuple<>(smaller, larger);

    }

    public static <T extends Comparable<T>> T[] quickSortDutchFlag(T[] array, int start, int end) {
        if (start < end) {
            int pivot = partitionRandom(start, end);

            Tuple<Integer, Integer> pair = dutchFlagPartition(array, start, end, pivot);
            quickSortDutchFlag(array, start, pair.x - 1);
            quickSortDutchFlag(array, pair.y + 1, end);
        }
        
        return array;
    }

}

class ArraySwapHelper {
/*
HELPERS
 */
    public static final <T extends Comparable<T>> void swap(T[] array, int first, int second) {
        T t = array[first];
        array[first] = array[second];
        array[second] = t;
    }
}

class Tuple<X, Y> {
    public final X x;
    public final Y y;
    public Tuple(X x, Y y) {
        this.x = x;
        this.y = y;
    }
}