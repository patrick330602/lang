#!/bin/bash
dialog --inputbox "Enter your Post filename:" 8 40 2>answer
echo "test"
data=$(cat answer)
echo $data
