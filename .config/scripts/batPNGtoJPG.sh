#!/bin/bash

for image in *.png; do

convert "$image" "${image%.png}.jpg"

echo "image $image converted to ${image%}.jpg"

done

exit 0
