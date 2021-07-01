using System;
using System.Collections.Generic;
using System.Text;
using air_quality_data.Models;

namespace air_quality_data.DAO
{
    public interface IPollutionEvent
    {
        List<PollutionEvent> GetEvents();
        PollutionEvent InputPollutionEvent(PollutionEvent liveEvent);
        // Todo Determine if UpdateEvent is needed
        // void UpdateEvent(LiveEvent liveEvent);
        void DeleteEvent(PollutionEvent liveEvent);

    }
}
