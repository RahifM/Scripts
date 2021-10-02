# Set input and input 

read -p "Input: " i
read -p "Output: " o

# The meat and potato

#set -e

upload() {
gdrive upload --share ${o} | tail -1 | cut -d " " -f 7 > up.txt
up=$(cat up.txt)
bash ~/tele*/tele* -M "[${o}](${up})"
}

low() {
echo 720p
time ffmpeg -v error -stats -i "${i}" -map 0 -s hd720 -c:v libx265 -x265-params log-level=error -crf 25 -sn -pix_fmt yuv420p10le -preset slow -ac 2 -c:a libopus -b:a 96k -pass 1 -abr 800 -vbr on "${o}"
}

high() {
echo 1080p
time ffmpeg -v error -stats -i "${i}" -map 0 -s hd1080 -c:v libx265 -x265-params log-level=error -crf 23 -sn -pix_fmt yuv420p10le -preset slow -ac 2 -c:a libopus -b:a 128k -pass 1 -abr 1200 -vbr on "${o}"
}

[ "$1" == "1" ] && low

[ "$1" == "2" ] && high

[ -z "$1"  ] && echo Warning: Quality not set. Using default. && low

[ -n "$1" ] && exit 1

# Upload that shit and lemme know :)

[ ! -d ${o} ] && upload && echo Uploading done || echo Failed Upload
