#!/bin/bash#!/bin/bash

city=Shakhty

# Save current IFS
SAVEIFS=$IFS
# Change IFS to new line.
IFS=$'\n'

weather=($(cat $cachedir/$cachefile))

# Restore IFSClear
IFS=$SAVEIFS

temperature=$(echo ${weather[2]} | sed -E 's/([[:digit:]]+)\.\./\1 to /g')

#echo ${weather[1]##*,}

# https://fontawesome.com/icons?s=solid&c=weather
case $(echo ${weather[1]##*,} | tr '[:upper:]' '[:lower:]') in
"clear" | "sunny")
    condition="☀️"
    ;;
"partly cloudy")
    condition="☁️"
    ;;
"cloudy")
    condition="☁️"
    ;;
"overcast")
    condition="⛅️"
    ;;
"fog" | "freezing fog")
    condition="☁️"
    ;;
"patchy rain possible" | "patchy light drizzle" | "light drizzle" | "patchy light rain" | "light rain" | "light rain shower" | "mist" | "rain")
    condition="🌧️"
    ;;
"moderate rain at times" | "moderate rain" | "heavy rain at times" | "heavy rain" | "moderate or heavy rain shower" | "torrential rain shower" | "rain shower")
    condition="🌧️"
    ;;
"patchy snow possible" | "patchy sleet possible" | "patchy freezing drizzle possible" | "freezing drizzle" | "heavy freezing drizzle" | "light freezing rain" | "moderate or heavy freezing rain" | "light sleet" | "ice pellets" | "light sleet showers" | "moderate or heavy sleet showers")
    condition="⛈"
    ;;
"blowing snow" | "moderate or heavy sleet" | "patchy light snow" | "light snow" | "light snow showers")
    condition="❄️"
    ;;
"blizzard" | "patchy moderate snow" | "moderate snow" | "patchy heavy snow" | "heavy snow" | "moderate or heavy snow with thunder" | "moderate or heavy snow showers")
    condition="🌨"
    ;;
"thundery outbreaks possible" | "patchy light rain with thunder" | "moderate or heavy rain with thunder" | "patchy light snow with thunder")
    condition="⛈"
    ;;
*)
    condition=""
    echo -e "err"
    ;;
esac

#echo $temp $condition

echo -e "$condition $temperature"

