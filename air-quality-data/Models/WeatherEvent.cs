using System;
using System.Collections.Generic;
using System.Text;

namespace air_quality_data.Models
{
    public class WeatherEvent
    {
        public string Country { get; set; }
        public string State { get; set; }
        public string Timestamp { get; set; }
        public int Temperature { get; set; }
        public int Humidity { get; set; }
    }
}
