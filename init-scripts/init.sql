-- Script de inicialización para PostgreSQL
-- Este archivo se ejecuta automáticamente al crear la base de datos

-- Crear extensiones necesarias
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Configurar timezone
SET timezone = 'America/Santiago';

-- Crear tabla de logs personalizada (opcional)
CREATE TABLE IF NOT EXISTS custom_logs (
    id SERIAL PRIMARY KEY,
    timestamp TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    level VARCHAR(10),
    message TEXT,
    metadata JSONB
);

-- Índices para mejor rendimiento
CREATE INDEX IF NOT EXISTS idx_custom_logs_timestamp ON custom_logs(timestamp);
CREATE INDEX IF NOT EXISTS idx_custom_logs_level ON custom_logs(level);

-- Comentario
COMMENT ON TABLE custom_logs IS 'Tabla personalizada para logs de n8n automation';