#!/bin/bash

# Check if arguments are provided
if [ $# -ne 3 ]; then
    echo "Usage: $0 <screen_name> <start_number> <end_number>"
    echo "Example: $0 nexus-main 20 30"
    exit 1
fi

SCREEN_NAME=$1
START_NUM=$2
END_NUM=$3

# Validate numbers
if ! [[ "$START_NUM" =~ ^[0-9]+$ ]] || ! [[ "$END_NUM" =~ ^[0-9]+$ ]]; then
    echo "Error: Start and end numbers must be positive numbers"
    exit 1
fi

if [ "$START_NUM" -gt "$END_NUM" ]; then
    echo "Error: Start number must be less than or equal to end number"
    exit 1
fi

# Create screens with given name from start to end number
for i in $(seq $START_NUM $END_NUM)
do
    # Check if screen already exists
    if ! screen -list | grep -q "${SCREEN_NAME}${i}"; then
        # Create new screen (-d -m: create in detached mode)
        screen -d -m -S "${SCREEN_NAME}${i}"
        echo "Screen created: ${SCREEN_NAME}${i}"
    else
        echo "Screen already exists: ${SCREEN_NAME}${i}"
    fi
done

# Display list of running screens
echo -e "\nCurrent running screens:"
screen -list