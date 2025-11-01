check() {
  host=$1
  port=$2
  echo -n "🔌 $host:$port → "
  if nc -z $host $port 2>/dev/null; then
    echo "✅ reachable"
  else
    echo "❌ failed"
  fi
}

check postgres 5432
check elasticsearch 9200
check kibana 5601
check qdrant 6333
check minio 9000
check rabbitmq 5672
check vault 8200
check prometheus 9090
check grafana 3000
