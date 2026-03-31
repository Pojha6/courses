#!/bin/bash

echo "=== Log Analysis Report ==="
echo

echo "--- Line Counts ---"
echo "Total lines: $(wc -l < server.log)"
echo "Error lines: $(grep "ERROR" server.log | wc -l)"
echo "Warning lines: $(grep "WARN" server.log | wc -l)"
echo

echo "--- Unique Error Messages ---"
grep "ERROR" server.log | awk '{for(i=4;i<=NF;i++) printf "%s ", $i; print ""}' | sort | uniq
echo

echo "--- Top Endpoints ---"
grep -E "GET|POST" server.log | awk '{print $5, $6}' | sort | uniq -c | sort -rn
echo

echo "--- User Login Activity ---"
grep "session created for user=" server.log | grep -o 'user=[a-z]*' | sort | uniq -c | sort -rn
echo

echo "Report generated: $(date)"