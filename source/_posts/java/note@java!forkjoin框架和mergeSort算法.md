# MergeSort.java
```java
import java.util.Arrays;
import java.util.concurrent.ForkJoinPool;
import java.util.concurrent.ForkJoinTask;
import java.util.concurrent.RecursiveAction;

/**
 *一个并行排序  ints数组的类。
 *一个ForkJoinPool用于并行性，使用merge排序算法将数组分成两部分，并创建一个新的子任务对于每一个部分。
 *每个子任务被分派给 ForkJoinPool它将把任务安排在线程中。这发生在数组的大小最多为2时元素长。
 *在这一点上，使用一个简单的比较来排序数组和可能的交换。然后通过使用insert排序完成任务合并两个刚刚排序的数组。
 *这个类的思想是演示递归操作的用法实现最佳的并行合并排序。这个版本创建每个合并(创建大量对象)的一个小数组，
 *这可以保持一个数组来避免。
 */
public class MergeSort {
    private final ForkJoinPool pool;

    private static class MergeSortTask extends RecursiveAction {
        private final int[] array;
        private final int low;
        private final int high;
        private static final int THRESHOLD = 8;

        /**
         * 创建包含数组和数组边界的 MergeSortTask
         *
         * @param array 数组进行排序
         * @param low 低位的元素开始排序
         * @param high 非包容的高位元素排序
         */
        protected MergeSortTask(int[] array, int low, int high) {
            this.array = array;
            this.low = low;
            this.high = high;
        }

        @Override
        protected void compute() {
            if (high - low <= THRESHOLD) {
                Arrays.sort(array, low, high);
            } else {
                int middle = low + ((high - low) >> 1);
                // Execute the sub tasks and wait for them to finish
                invokeAll(new MergeSortTask(array, low, middle), new MergeSortTask(array, middle, high));
                // Then merge the results
                merge(middle);
            }
        }

        /**
         *合并两个已排序的数组 this.low, middle - 1 and middle, this.high - 1
         * @param middle 数组中第二个排序列表的索引开始
         */
        private void merge(int middle) {
            if (array[middle - 1] < array[middle]) {
                return; // 数组已经被正确地排序了, 我们可以跳过归并
            }
            int[] copy = new int[high - low];
            System.arraycopy(array, low, copy, 0, copy.length);
            int copyLow = 0;
            int copyHigh = high - low;
            int copyMiddle = middle - low;

            for (int i = low, p = copyLow, q = copyMiddle; i < high; i++) {
                if (q >= copyHigh || (p < copyMiddle && copy[p] < copy[q]) ) {
                    array[i] = copy[p++];
                } else {
                    array[i] = copy[q++];
                }
            }
        }
    }

    /**
     * 创建一个包含有指定并行级别的ForkJoinPool的MergeSort
     * @param parallelism 使用的并行性水平
     */
    public MergeSort(int parallelism) {
        pool = new ForkJoinPool(parallelism);
    }

    /**
     * 使用ForkJoin框架对给定数组的所有元素进行排序
     * @param array 数组进行排序
     */
    public void sort(int[] array) {
        ForkJoinTask<Void> job = pool.submit(new MergeSortTask(array, 0, array.length));
        job.join();
    }
}
```
# MergeDemo.java
```java

import java.util.Arrays;
import java.util.Random;

import static java.lang.Integer.parseInt;

/**
	MergeExample是一个运行{ @ code ForkJoin }框架的演示基准的类
	通过基准测试使用的{ @ link MergeSort }算法 
	{ @link java.util.concurrent.RecursiveAction }
	{ @ code ForkJoin }
	框架的设置有不同的并行度这个排序是用不同大小的数组来执行的
	使用多个线程来处理不同大小的数组。
 */
public class MergeDemo {
    // 使用固定的种子总是得到相同的随机值
    private final Random random = new Random(759123751834L);
    private static final int ITERATIONS = 10;

    /**
     *公式:{@code f(n) = start + (step * n)} for n = 0 & n < iterations
     */
    private static class Range {
        private final int start;
        private final int step;
        private final int iterations;

        private Range(int start, int step, int iterations) {
            this.start = start;
            this.step = step;
            this.iterations = iterations;
        }

        /**
         * 解析开始, 从args的step和迭代
         * @param args 包含参数的字符串数组
         * @param start 从哪一个元素开始
         * @return 所构造的范围
         */
        public static Range parse(String[] args, int start) {
            if (args.length < start + 3) {
                throw new IllegalArgumentException("Too few elements in array");
            }
            return new Range(parseInt(args[start]), parseInt(args[start + 1]), parseInt(args[start + 2]));
        }

        public int get(int iteration) {
            return start + (step * iteration);
        }

        public int getIterations() {
            return iterations;
        }

        @Override
        public String toString() {
            StringBuilder builder = new StringBuilder();
            builder.append(start).append(" ").append(step).append(" ").append(iterations);
            return builder.toString();
        }
    }

    /**
     * 包装在运行MergeExample时使用的不同参数
     * {@code sizes} 不同的数组大小
     * {@code parallelism} 不同的并行性级别
     */
    private static class Configuration {
        private final Range sizes;
        private final Range parallelism;

        private final static Configuration defaultConfig = new Configuration(new Range(20000, 20000, 10),
                new Range(2, 2, 10));

        private Configuration(Range sizes, Range parallelism) {
            this.sizes = sizes;
            this.parallelism = parallelism;
        }

        /**
         * 解析参数和尝试创建包含创建数组大小和并行大小的参数的配置   
         * @param args 输入参数
         * @return 配置 
         */
        public static Configuration parse(String[] args) {
            if (args.length == 0) {
                return defaultConfig;
            } else {
                try {
                    if (args.length == 6) {
                        return new Configuration(Range.parse(args, 0), Range.parse(args, 3));
                    }
                } catch (NumberFormatException e) {
                    System.err.println("MergeExample: error: Argument was not a number.");
                }
                System.err.println("MergeExample <size start> <size step> <size steps> <parallel start> <parallel step>" +
                        " <parallel steps>");
                System.err.println("example: MergeExample 20000 10000 3 1 1 4");
                System.err.println("example: will run with arrays of sizes 20000, 30000, 40000" +
                        " and parallelism: 1, 2, 3, 4");
                return null;
            }
        }

        /**
         * 创建一个测试报告结果的时间的数组
         * @return an array containing {@code sizes.iterations * parallelism.iterations} elements
         */
        private long[][] createTimesArray() {
            return new long[sizes.getIterations()][parallelism.getIterations()];
        }

        @Override
        public String toString() {
            StringBuilder builder = new StringBuilder("");
            if (this == defaultConfig) {
                builder.append("Default configuration. ");
            }
            builder.append("Running with parameters: ");
            builder.append(sizes);
            builder.append(" ");
            builder.append(parallelism);
            return builder.toString();
        }
    }

    /**
     * 生成一组元素的随机元素
     * @param 元素数组中请求的元素个数
     * @return 一组随机元素数组
     */
    private int[] generateArray(int elements) {
        int[] array = new int[elements];
        for (int i = 0; i < elements; ++i) {
            array[i] = random.nextInt();
        }
        return array;
    }

    /**
     * 运行测试
     * @param 包含运行测试的配置
     */
    private void run(Configuration config) {
        Range sizes = config.sizes;
        Range parallelism = config.parallelism;

        // 运行一些排序使JIT编译/优化代码
        // 哪些应该会更公平一些
        warmup();

        long[][] times = config.createTimesArray();

        for (int size = 0; size < sizes.getIterations(); size++) {
            runForSize(parallelism, sizes.get(size), times, size);
        }

        printResults(sizes, parallelism, times);
    }

    /**
     * 用表格形式打印结果
     * @param sizes 数组的不同大小
     * @param parallelism 不同平行级别
     * @param times sizes / parallelism 的中间次数
     */
    private void printResults(Range sizes, Range parallelism, long[][] times) {
        System.out.println("Time in milliseconds. Y-axis: number of elements. X-axis parallelism used.");
        long[] sums = new long[times[0].length];
        System.out.format("%8s  ", "");
        for (int i = 0; i < times[0].length; i++) {
            System.out.format("%4d ", parallelism.get(i));
        }
        System.out.println("");
        for (int size = 0; size < sizes.getIterations(); size++) {
            System.out.format("%8d: ", sizes.get(size));
            for (int i = 0; i < times[size].length; i++) {
                sums[i] += times[size][i];
                System.out.format("%4d ", times[size][i]);
            }
            System.out.println("");
        }
        System.out.format("%8s: ", "Total");
        for (long sum : sums) {
            System.out.format("%4d ", sum);
        }
        System.out.println("");
    }

    private void runForSize(Range parallelism, int elements, long[][] times, int size) {
        for (int step = 0; step < parallelism.getIterations(); step++) {
            long time = runForParallelism(ITERATIONS, elements, parallelism.get(step));
            times[size][step] = time;
        }
    }

    /**
     * 运行随机数组的测试类型的迭代数的元素长度
     * @param iterations 迭代次数
     * @param elements 随机数组中的元素个数
     * @param parallelism ForkJoin框架的并行性
     * @return the median 运行时间
     */
    private long runForParallelism(int iterations, int elements, int parallelism) {
        MergeSort mergeSort = new MergeSort(parallelism);
        long[] times = new long[iterations];

        for (int i = 0; i < iterations; i++) {
            // Suggest the VM to run a garbage collection to reduce the risk of getting one
            // while running the test run
            System.gc();
            long start = System.currentTimeMillis();
            mergeSort.sort(generateArray(elements));
            times[i] = System.currentTimeMillis() - start;
        }

        return medianValue(times);
    }

    /**
     * 计算数组的中值
     * @param times 时间
     * @return 中间值
     */
    private long medianValue(long[] times) {
        if (times.length == 0) {
            throw new IllegalArgumentException("Empty array");
        }
        // Make a copy of times to avoid having side effects on the parameter value
        Arrays.sort(times.clone());
        long median = times[times.length / 2];
        if (times.length > 1 && times.length % 2 != 0) {
            median = (median + times[times.length / 2 + 1]) / 2;
        }
        return median;
    }

    /**
     * 生成1000个元素的1000个数组，并将它们排序为一个warmup
     */
    private void warmup() {
        MergeSort mergeSort = new MergeSort(Runtime.getRuntime().availableProcessors());
        for (int i = 0; i < 1000; i++) {
            mergeSort.sort(generateArray(1000));
        }
    }

    public static void main(String[] args) {
        Configuration configuration = Configuration.parse(args);
        if (configuration == null) {
            System.exit(1);
        }
        System.out.println(configuration);
        new MergeDemo().run(configuration);
    }
}
```