#!/bin/sh
while sleep 1; do
	sh ./update_resource.sh
	sh ./update_progress.sh
done
