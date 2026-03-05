using SequenceAlgorithm;

namespace IncreasingSequenceFinder
{
    public static class Program
    {
        public static void Main(string[] args)
        {
            Console.WriteLine("Longest Increasing Subsequence Calculator");
            Console.WriteLine("Enter numbers separated by spaces (or 'exit' to stop)");
            Console.WriteLine();

            while (true)
            {
                Console.Write("Enter numbers: ");
                var input = Console.ReadLine();

                if (string.IsNullOrWhiteSpace(input) || input.Trim().Equals("exit", StringComparison.OrdinalIgnoreCase))
                {
                    break;
                }

                var nums = Array.ConvertAll(input.Split(' ', StringSplitOptions.RemoveEmptyEntries), int.Parse);
                var result = SubsequenceFinder.FindLongestIncreasingSubsequence(nums);

                Console.WriteLine($"Output: {string.Join(' ', result)}");
                Console.WriteLine();
            }
        }
    }
}