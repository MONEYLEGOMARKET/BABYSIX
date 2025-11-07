#!/bin/bash

# Script de inicialização da Aplicação Demo do KLineChart Pro
# Este script inicia o servidor HTTP para a aplicação demo funcional

echo "================================================"
echo "  🚀 KLineChart Pro - Aplicação Demo Trading  "
echo "================================================"
echo ""

# Verifica se http-server está instalado
if ! command -v http-server &> /dev/null; then
    echo "📦 Instalando http-server..."
    npm install -g http-server
    echo ""
fi

# Verifica se node_modules existe
if [ ! -d "node_modules" ]; then
    echo "📦 Instalando dependências do projeto..."
    npm install
    echo ""
fi

IP=$(hostname -I | awk '{print $1}')

echo "✅ Iniciando aplicação demo..."
echo ""
echo "🌐 A aplicação estará disponível em:"
echo ""
echo "  ┌─────────────────────────────────────────────┐"
echo "  │  LOCAL:  http://localhost:8080/             │"
echo "  │  REDE:   http://$IP:8080/        │"
echo "  └─────────────────────────────────────────────┘"
echo ""
echo "📊 Recursos disponíveis:"
echo "  • Gráficos de candlestick em tempo real"
echo "  • Dados do mercado de ações (Alibaba - BABA)"
echo "  • Indicadores técnicos interativos"
echo "  • Interface profissional e responsiva"
echo ""
echo "⏹️  Pressione Ctrl+C para parar o servidor"
echo ""
echo "================================================"
echo ""

cd demo && http-server -p 8080 -a 0.0.0.0
