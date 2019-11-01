import org.junit.Before;
import org.junit.Test;

import java.util.Arrays;

import static org.junit.Assert.*;

public class QuickSortTest {
    static Integer[] ints;
    static String[] strings;

    static Integer[] orderedInts;
    static String[] orderedStrings;

    @Before
    public void beforeEach() {
        ints = new Integer[] { 10, 0, 3, 9, 2, 14, 8, 27, 1, 5, 8, 3, -1, 26 };
        strings = new String[] {"Zebra", "Xylophone", "America", "Enjoy", "Llama", "King Arthur", "Lannister", "America"};

        orderedInts = new Integer[] { -1, 0, 1, 2, 3, 3, 5, 8, 8, 9, 10, 14, 26, 27 };
        orderedStrings = new String[] { "America", "America", "Enjoy", "King Arthur", "Lannister", "Llama", "Xylophone", "Zebra" };
    }

    @Test
    public void main() {
    }

    @Test
    public void partitionHoare() {
        assertEquals(QuickSort.partitionHoare(ints, 0, ints.length - 1), 7);
    }

    @Test
    public void quickSortHoare_integers() {
        Integer[] testArr = QuickSort.quickSortHoare(ints, 0, ints.length - 1);
        assertArrayEquals(testArr, orderedInts);
    }

    @Test
    public void quickSortHoare_strings() {
        String[] testArr = QuickSort.quickSortHoare(strings, 0, strings.length - 1);
        assertArrayEquals(testArr, orderedStrings);
    }

    @Test
    public void partitionLomuto() {
        System.out.println(QuickSort.partitionLomuto(ints, 0, ints.length - 1));
//        assertEquals(QuickSort.partitionLomuto(ints, 0, ints.length - 1), 12);
    }

    @Test
    public void quickSortLomuto_integers() {
        Integer[] testArr = QuickSort.quickSortLomuto(ints, 0, ints.length - 1);
        System.out.println(Arrays.toString(testArr));
        assertArrayEquals(testArr, orderedInts);
    }

    @Test
    public void quickSortLomuto_strings() {
        String[] testArr = QuickSort.quickSortLomuto(strings, 0, strings.length - 1);
        System.out.println(Arrays.toString(QuickSort.quickSortLomuto(strings, 0, strings.length - 1)));
        assertArrayEquals(testArr, orderedStrings);
    }

    @Test
    public void quickSortRandom() {
        Integer[] testArr = QuickSort.quickSortRandom(ints, 0, ints.length - 1);
        System.out.println(Arrays.toString(testArr));
        assertArrayEquals(testArr, orderedInts);
    }

    @Test
    public void quickSortDutchFlag_integers() {
        Integer[] testArr = QuickSort.quickSortDutchFlag(ints, 0, ints.length - 1);
        assertArrayEquals(testArr, orderedInts);
    }

    @Test
    public void quickSortDutchFlag_strings() {
        String[] testArr = QuickSort.quickSortDutchFlag(strings, 0, strings.length - 1);
        assertArrayEquals(testArr, orderedStrings);
    }
}