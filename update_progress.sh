metrics=`curl 127.0.0.1:9001`
block=`echo "$metrics" | grep 'reth_sync_entities_processed{stage="Bodies"}' | cut -f2 -d' '`
# We use MerkleUnwind instead of the Execution stage because the metric for the latter is not in blocks, while that for MerkleUnwind is. Currently the MerkleUnwind stage is skipped, making the result an accurate representation of the progress of Execution.
execution=`echo "$metrics" | grep 'reth_sync_entities_processed{stage="MerkleUnwind"}' | cut -f2 -d' '`
reth=`echo "$metrics" | grep 'reth_sync_entities_processed{stage="Finish"}' | cut -f2 -d' '`
# Do not even bother with the lighthouse metrics endpoint since it's slow.
lighthouse=`curl -X 'GET' 'http://localhost:5052/eth/v1/node/syncing' -H 'accept: application/json' | sed 's/.*head_slot":"\([0-9]*\)".*/\1/'`

rrdtool update progress.rrd N:$lighthouse:$block:$execution:$reth
