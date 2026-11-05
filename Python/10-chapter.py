#1
import math
print(math.sqrt(4), math.sqrt(9), math.sqrt(144))
#2
r = 10
print(2*math.pi*r, math.pi * r * r)
#3
import random as rd
print(rd.randint(1, 10))
#4
orel = 0
reshka = 0
for i in range(100):
    r = rd.randint(0, 1)
    if(r == 0):
        orel+=1
    else:
        reshka += 1
print(orel, reshka)
#5
'''
клиент - программа запрашивает данные 
сервер - хранилище данных
запрос - послать сообшение с просьбой предоставить определеные даннные
ответ - предоставленые данные
апи - правила по котрым клиент делает запросы и получает ответ от сервера
'''
#6-10
import openmeteo_requests

import pandas as pd
import requests_cache
from retry_requests import retry

# Setup the Open-Meteo API client with cache and retry on error
cache_session = requests_cache.CachedSession('.cache', expire_after = 3600)
retry_session = retry(cache_session, retries = 5, backoff_factor = 0.2)
openmeteo = openmeteo_requests.Client(session = retry_session)

# Make sure all required weather variables are listed here
# The order of variables in hourly or daily is important to assign them correctly below
url = "https://api.open-meteo.com/v1/forecast"
params = {
	"latitude": 55.75,
	"longitude": 37.37,
	"hourly": ["temperature_2m", "apparent_temperature"],
	"current": "wind_speed_10m",
	"timezone": "Europe/Moscow",
	"forecast_days": 1,
}
responses = openmeteo.weather_api(url, params = params)

# Process first location. Add a for-loop for multiple locations or weather models
response = responses[0]
print(f"Координаты: {response.Latitude()}°N {response.Longitude()}°E")
print(f"Высота над уровнем моря: {response.Elevation()} м")
print(f"Часовой пояс: {response.Timezone()}{response.TimezoneAbbreviation()}")
print(f"Разница с GMT+0: {response.UtcOffsetSeconds()}с")

# Process current data. The order of variables needs to be the same as requested.
current = response.Current()
current_wind_speed_10m = current.Variables(0).Value()

print(f"\nТекущее время: {current.Time()}")
print(f"Текущая скорость ветра: {current_wind_speed_10m}")

# Process hourly data. The order of variables needs to be the same as requested.
hourly = response.Hourly()
hourly_temperature_2m = hourly.Variables(0).ValuesAsNumpy()
hourly_apparent_temperature = hourly.Variables(1).ValuesAsNumpy()

hourly_data = {
	"date": pd.date_range(
		start = pd.to_datetime(hourly.Time(), unit = "s", utc = True),
		end =  pd.to_datetime(hourly.TimeEnd(), unit = "s", utc = True),
		freq = pd.Timedelta(seconds = hourly.Interval()),
		inclusive = "left"
	).tz_convert(response.Timezone().decode())
}

hourly_data["temperature_2m"] = hourly_temperature_2m
hourly_data["apparent_temperature"] = hourly_apparent_temperature

hourly_dataframe = pd.DataFrame(data = hourly_data)
print("\nДанные по часам\n", hourly_dataframe)

















