import java.util.Arrays;
import java.util.Collections;
import java.util.Random;
import java.util.concurrent.ThreadLocalRandom;

public class QuickSort {

    public static void main(String[] args) {
        Integer[] ints = { 9, 2, 5, 3, 1254, 603, 13, 15, 1, 3, 4, 6};
        Integer[] dupes = { 4,3,1,2,3 };
        String[] strings = {"Zebra", "Xylophone", "Enjoy", "Llama", "King Arthur", "Lannister", "America", "America"};

        System.out.println(Arrays.toString(sort(ints, 0, ints.length - 1)));
        System.out.println(Arrays.toString(sort(strings, 0, strings.length - 1)));
        System.out.println(Arrays.toString(sort(dupes, 0, dupes.length - 1)));
    }


    private static <T extends Comparable<T>> T[] sort(T[] arr, int start, int end) {
        int partition = partition(arr, start, end);

        if (partition-1 > start) {
            sort(arr, start, partition - 1);
        }

        if (partition + 1 < end) {
            sort(arr, partition + 1, end);
        }

        return arr;
    }

    private static <T extends Comparable<T>> int partition(T[] arr, int start, int end) {
        T pivot = arr[start + (end-start) / 2];

        for (int i=start;i<end;i++) {
            if (arr[i].compareTo(pivot) <= 0) {
                T temp = arr[start];
                arr[start] = arr[i];
                arr[i] = temp;
                start++;
            }
        }

        T temp = arr[start];
        arr[start] = pivot;
        arr[end] = temp;

        return start;
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
        // TODO: implementation
    }

    public static <T extends Comparable<T>> T[] quickSortLomuto(T[] array, int start, int end) {

        // TODO: implementation

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

        // TODO: implementation

        return array;
    }

    public static <T extends Comparable<T>> int dutchFlagPartition(T[] array, int start, int end) {

        // TODO: implementation

    }

    public static <T extends Comparable<T>> T[] quickSortDutchFlag(T[] array, int start, int end) {

        // TODO: implementation

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