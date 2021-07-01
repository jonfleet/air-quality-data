using System;
using air_quality_data.Services;

namespace air_quality_data
{
    class Program
    {
        static void Main(string[] args)
        {

            
            LogService logger = new LogService();
            logger.Run();

            
        }
    }
}
