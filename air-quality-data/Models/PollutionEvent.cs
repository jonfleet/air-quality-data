using System;
using System.Collections.Generic;
using System.Text;

namespace air_quality_data.Models
{
    public class PollutionEvent
    {
        public string Country { get; set; }
        public string State { get; set; }
        public string City { get; set; }
        public string Timestamp { get; set; }
        public int AQI { get; set; }
        public string MainUs { get; set; }


    }
}
