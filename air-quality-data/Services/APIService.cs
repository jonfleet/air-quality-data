using RestSharp;
using System;
using System.Collections.Generic;
using System.Text;
using air_quality_data.Models;
using System.Net.Http;

namespace air_quality_data.Services
{
    public class APIService
    {
        private readonly string API_URL = "https://api.airvisual.com/v2/city?city=Pittsburgh&state=Pennsylvania&country=USA";
        private readonly string API_KEY = "a9d9bfa3-60e6-404d-a8c6-65c688b8990f";

        public LiveEvent GetPittsburghAirQuality()
        {
            RestClient client = new RestClient(API_URL + "&key=" + API_KEY);
            client.Timeout = -1;
            var request = new RestRequest(Method.GET);
            IRestResponse<LiveEvent> response = client.Execute<LiveEvent>(request);
            ProcessResponse(response);
            
            return response.Data;
        }

        private bool ProcessResponse(IRestResponse response)
        {
            if (response.ResponseStatus != ResponseStatus.Completed)
            {
                throw new HttpRequestException("Error Occured - Unable to Reach Server");
            }

            if (!response.IsSuccessful)
            {
                throw new HttpRequestException("Error Occured - Unsuccessful Response");
            }

            return true;
        }
    }
}
