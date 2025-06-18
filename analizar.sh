#!/bin/bash
echo "=== Diagnóstico n8n 502 Error ==="

echo "1. Estado de Docker:"
systemctl is-active docker
echo ""

echo "2. Contenedores activos:"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
echo ""

echo "3. Estado docker-compose:"
cd /home/usuario/n8n-automation/
docker-compose ps
echo ""

echo "4. Puerto 5678:"
netstat -tulpn | grep :5678 || echo "Puerto 5678 no está en uso"
echo ""

echo "5. Logs recientes de n8n:"
docker-compose logs --tail=20 n8n
echo ""

echo "6. Test de conectividad local:"
curl -s -o /dev/null -w "Status: %{http_code}\n" http://127.0.0.1:5678/healthz 2>/dev/null || echo "No responde en puerto 5678"
echo ""

echo "7. Variables de entorno críticas:"
if [ -f .env ]; then
    echo "Archivo .env existe"
    grep -E "^(N8N_PORT|POSTGRES_|N8N_ENCRYPTION_KEY)" .env | head -5
else
    echo "❌ Archivo .env NO existe"
fi