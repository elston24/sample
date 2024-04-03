% Define your ThingSpeak channel ID and read API key
channelID = 2488446;
ReadAPIKey = 'BEQ2ZGBOU739MUN5';

% Time range for fetching data
endDate = datetime('now', 'timezone', 'local');
startDate = endDate - hours(5);

% Fetching data from ThingSpeak
[data, time] = fetchDataFromThingSpeak(channelID, ReadAPIKey, startDate, endDate);

% Displaying fetched data
displayFetchedData(data, time);

function [data, time] = fetchDataFromThingSpeak(channelID, readAPIKey, startDate, endDate)
    [data, time] = thingSpeakRead(channelID, 'DateRange', [startDate, endDate], 'ReadKey', readAPIKey);
end

function displayFetchedData(data, time)
    % Checking if data is received
    if ~isempty(data)
        disp("Data from Last 5 Hours:");
        
        % Assuming each row in 'data' corresponds to [Temperature, Humidity, CO2]
        for i = 1:size(data, 1)
            fprintf("Time: %s, ", datestr(time(i)));
            fprintf("Temperature data: %.2f °C, ", data(i, 1));
            fprintf("Humidity data: %.2f %%, ", data(i, 2));
            fprintf("CO2 Level data: %.2f ppm\n", data(i, 3));
        end
    else
        disp("No data received in the last 5 hours.");
    end
end
