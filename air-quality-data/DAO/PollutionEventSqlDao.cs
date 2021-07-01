using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using air_quality_data.Models;

namespace air_quality_data.DAO
{
    public class PollutionEventSqlDao : IPollutionEvent
    {
        private readonly string ConnectionString;

        public PollutionEventSqlDao(string dbConnectionString)
        {
            ConnectionString = dbConnectionString;
        }

        public List<PollutionEvent> GetEvents()
        {
            List<PollutionEvent> pollutionEvents = new List<PollutionEvent>();
            try
            {
                using(SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand("select country_name, state_name, city_name, pollution_timestamp, aqi, mainus " +
                        "from pollution_event as pe " +
                        "join country as ct " +
                        "on ct.country_id = pe.country_id " +
                        "join state as s " +
                        "on s.state_id = pe.state_id" +
                        "join city as cy " +
                        "on cy.city_id = pe.city_id;", conn);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        PollutionEvent pollEvent = GetLiveEventFromReader(reader);
                        pollutionEvents.Add(pollEvent);
                    }
                }
            }
            catch (Exception e)
            {
                throw;
            }
            return pollutionEvents; 
        }

        private PollutionEvent GetLiveEventFromReader(SqlDataReader reader)
        {
            PollutionEvent pollEvent = new PollutionEvent();
            pollEvent.Country = Convert.ToString(reader["country_name"]);
            pollEvent.State = Convert.ToString(reader["state_name"]);
            pollEvent.City = Convert.ToString(reader["city_name"]);
            pollEvent.Timestamp = Convert.ToString(reader["pollution_timestamp"]);
            pollEvent.AQI = Convert.ToInt32(reader["aqi"]);
            pollEvent.MainUs = Convert.ToString(reader["mainus"]);

            return pollEvent;

        }
        public PollutionEvent InputPollutionEvent(PollutionEvent pollutionEvent)
        {

            try
            {
                using(SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand("dbo.insert_pollution_event", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@country_name", SqlDbType.VarChar, 50).Value = pollutionEvent.Country;
                    cmd.Parameters.Add("@state_name", SqlDbType.VarChar, 50).Value = pollutionEvent.State;
                    cmd.Parameters.Add("@city_name", SqlDbType.VarChar, 50).Value = pollutionEvent.City;
                    cmd.Parameters.Add("@pollution_timestamp", SqlDbType.DateTime).Value = pollutionEvent.Timestamp;
                    cmd.Parameters.Add("@aqi", SqlDbType.Int).Value = pollutionEvent.AQI;
                    cmd.Parameters.Add("mainus", SqlDbType.VarChar, 5).Value = pollutionEvent.MainUs;

                    cmd.ExecuteNonQuery();
                    return pollutionEvent;
                }
            }
            catch (Exception e)
            {
                throw e;
            }
            
        }

        public void DeleteEvent(PollutionEvent liveEvent)
        {
            // Delete event from Archive
        }
    }
}
