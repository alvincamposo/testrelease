#!/bin/bash

MUST_FOR_NEXT_RELEASE_TAG='Release'
PLEASE_REVIEW_TAG='please review'

HUB_COMMAND='hub api search/issues?q=repo:alvincamposo/testrelease+is:pr+label:Release' 
$HUB_COMMAND | jq --arg must_for_next "$MUST_FOR_NEXT_RELEASE_TAG" --arg please_review "$PLEASE_REVIEW_TAG" -r '.items | sort_by(.closed_at) |.[] |  "- " + .title + reduce .labels[].name as $item (""; . + if $item != $must_for_next and $item !=$please_review then " [`"+$item+"`]" else "" end) + " [#" + (.number|tostring) + "](" + .html_url + ")"'