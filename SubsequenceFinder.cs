namespace SequenceAlgorithm
{
    public static class SubsequenceFinder
    {
        public static int[] FindLongestIncreasingSubsequence(IReadOnlyList<int> numbers)
        {
            ArgumentNullException.ThrowIfNull(numbers);
            
            int n = numbers.Count;
            if (n == 0)
            {
                return Array.Empty<int>();
            }

            // Track the longest run found so far
            int longestRunStart = 0;
            int longestRunLength = 1;

            // Track the current run being scanned
            int currentRunStart = 0;
            int currentRunLength = 1;

            for (int i = 1; i < n; i++)
            {
                if (numbers[i] > numbers[i - 1])
                {
                    currentRunLength++;
                }
                else
                {
                    if (currentRunLength > longestRunLength)
                    {
                        longestRunLength = currentRunLength;
                        longestRunStart = currentRunStart;
                    }
                    currentRunStart = i;
                    currentRunLength = 1;
                }
            }

            // Check if the last run is the longest
            if (currentRunLength > longestRunLength)
            {
                longestRunLength = currentRunLength;
                longestRunStart = currentRunStart;
            }

            var result = new int[longestRunLength];
            for (int i = 0; i < longestRunLength; i++)
            {
                result[i] = numbers[longestRunStart + i];
            }

            return result;
        }
    }
}