#!/usr/bin/env python
import requests
import pandas as pd
from datetime import datetime
import os
# 1. Configuración inicial. 
API_KEY = "bd5cf379b6d6b7d080073db8791dd9eb"
LAT = "-1.0546"
LON = "-80.4544"
URL = f"https://api.openweathermap.org/data/2.5/weather?lat={LAT}&lon={LON}&appid={API_KEY}&units=metric"
CSV_PATH = '/home/alejandro/PortoviejoWeather/clima-portoviejo-hoy.csv'
# 2. Configuración para el CSV.
EXPECTED_COLUMNS = [
    'dt', 'coord_lon', 'coord_lat', 'weather_0_id', 'weather_0_main', 
    'weather_0_description', 'weather_0_icon', 'base', 'main_temp', 
    'main_feels_like', 'main_temp_min', 'main_temp_max', 'main_pressure', 
    'main_humidity', 'main_sea_level', 'main_grnd_level', 'visibility', 
    'wind_speed', 'wind_deg', 'wind_gust', 'clouds_all', 'sys_type', 
    'sys_id', 'sys_country', 'sys_sunrise', 'sys_sunset', 'timezone', 
    'id', 'name', 'cod'
]
# 3. Funciones necesarias.
def get_weather():
    try:
        response = requests.get(URL)
        if response.status_code == 200:
            data = response.json()
            # 1. Sacar 'weather' de la lista
            if 'weather' in data and len(data['weather']) > 0:
                w = data.pop('weather')[0]
                for k, v in w.items():
                    data[f"weather_0_{k}"] = v
            # 2. Aplanar JSON
            df = pd.json_normalize(data, sep='_')
            # 3. Convertir fechas
            for col in ['dt', 'sys_sunrise', 'sys_sunset']:
                if col in df.columns:
                    df[col] = pd.to_datetime(df[col], unit='s') - pd.Timedelta(hours=5)
            # 4. Forzar columnas exactas
            df = df.reindex(columns=EXPECTED_COLUMNS)
            # 5. Guardar en CSV
            if not os.path.isfile(CSV_PATH):
                df.to_csv(CSV_PATH, index=False, header=True)
            else:
                df.to_csv(CSV_PATH, mode='a', index=False, header=False)
            # Impresión de registros.
            fecha_actual = df['dt'].iloc[0]
            print(f"Éxito: Dato registrado para Portoviejo a las {fecha_actual}")
        else:
            print(f"Error API: {response.status_code}")
    except Exception as e:
        print(f"Error: {e}")
if __name__ == "__main__":
    get_weather()
