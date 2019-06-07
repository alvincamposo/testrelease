#!/bin/bash

LAST_RELEASE_DATE="2019-04-19T23:59:59Z"

LABEL_MUST_FOR_NEXT_RELEASE="Must for Next Release"
LABEL_PLEASE_REVIEW="please review"

HUB_COMMAND='hub api search/issues?q=repo:fastretailing/fr-css-framework+is:pr+label:%22must%20for%20next%20release%22'
$HUB_COMMAND | jq --arg must_for_next "$LABEL_MUST_FOR_NEXT_RELEASE" --arg please_review "$LABEL_PLEASE_REVIEW" --arg last_release "$LAST_RELEASE_DATE" -r '.items |map(select(.closed_at == null or .closed_at > $last_release  )) | sort_by(.closed_at) |.[] |  "- " + .title + reduce .labels[].name as $item (""; . + if $item != $must_for_next and $item !=$please_review then " [`"+$item+"`]" else "" end) + " [#" + (.number|tostring) + "](" + .html_url + ")"'
