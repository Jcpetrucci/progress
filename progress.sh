#!/bin/bash
# Create: 2014-05-12 John C. Petrucci
# http://johncpetrucci.com
# Purpose: Display progress; current step and dynamically calculated percent of completion.
# Usage: Call function "updateProgress [[weight] description]".  Modify 'steps' variable as needed.  If weight is 0 jump to 100%.  If description is given weight must preceed, but both are optional.

updateProgress () {
	steps=15
        taskWeight=${1-1} # If a task weight multiplier is not given assume no multiplier.
        description=${2-Working...}
        [[ $taskWeight -eq 0 ]] && { printf "100%% complete: %-*s\n" ${previousDescription-100} "finished."; return; }  # Tidy up and show a round 100 in case of fractions.
        index=$(( index + 1 * taskWeight ))
        pct=$(( 100 / steps * index ))
        printf "%3d%% complete: %-*s\r" "$pct" ${previousDescription-0} "$description"
	(( pct >= 100 )) && { printf "\n"; exit; }
        previousDescription=${#description}
}

demo () {
	updateProgress 1 "First step"
	sleep 1
	updateProgress 3 "Second step"
	sleep 1
	updateProgress 3 "Third step"
	sleep 1
	updateProgress 3 "Fourth step"
	sleep 1
	updateProgress 3 "Fifth step"
	sleep 1
	updateProgress 0 
}

demo
