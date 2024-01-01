#!/bin/bash

rawHex=${1:-"NO INPUT - \$1 IS EMPTY"} # This is in caps so passing the string throug sed won't insert \x into it. For info about the {:-} syntax, see Shell Parameter Expansion

echo $rawHex | sed -E "s/([0-9a-z]{2})/\\\x\1/g"