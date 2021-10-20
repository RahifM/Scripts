set -e

upload() {
gdrive upload --share ${o} | grep http* | cut -d " " -f 7 > up.txt
up=$(cat up.txt)
bash ~/tele*/tele* -M "[${o}](${up})"
}

low() {
echo -e "\n720p\n"
time ffmpeg -v error -stats -i "${i}" -map 0 -s hd720 -c:v libx265 -x265-params log-level=error -crf 25 -sn -pix_fmt yuv420p10le -preset slow -ac 2 -c:a libopus -b:a 96k -pass 1 -abr 800 -vbr on "${o}"
}

high() {
echo -e "\n1080p\n"
time ffmpeg -v error -stats -i "${i}" -map 0 -s hd1080 -c:v libx265 -x265-params log-level=error -crf 23 -sn -pix_fmt yuv420p10le -preset slow -ac 2 -c:a libopus -b:a 128k -pass 1 -abr 1200 -vbr on "${o}"
}

echo -e "\n... Welcome :) ...\n"

echo -e "Please set input and input!\n"
read -p "Input: " i
read -p "Output: " o

if [ -z "$i" -o -z "$o" ]; then
       echo -e "\nNo input or output found\n"
       exit 1
fi

[ "$1" == "1" ] && low

[ "$1" == "2" ] && high

if [ -n "$1" ]; then
        echo -e "\nInvalid quality. Exiting...\n"
        exit 1
fi

echo -e "\nWarning: Quality not set. Using default"
low

# Upload that shit and lemme know :)

echo -e "\nUploading...\n"
[ ! -d ${o} ] && upload && echo Uploading done || echo Failed Upload
