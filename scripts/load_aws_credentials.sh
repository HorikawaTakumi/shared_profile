#!/bin/bash

SERIAL_ARN="arn:aws:iam::198559300396:mfa/takumi-horikawa_otp-authenticator"

# 引数または標準入力からOTPを取得
if [ -z "$1" ]; then
  read -p "Enter your OTP: " otp
else
  otp=$1
fi

# get-session-tokenコマンドを実行して、JSON出力を取得
json_output=$(aws sts get-session-token --duration-seconds 900 --serial-number "$SERIAL_ARN"  --token-code "$otp" 2>&1)

# コマンドの終了ステータスを確認
if [ $? -ne 0 ]; then
  echo "Error executing aws sts get-session-token:"
  echo "$json_output"
  exit 1
fi

# jqコマンドを使用して値を抽出し、変数に格納する
AccessKeyId=$(echo "$json_output" | jq -r '.Credentials.AccessKeyId')
SecretAccessKey=$(echo "$json_output" | jq -r '.Credentials.SecretAccessKey')
SessionToken=$(echo "$json_output" | jq -r '.Credentials.SessionToken')
Expiration=$(echo "$json_output" | jq -r '.Credentials.Expiration')

cat << EOF
[default]
aws_access_key_id = $AccessKeyId
aws_secret_access_key = $SecretAccessKey
aws_session_token = $SessionToken
EOF

