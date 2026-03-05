using SequenceAlgorithm;

namespace IncreasingSequenceFinder
{
    public static class Program
    {
        public static void Main(string[] args)
        {
            // If arguments are provided, process them directly (for automated testing)
            if (args.Length > 0)
            {
                ProcessInput(args);
                return;
            }

            // Interactive mode
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

                var inputArray = input.Split(' ', StringSplitOptions.RemoveEmptyEntries);
                ProcessInput(inputArray);
                Console.WriteLine();
            }
        }

        private static void ProcessInput(string[] inputArray)
        {
            try
            {
                var nums = Array.ConvertAll(inputArray, int.Parse);
                var result = SubsequenceFinder.FindLongestIncreasingSubsequence(nums);
                Console.WriteLine(string.Join(' ', result));
            }
            catch (FormatException)
            {
                Console.WriteLine("Error: Please enter valid integers separated by spaces.");
                Environment.Exit(1);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error: {ex.Message}");
                Environment.Exit(1);
            }
        }
    }
}