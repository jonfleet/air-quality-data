using RestSharp;
using System;
using System.Collections.Generic;
using System.Text;
using air_quality_data.Services;
using air_quality_data.Models;
using air_quality_data.DAO;

namespace air_quality_data
{
    
    public class LogService
    {
        private APIService API = new APIService();
        private IPollutionEvent pollutionEventDao = new PollutionEventSqlDao("Server =.\\SQLEXPRESS; Database = air_quality_data; Trusted_Connection = True;");

        public void Run()
        {
            // Call API Service
            LiveEvent liveEvent = API.GetPittsburghAirQuality();

            // Convert LiveEvent into PollutionEvent

            PollutionEvent pollutionEvent = ConvertLiveEventToPollutionEvent(liveEvent);

            // Log The Event in the Database
            try
            {
                PollutionEvent addedEvent = pollutionEventDao.InputPollutionEvent(pollutionEvent);
                DisplayToConsole(addedEvent);
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            

            // Show display what was logged on the Console.
            
        }

        private PollutionEvent ConvertLiveEventToPollutionEvent(LiveEvent liveEvent)
        {
            PollutionEvent pollEvent = new PollutionEvent();
            pollEvent.Country = liveEvent.data.country;
            pollEvent.State = liveEvent.data.state;
            pollEvent.City = liveEvent.data.city;
            pollEvent.Timestamp = liveEvent.data.current.pollution.ts;
            pollEvent.AQI = liveEvent.data.current.pollution.aqius;
            pollEvent.MainUs = liveEvent.data.current.pollution.mainus;

            return pollEvent;
        }

        private void DisplayToConsole(PollutionEvent pollutionEvent)
        {

            DateTime currentTime = DateTime.Parse(pollutionEvent.Timestamp);
            Console.WriteLine($"The Air Quality Index (AQI) in {pollutionEvent.City} on {currentTime.Date:d} at {currentTime.TimeOfDay} was {pollutionEvent.AQI}");
        }


    }
}
