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

USD_QUOTA=$(getCurrentUsdQuota)

calculateConvertedAmount() {
  calculated="$(echo "$USD_QUOTA * $AMOUNT" | bc)"
  echo $calculated
}

echo "Current USD-BRL quota: $USD_QUOTA"
echo "Current salary in BRL: $(calculateConvertedAmount)"
