# 🧱 Aether Phase 0: Core Infrastructure Stack

This stack sets up the foundational services for the Aether platform — an AI-first, multi-tenant Threat Intelligence & Log Analysis system.

---

## 🚀 What's Included

| Service        | Purpose                              | Port(s)       |
|----------------|--------------------------------------|---------------|
| PostgreSQL     | Main relational database             | 5432          |
| Elasticsearch  | Log indexing and search              | 9200          |
| Kibana         | UI for Elasticsearch                 | 5601          |
| Qdrant         | Vector similarity search             | 6333, 6334    |
| MinIO          | S3-compatible object storage         | 9000, 9001    |
| RabbitMQ       | Message broker                       | 5672, 15672   |
| Vault          | Secrets management (dev mode)        | 8200          |
| Prometheus     | Metrics collection                   | 9090          |
| Grafana        | Dashboards & observability           | 3000          |

---

## 📦 Setup Instructions

1. **Clone the Repository**

   ```bash
   git clone https://github.com/Arunava-27/aether.git
   cd aether
   ```

2. **Create `.env` File**

   Copy and edit the `.env` file:

   ```env
   # .env
   POSTGRES_USER=aether
   POSTGRES_DB=aether
   POSTGRES_PASSWORD=your_strong_password_here

   MINIO_ROOT_USER=minioadmin
   MINIO_ROOT_PASSWORD=minioadmin_password

   RABBITMQ_DEFAULT_USER=rabbit_user
   RABBITMQ_DEFAULT_PASS=rabbit_password

   GF_SECURITY_ADMIN_USER=admin
   GF_SECURITY_ADMIN_PASSWORD=admin
   ```

3. **Ensure Required Files Are Present**

   - `docker-compose.yml` (your stack config)
   - `prometheus.yml` (basic scrape config for Prometheus)
     ```yaml
     global:
       scrape_interval: 15s

     scrape_configs:
       - job_name: "prometheus"
         static_configs:
           - targets: ["localhost:9090"]
     ```

4. **Run the Stack**

   ```bash
   docker compose up -d
   ```

5. **Check Health of Services**

   ```bash
   docker ps
   docker inspect --format='{{json .State.Health}}' prometheus
   ```

---

## 🔐 Default Logins

| Service    | Username   | Password (from `.env`)    |
|------------|------------|---------------------------|
| Grafana    | admin      | admin                     |
| RabbitMQ   | rabbit_user| rabbit_password           |
| MinIO      | minioadmin | minioadmin_password       |
| Vault      | root token | `root` (dev mode only)    |

---

## 📋 Notes

- This Compose file uses **named Docker volumes** for persistence.
- A **custom Docker bridge network** (`aether_net`) is defined for service isolation.
- Vault is in **dev mode**. Don't use this setup for production!
- Healthchecks and `depends_on: condition: service_healthy` ensure proper startup order.
- Make sure `.env` is excluded from Git with `.gitignore`.

---

## 🛜 Check Services can Reach Each Other

```bash
docker run -it --rm --network aether_net alpine sh
```
- use this command to enter a temporary container on the same network to test connectivity between services.
```bash
apk add --no-cache netcat-openbsd
```
- use this command to install `nc` (netcat) in the temporary container for connectivity tests.
```bash
./check_services.sh
```
- run the script to see the status of all services in the stack in another container on the same network.