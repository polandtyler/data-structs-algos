import java.util.Arrays;

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
}
