#!/bin/bash

# Script de inicialização do KLineChart Pro
# Este script instala dependências (se necessário) e inicia o servidor de documentação

echo "======================================"
echo "  KLineChart Pro - Servidor de Docs  "
echo "======================================"
echo ""

# Verifica se node_modules existe
if [ ! -d "node_modules" ]; then
    echo "📦 Instalando dependências..."
    npm install
    echo ""
fi

echo "🚀 Iniciando servidor de documentação..."
echo ""
echo "O servidor estará disponível em:"
echo "  Local:   http://localhost:5173/"
echo "  Rede:    http://$(hostname -I | awk '{print $1}'):5173/"
echo ""
echo "Pressione Ctrl+C para parar o servidor"
echo ""

npm run docs:dev -- --host 0.0.0.0
