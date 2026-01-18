#!/bin/bash
#!/bin/bash
source /home/alejandro/miniforge3/etc/profile.d/conda.sh
eval "$(conda shell.bash hook)"
conda activate iccd332
cd /home/alejandro/PortoviejoWeather
python main.py
