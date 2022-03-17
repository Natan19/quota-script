#! /usr/bin/env bash
ENDPOINT="http://economia.awesomeapi.com.br/json/last/USD-BRL"
AMOUNT=$1

getQuotaJson() {
  response="$(curl ${ENDPOINT})"
  echo ${response}
}

getCurrentUsdQuota() {
  quota="$(getQuotaJson | jq -r ".USDBRL" | jq -r ".ask")"
  echo $quota
}

calculateConvertedAmount() {
  calculated="$(echo "$1 * $2" | bc)"
  echo $calculated
}

USD_QUOTA=$(getCurrentUsdQuota)

echo "Current USD-BRL quota: $USD_QUOTA"

if [[  "$AMOUNT" -ne 0 ]]; then
  echo "Current amount in BRL: $(calculateConvertedAmount $USD_QUOTA $AMOUNT)"
fi
