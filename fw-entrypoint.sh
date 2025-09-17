#!/bin/sh
set -eu

RULE_ARGS="-o lo -p tcp --tcp-flags RST RST \
  -s 127.0.0.1 --sport ${SRC_PORT} \
  -d 127.0.0.1 --dport ${DST_PORT} -j DROP"

# 追加
if iptables -C OUTPUT $RULE_ARGS 2>/dev/null; then
  echo "[fw] rule already exists"
else
  echo "[fw] adding rule: $RULE_ARGS"
  iptables -I OUTPUT 1 $RULE_ARGS
fi

# 終了時に削除
cleanup() {
  echo "[fw] removing rule"
  iptables -D OUTPUT $RULE_ARGS || true
}
trap cleanup INT TERM EXIT

# fw コンテナは常駐させておく
tail -f /dev/null & wait $!
