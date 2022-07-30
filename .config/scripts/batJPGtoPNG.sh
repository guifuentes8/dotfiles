#!/bin/bash

for image in *.jpg; do
convert "$image" "${image%.jpg}.png"

echo "image $image converted to ${image%}.jpg"

done

exit 0
