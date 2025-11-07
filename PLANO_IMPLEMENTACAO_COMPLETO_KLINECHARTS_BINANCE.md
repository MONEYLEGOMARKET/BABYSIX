# 🚀 PLANO DE IMPLEMENTAÇÃO COMPLETO E PROFISSIONAL
## KLineCharts Pro + Binance API + Deploy Vercel

**Versão:** 2.0 - Detalhada e Profissional  
**Data:** Novembro 2025  
**Autor:** Especialista KLineCharts  
**Objetivo:** Implementar gráfico profissional de trading com Binance + Dark Mode + Deploy Gratuito

---

## 📋 ÍNDICE

1. [Visão Geral do Projeto](#visão-geral)
2. [Arquitetura e Estrutura](#arquitetura)
3. [Pré-requisitos e Setup](#pré-requisitos)
4. [Implementação Passo a Passo](#implementação)
5. [Código Fonte Completo](#código-fonte)
6. [Configuração e Deploy](#deploy)
7. [Testes e Verificação](#testes)
8. [Troubleshooting](#troubleshooting)
9. [Checklist Final](#checklist)

---

## 🎯 VISÃO GERAL DO PROJETO {#visão-geral}

### O Que Vamos Construir

Um dashboard profissional de trading de criptomoedas com:

✅ **Gráficos de Candlestick** em tempo real da Binance  
✅ **20 Principais Pares** de trading (BTC, ETH, BNB, etc)  
✅ **Indicadores Técnicos** (MA5/10/30/60, MACD, Volume)  
✅ **Dark/Light Mode** com persistência  
✅ **Deploy Gratuito** na Vercel  
✅ **Zero Custo** de hospedagem  
✅ **Performance Otimizada** com WebSocket  
✅ **Interface Profissional** idêntica à imagem fornecida

### Tecnologias Utilizadas

| Tecnologia | Versão | Propósito |
|------------|--------|-----------|
| KLineCharts | 10.x | Biblioteca de gráficos |
| Solid.js | 1.8+ | Framework reativo |
| TypeScript | 5.2+ | Tipagem estática |
| Vite | 5.0+ | Build tool |
| Binance API | v3 | Dados de mercado |
| Vercel | Latest | Hospedagem gratuita |

### Tempo Estimado

- **Setup Inicial:** 20 minutos
- **Implementação:** 90 minutos
- **Deploy:** 15 minutos
- **Testes:** 15 minutos
- **TOTAL:** ~2.5 horas

---

## 🏗️ ARQUITETURA E ESTRUTURA {#arquitetura}

### Estrutura Final do Projeto

```
klinecharts-binance/
├── public/
│   └── favicon.ico
├── src/
│   ├── types/
│   │   └── binance.types.ts          # Tipos TypeScript
│   ├── services/
│   │   ├── BinanceService.ts          # Serviço principal Binance
│   │   └── WebSocketManager.ts        # Gerenciador WebSocket
│   ├── config/
│   │   ├── tradingPairs.ts            # 20 pares de trading
│   │   └── chartConfig.ts             # Configuração do chart
│   ├── components/
│   │   ├── TradingChart.tsx           # Componente principal
│   │   ├── ThemeToggle.tsx            # Botão dark mode
│   │   └── SymbolSelector.tsx         # Seletor de símbolos
│   ├── styles/
│   │   ├── themes/
│   │   │   ├── light.ts               # Tema claro
│   │   │   └── dark.ts                # Tema escuro
│   │   └── globals.css                # Estilos globais
│   ├── App.tsx                         # App principal
│   ├── index.tsx                       # Entry point
│   └── index.css                       # CSS base
├── .env.example                        # Exemplo de variáveis
├── .gitignore                          # Git ignore
├── index.html                          # HTML template
├── package.json                        # Dependencies
├── tsconfig.json                       # TypeScript config
├── vite.config.ts                      # Vite config
├── vercel.json                         # Vercel config
└── README.md                           # Documentação
```

### Fluxo de Dados

```
┌─────────────┐
│   Binance   │
│   REST API  │
└──────┬──────┘
       │
       │ Historical Data
       ▼
┌─────────────────┐
│ BinanceService  │◄────┐
└────────┬────────┘     │
         │              │
         │ Format Data  │ Real-time Updates
         ▼              │
┌─────────────────┐     │
│  KLineCharts   │      │
└────────┬────────┘     │
         │              │
         │ Display      │
         ▼              │
┌─────────────────┐     │
│   User View     │     │
└─────────────────┘     │
                        │
┌─────────────────┐     │
│    Binance      │─────┘
│   WebSocket     │
└─────────────────┘
```

---

## 🛠️ PRÉ-REQUISITOS E SETUP {#pré-requisitos}

### 1. Instalação de Ferramentas

```bash
# Verificar Node.js (requer 16+)
node --version  # deve ser >= v16.0.0

# Verificar npm
npm --version   # deve ser >= 8.0.0

# Instalar Git (se não tiver)
git --version

# Criar conta GitHub (se não tiver)
# https://github.com/signup

# Criar conta Vercel (se não tiver)
# https://vercel.com/signup
```

### 2. Preparação do Ambiente

```bash
# Criar diretório do projeto
mkdir klinecharts-binance
cd klinecharts-binance

# Verificar conectividade com Binance
curl -I https://api.binance.com/api/v3/ping
# Deve retornar: HTTP/2 200
```

### 3. Informações da Binance

**Base URLs:**
- REST API: `https://api.binance.com`
- WebSocket: `wss://stream.binance.com:9443/ws`

**Rate Limits:**
- Weight: 6,000 por minuto
- Raw Requests: 1,200 por minuto
- WebSocket: Sem limite (preferido)

**Documentação:**
- API Docs: https://binance-docs.github.io/apidocs/spot/en/

---

## 🔨 IMPLEMENTAÇÃO PASSO A PASSO {#implementação}

### FASE 1: SETUP DO PROJETO (20 minutos)

#### Passo 1.1: Criar Projeto Vite

```bash
# Criar projeto com template Solid + TypeScript
npm create vite@latest klinecharts-binance -- --template solid-ts

# Entrar no diretório
cd klinecharts-binance

# Instalar dependências base
npm install

# Testar se funciona
npm run dev
# Deve abrir em http://localhost:5173
```

#### Passo 1.2: Instalar KLineCharts

```bash
# Instalar KLineCharts (versão 10.x)
npm install klinecharts@latest

# Verificar versão instalada
npm list klinecharts
# Deve mostrar klinecharts@10.x.x
```

#### Passo 1.3: Configurar TypeScript

Criar/editar `tsconfig.json`:

```json
{
  "compilerOptions": {
    "target": "ES2020",
    "useDefineForClassFields": true,
    "module": "ESNext",
    "lib": ["ES2020", "DOM", "DOM.Iterable"],
    "skipLibCheck": true,
    
    /* Bundler mode */
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "preserve",
    "jsxImportSource": "solid-js",
    
    /* Linting */
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noFallthroughCasesInSwitch": true,
    
    /* Path mapping */
    "baseUrl": ".",
    "paths": {
      "@/*": ["./src/*"],
      "@/types/*": ["./src/types/*"],
      "@/services/*": ["./src/services/*"],
      "@/config/*": ["./src/config/*"],
      "@/components/*": ["./src/components/*"],
      "@/styles/*": ["./src/styles/*"]
    }
  },
  "include": ["src"],
  "references": [{ "path": "./tsconfig.node.json" }]
}
```

#### Passo 1.4: Configurar Vite

Editar `vite.config.ts`:

```typescript
import { defineConfig } from 'vite'
import solidPlugin from 'vite-plugin-solid'
import path from 'path'

export default defineConfig({
  plugins: [solidPlugin()],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
      '@/types': path.resolve(__dirname, './src/types'),
      '@/services': path.resolve(__dirname, './src/services'),
      '@/config': path.resolve(__dirname, './src/config'),
      '@/components': path.resolve(__dirname, './src/components'),
      '@/styles': path.resolve(__dirname, './src/styles')
    }
  },
  server: {
    port: 5173,
    host: true
  },
  build: {
    target: 'esnext',
    outDir: 'dist',
    assetsDir: 'assets',
    sourcemap: false,
    minify: 'terser',
    terserOptions: {
      compress: {
        drop_console: true,
        drop_debugger: true
      }
    }
  }
})
```

#### Passo 1.5: Criar Estrutura de Pastas

```bash
# Criar todas as pastas necessárias
mkdir -p src/types
mkdir -p src/services
mkdir -p src/config
mkdir -p src/components
mkdir -p src/styles/themes
```

#### Passo 1.6: Configurar Git

```bash
# Inicializar repositório
git init

# Criar .gitignore
cat > .gitignore << 'EOF'
# Dependencies
node_modules
.pnpm-store

# Build outputs
dist
dist-ssr
*.local

# Editor directories and files
.vscode/*
!.vscode/extensions.json
.idea
.DS_Store
*.suo
*.ntvs*
*.njsproj
*.sln
*.sw?

# Environment variables
.env
.env.local
.env.production

# Vercel
.vercel

# Logs
logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
pnpm-debug.log*
lerna-debug.log*

# OS
Thumbs.db
EOF

# Primeiro commit
git add .
git commit -m "Initial project setup"
```

---

### FASE 2: CONFIGURAÇÃO DOS DADOS (30 minutos)

#### Passo 2.1: Definir Tipos TypeScript

Criar `src/types/binance.types.ts`:

```typescript
/**
 * Tipos para integração com Binance API
 */

// Estrutura de dados do KLineCharts
export interface KLineData {
  timestamp: number
  open: number
  high: number
  low: number
  close: number
  volume: number
  turnover?: number
}

// Informação do símbolo/par de trading
export interface SymbolInfo {
  ticker: string        // Ex: 'BTCUSDT'
  name: string         // Ex: 'Bitcoin'
  shortName: string    // Ex: 'BTC'
  exchange: string     // 'BINANCE'
  market: string       // 'crypto'
  priceCurrency: string // 'USDT'
  type: string         // 'crypto'
}

// Período do gráfico
export interface Period {
  multiplier: number   // Ex: 1, 5, 15, 30
  timespan: 'minute' | 'hour' | 'day' | 'week' | 'month'
  text: string        // Ex: '15m', '1h', '1D'
}

// Resposta da API Binance (Kline/Candlestick)
export type BinanceKline = [
  number,    // 0: Open time
  string,    // 1: Open
  string,    // 2: High
  string,    // 3: Low
  string,    // 4: Close
  string,    // 5: Volume
  number,    // 6: Close time
  string,    // 7: Quote asset volume
  number,    // 8: Number of trades
  string,    // 9: Taker buy base asset volume
  string,    // 10: Taker buy quote asset volume
  string     // 11: Ignore
]

// WebSocket Kline message
export interface BinanceWebSocketKline {
  e: string  // Event type
  E: number  // Event time
  s: string  // Symbol
  k: {
    t: number   // Kline start time
    T: number   // Kline close time
    s: string   // Symbol
    i: string   // Interval
    f: number   // First trade ID
    L: number   // Last trade ID
    o: string   // Open price
    c: string   // Close price
    h: string   // High price
    l: string   // Low price
    v: string   // Base asset volume
    n: number   // Number of trades
    x: boolean  // Is this kline closed?
    q: string   // Quote asset volume
    V: string   // Taker buy base asset volume
    Q: string   // Taker buy quote asset volume
    B: string   // Ignore
  }
}

// Configuração de par de trading
export interface TradingPair {
  symbol: string
  name: string
  shortName: string
}

// Intervalo da Binance
export type BinanceInterval = 
  | '1m' | '3m' | '5m' | '15m' | '30m'
  | '1h' | '2h' | '4h' | '6h' | '8h' | '12h'
  | '1d' | '3d' | '1w' | '1M'

// Tema do gráfico
export type ChartTheme = 'light' | 'dark'

// DataLoader callback
export interface DataLoaderCallback {
  (data: KLineData[], noMore?: boolean): void
}

// Parâmetros do DataLoader
export interface DataLoaderParams {
  callback: DataLoaderCallback
  symbol?: SymbolInfo
  period?: Period
  from?: number
  to?: number
}
```

#### Passo 2.2: Configurar Pares de Trading

Criar `src/config/tradingPairs.ts`:

```typescript
import type { TradingPair } from '@/types/binance.types'

/**
 * 20 Principais Pares de Trading da Binance
 * Ordenados por volume de negociação (24h)
 * Atualizado: Novembro 2025
 */
export const TOP_20_TRADING_PAIRS: TradingPair[] = [
  {
    symbol: 'BTCUSDT',
    name: 'Bitcoin',
    shortName: 'BTC'
  },
  {
    symbol: 'ETHUSDT',
    name: 'Ethereum',
    shortName: 'ETH'
  },
  {
    symbol: 'BNBUSDT',
    name: 'BNB',
    shortName: 'BNB'
  },
  {
    symbol: 'SOLUSDT',
    name: 'Solana',
    shortName: 'SOL'
  },
  {
    symbol: 'XRPUSDT',
    name: 'Ripple',
    shortName: 'XRP'
  },
  {
    symbol: 'DOGEUSDT',
    name: 'Dogecoin',
    shortName: 'DOGE'
  },
  {
    symbol: 'ADAUSDT',
    name: 'Cardano',
    shortName: 'ADA'
  },
  {
    symbol: 'LINKUSDT',
    name: 'Chainlink',
    shortName: 'LINK'
  },
  {
    symbol: 'MATICUSDT',
    name: 'Polygon',
    shortName: 'MATIC'
  },
  {
    symbol: 'DOTUSDT',
    name: 'Polkadot',
    shortName: 'DOT'
  },
  {
    symbol: 'UNIUSDT',
    name: 'Uniswap',
    shortName: 'UNI'
  },
  {
    symbol: 'AVAXUSDT',
    name: 'Avalanche',
    shortName: 'AVAX'
  },
  {
    symbol: 'SHIBUSDT',
    name: 'Shiba Inu',
    shortName: 'SHIB'
  },
  {
    symbol: 'LTCUSDT',
    name: 'Litecoin',
    shortName: 'LTC'
  },
  {
    symbol: 'TRXUSDT',
    name: 'Tron',
    shortName: 'TRX'
  },
  {
    symbol: 'ATOMUSDT',
    name: 'Cosmos',
    shortName: 'ATOM'
  },
  {
    symbol: 'ARBUSDT',
    name: 'Arbitrum',
    shortName: 'ARB'
  },
  {
    symbol: 'ETCUSDT',
    name: 'Ethereum Classic',
    shortName: 'ETC'
  },
  {
    symbol: 'APTUSDT',
    name: 'Aptos',
    shortName: 'APT'
  },
  {
    symbol: 'NEARUSDT',
    name: 'NEAR Protocol',
    shortName: 'NEAR'
  }
]

/**
 * Converte TradingPair para SymbolInfo
 */
export function tradingPairToSymbolInfo(pair: TradingPair) {
  return {
    ticker: pair.symbol,
    name: pair.name,
    shortName: pair.shortName,
    exchange: 'BINANCE',
    market: 'crypto',
    priceCurrency: 'USDT',
    type: 'crypto'
  }
}

/**
 * Busca um par pelo símbolo
 */
export function findTradingPair(symbol: string): TradingPair | undefined {
  return TOP_20_TRADING_PAIRS.find(
    pair => pair.symbol.toLowerCase() === symbol.toLowerCase()
  )
}

/**
 * Lista todos os símbolos disponíveis
 */
export function getAllSymbols(): string[] {
  return TOP_20_TRADING_PAIRS.map(pair => pair.symbol)
}
```

#### Passo 2.3: Configuração do Chart

Criar `src/config/chartConfig.ts`:

```typescript
import type { Period } from '@/types/binance.types'

/**
 * Períodos disponíveis no gráfico
 */
export const CHART_PERIODS: Period[] = [
  { multiplier: 1, timespan: 'minute', text: '1m' },
  { multiplier: 3, timespan: 'minute', text: '3m' },
  { multiplier: 5, timespan: 'minute', text: '5m' },
  { multiplier: 15, timespan: 'minute', text: '15m' },
  { multiplier: 30, timespan: 'minute', text: '30m' },
  { multiplier: 1, timespan: 'hour', text: '1h' },
  { multiplier: 2, timespan: 'hour', text: '2h' },
  { multiplier: 4, timespan: 'hour', text: '4h' },
  { multiplier: 6, timespan: 'hour', text: '6h' },
  { multiplier: 12, timespan: 'hour', text: '12h' },
  { multiplier: 1, timespan: 'day', text: '1D' },
  { multiplier: 3, timespan: 'day', text: '3D' },
  { multiplier: 1, timespan: 'week', text: '1W' },
  { multiplier: 1, timespan: 'month', text: '1M' }
]

/**
 * Período padrão inicial
 */
export const DEFAULT_PERIOD: Period = {
  multiplier: 15,
  timespan: 'minute',
  text: '15m'
}

/**
 * Indicadores principais (overlay no candle)
 */
export const MAIN_INDICATORS = ['MA']

/**
 * Parâmetros do MA
 */
export const MA_PARAMS = [5, 10, 30, 60]

/**
 * Indicadores secundários (painéis separados)
 */
export const SUB_INDICATORS = ['VOL', 'MACD']

/**
 * Limite de dados históricos (número de candles)
 */
export const MAX_DATA_POINTS = 1000

/**
 * Timeout para requisições HTTP (ms)
 */
export const HTTP_TIMEOUT = 10000

/**
 * Intervalo de reconexão WebSocket (ms)
 */
export const WS_RECONNECT_INTERVAL = 5000

/**
 * Timezone padrão
 */
export const DEFAULT_TIMEZONE = 'America/Sao_Paulo'

/**
 * Locale padrão
 */
export const DEFAULT_LOCALE = 'pt-BR'
```

---

### FASE 3: SERVIÇOS BINANCE (40 minutos)

#### Passo 3.1: Gerenciador WebSocket

Criar `src/services/WebSocketManager.ts`:

```typescript
import type { BinanceWebSocketKline, KLineData } from '@/types/binance.types'

/**
 * Gerenciador de conexões WebSocket da Binance
 * Responsável por gerenciar múltiplas conexões e reconexões automáticas
 */
export class WebSocketManager {
  private connections: Map<string, WebSocket> = new Map()
  private reconnectTimeouts: Map<string, number> = new Map()
  private readonly RECONNECT_DELAY = 5000
  private readonly MAX_RECONNECT_ATTEMPTS = 10

  /**
   * Conecta a um stream de kline
   */
  connect(
    symbol: string,
    interval: string,
    onMessage: (data: KLineData) => void,
    onError?: (error: Event) => void
  ): void {
    const key = `${symbol}_${interval}`
    
    // Fechar conexão existente se houver
    this.disconnect(key)

    // Construir URL do WebSocket
    const wsUrl = this.buildWebSocketUrl(symbol, interval)
    
    try {
      const ws = new WebSocket(wsUrl)
      
      ws.onopen = () => {
        console.log(`[WebSocket] Conectado: ${key}`)
        this.clearReconnectTimeout(key)
      }
      
      ws.onmessage = (event) => {
        try {
          const data: BinanceWebSocketKline = JSON.parse(event.data)
          const kline = this.parseWebSocketKline(data)
          onMessage(kline)
        } catch (error) {
          console.error('[WebSocket] Erro ao parsear mensagem:', error)
        }
      }
      
      ws.onerror = (error) => {
        console.error(`[WebSocket] Erro: ${key}`, error)
        if (onError) onError(error)
      }
      
      ws.onclose = () => {
        console.log(`[WebSocket] Desconectado: ${key}`)
        this.connections.delete(key)
        this.scheduleReconnect(key, symbol, interval, onMessage, onError)
      }
      
      this.connections.set(key, ws)
    } catch (error) {
      console.error(`[WebSocket] Erro ao conectar: ${key}`, error)
      this.scheduleReconnect(key, symbol, interval, onMessage, onError)
    }
  }

  /**
   * Desconecta um stream específico
   */
  disconnect(key: string): void {
    const ws = this.connections.get(key)
    if (ws) {
      if (ws.readyState === WebSocket.OPEN) {
        ws.close()
      }
      this.connections.delete(key)
    }
    this.clearReconnectTimeout(key)
  }

  /**
   * Desconecta todos os streams
   */
  disconnectAll(): void {
    this.connections.forEach((ws, key) => {
      this.disconnect(key)
    })
    this.connections.clear()
    this.reconnectTimeouts.forEach(timeout => clearTimeout(timeout))
    this.reconnectTimeouts.clear()
  }

  /**
   * Constrói URL do WebSocket
   */
  private buildWebSocketUrl(symbol: string, interval: string): string {
    const baseUrl = 'wss://stream.binance.com:9443/ws'
    const stream = `${symbol.toLowerCase()}@kline_${interval}`
    return `${baseUrl}/${stream}`
  }

  /**
   * Parseia mensagem do WebSocket para formato KLineData
   */
  private parseWebSocketKline(data: BinanceWebSocketKline): KLineData {
    const k = data.k
    return {
      timestamp: k.t,
      open: parseFloat(k.o),
      high: parseFloat(k.h),
      low: parseFloat(k.l),
      close: parseFloat(k.c),
      volume: parseFloat(k.v),
      turnover: parseFloat(k.q)
    }
  }

  /**
   * Agenda reconexão automática
   */
  private scheduleReconnect(
    key: string,
    symbol: string,
    interval: string,
    onMessage: (data: KLineData) => void,
    onError?: (error: Event) => void
  ): void {
    this.clearReconnectTimeout(key)
    
    const timeout = window.setTimeout(() => {
      console.log(`[WebSocket] Tentando reconectar: ${key}`)
      this.connect(symbol, interval, onMessage, onError)
    }, this.RECONNECT_DELAY)
    
    this.reconnectTimeouts.set(key, timeout)
  }

  /**
   * Limpa timeout de reconexão
   */
  private clearReconnectTimeout(key: string): void {
    const timeout = this.reconnectTimeouts.get(key)
    if (timeout) {
      clearTimeout(timeout)
      this.reconnectTimeouts.delete(key)
    }
  }

  /**
   * Verifica se está conectado
   */
  isConnected(symbol: string, interval: string): boolean {
    const key = `${symbol}_${interval}`
    const ws = this.connections.get(key)
    return ws !== undefined && ws.readyState === WebSocket.OPEN
  }

  /**
   * Obtém status de todas as conexões
   */
  getConnectionsStatus(): Record<string, boolean> {
    const status: Record<string, boolean> = {}
    this.connections.forEach((ws, key) => {
      status[key] = ws.readyState === WebSocket.OPEN
    })
    return status
  }
}
```

#### Passo 3.2: Serviço Principal Binance

Criar `src/services/BinanceService.ts`:

```typescript
import type {
  KLineData,
  SymbolInfo,
  Period,
  BinanceKline,
  BinanceInterval,
  DataLoaderParams
} from '@/types/binance.types'
import { WebSocketManager } from './WebSocketManager'

/**
 * Serviço de integração com Binance API
 * Gerencia dados históricos (REST) e atualizações em tempo real (WebSocket)
 */
export class BinanceService {
  private readonly BASE_URL = 'https://api.binance.com'
  private wsManager: WebSocketManager
  private currentSymbol: string | null = null
  private currentInterval: string | null = null
  private updateCallback: ((data: KLineData) => void) | null = null

  constructor() {
    this.wsManager = new WebSocketManager()
  }

  /**
   * Busca dados históricos (REST API)
   */
  async getHistoricalData(
    symbol: string,
    interval: BinanceInterval,
    limit: number = 500,
    startTime?: number,
    endTime?: number
  ): Promise<KLineData[]> {
    try {
      // Construir URL
      const url = new URL(`${this.BASE_URL}/api/v3/klines`)
      url.searchParams.append('symbol', symbol)
      url.searchParams.append('interval', interval)
      url.searchParams.append('limit', Math.min(limit, 1000).toString())
      
      if (startTime) {
        url.searchParams.append('startTime', startTime.toString())
      }
      if (endTime) {
        url.searchParams.append('endTime', endTime.toString())
      }

      console.log('[Binance] Buscando dados históricos:', symbol, interval)

      // Fazer requisição
      const response = await fetch(url.toString(), {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json'
        }
      })

      if (!response.ok) {
        throw new Error(`Erro HTTP: ${response.status} ${response.statusText}`)
      }

      const data: BinanceKline[] = await response.json()
      
      // Converter para formato KLineData
      const klineData = data.map(this.parseBinanceKline)
      
      console.log(`[Binance] Recebidos ${klineData.length} candles`)
      
      return klineData
    } catch (error) {
      console.error('[Binance] Erro ao buscar dados históricos:', error)
      throw error
    }
  }

  /**
   * Inicia streaming em tempo real
   */
  startRealTimeUpdates(
    symbol: string,
    interval: BinanceInterval,
    onUpdate: (data: KLineData) => void
  ): void {
    console.log('[Binance] Iniciando updates em tempo real:', symbol, interval)
    
    // Parar stream anterior se existir
    this.stopRealTimeUpdates()
    
    // Guardar informações atuais
    this.currentSymbol = symbol
    this.currentInterval = interval
    this.updateCallback = onUpdate
    
    // Conectar WebSocket
    this.wsManager.connect(
      symbol,
      interval,
      onUpdate,
      (error) => {
        console.error('[Binance] Erro no WebSocket:', error)
      }
    )
  }

  /**
   * Para streaming em tempo real
   */
  stopRealTimeUpdates(): void {
    if (this.currentSymbol && this.currentInterval) {
      const key = `${this.currentSymbol}_${this.currentInterval}`
      this.wsManager.disconnect(key)
      console.log('[Binance] Updates em tempo real parados')
    }
    this.currentSymbol = null
    this.currentInterval = null
    this.updateCallback = null
  }

  /**
   * Limpa todos os recursos
   */
  cleanup(): void {
    this.wsManager.disconnectAll()
    this.currentSymbol = null
    this.currentInterval = null
    this.updateCallback = null
  }

  /**
   * Converte Period para intervalo da Binance
   */
  periodToInterval(period: Period): BinanceInterval {
    const map: Record<string, string> = {
      'second': 's',
      'minute': 'm',
      'hour': 'h',
      'day': 'd',
      'week': 'w',
      'month': 'M'
    }
    
    const timeUnit = map[period.timespan]
    if (!timeUnit) {
      throw new Error(`Timespan inválido: ${period.timespan}`)
    }
    
    return `${period.multiplier}${timeUnit}` as BinanceInterval
  }

  /**
   * Parseia dados da Binance para formato KLineData
   */
  private parseBinanceKline(kline: BinanceKline): KLineData {
    return {
      timestamp: kline[0],
      open: parseFloat(kline[1]),
      high: parseFloat(kline[2]),
      low: parseFloat(kline[3]),
      close: parseFloat(kline[4]),
      volume: parseFloat(kline[5]),
      turnover: parseFloat(kline[7])
    }
  }

  /**
   * Cria DataLoader para KLineCharts
   */
  createDataLoader(
    symbol: SymbolInfo,
    period: Period
  ) {
    return {
      getBars: async ({ callback }: DataLoaderParams) => {
        try {
          // Converter período
          const interval = this.periodToInterval(period)
          
          // Buscar dados históricos
          const data = await this.getHistoricalData(
            symbol.ticker,
            interval,
            500
          )
          
          // Retornar via callback
          callback(data)
          
          // Iniciar updates em tempo real
          this.startRealTimeUpdates(
            symbol.ticker,
            interval,
            (newData) => {
              // Atualizar último candle
              callback([newData])
            }
          )
        } catch (error) {
          console.error('[Binance] Erro no DataLoader:', error)
          callback([])
        }
      }
    }
  }

  /**
   * Verifica se está recebendo updates
   */
  isConnected(): boolean {
    if (!this.currentSymbol || !this.currentInterval) {
      return false
    }
    return this.wsManager.isConnected(this.currentSymbol, this.currentInterval)
  }

  /**
   * Obtém status da conexão
   */
  getConnectionStatus(): {
    connected: boolean
    symbol: string | null
    interval: string | null
  } {
    return {
      connected: this.isConnected(),
      symbol: this.currentSymbol,
      interval: this.currentInterval
    }
  }
}

// Exportar instância singleton
export const binanceService = new BinanceService()
```

---

### FASE 4: TEMAS E ESTILOS (20 minutos)

#### Passo 4.1: Tema Claro

Criar `src/styles/themes/light.ts`:

```typescript
/**
 * Tema Claro - Light Theme
 * Baseado no design padrão do KLineCharts
 */
export const lightTheme = {
  grid: {
    show: true,
    horizontal: {
      show: true,
      size: 1,
      color: '#EDEDED',
      style: 'dashed' as const,
      dashedValue: [2, 2]
    },
    vertical: {
      show: true,
      size: 1,
      color: '#EDEDED',
      style: 'dashed' as const,
      dashedValue: [2, 2]
    }
  },
  candle: {
    type: 'candle_solid' as const,
    bar: {
      upColor: '#26A69A',
      downColor: '#EF5350',
      noChangeColor: '#888888',
      upBorderColor: '#26A69A',
      downBorderColor: '#EF5350',
      noChangeBorderColor: '#888888',
      upWickColor: '#26A69A',
      downWickColor: '#EF5350',
      noChangeWickColor: '#888888'
    },
    tooltip: {
      offsetLeft: 8,
      offsetTop: 8,
      offsetRight: 8,
      offsetBottom: 8,
      showRule: 'always' as const,
      showType: 'standard' as const,
      legend: {
        size: 12,
        family: 'Helvetica Neue, Arial, sans-serif',
        weight: 'normal',
        color: '#76808F',
        marginLeft: 8,
        marginTop: 6,
        marginRight: 8,
        marginBottom: 6,
        defaultValue: 'n/a'
      }
    },
    priceMark: {
      show: true,
      last: {
        show: true,
        upColor: '#26A69A',
        downColor: '#EF5350',
        noChangeColor: '#888888',
        line: {
          show: true,
          style: 'dashed' as const,
          dashedValue: [4, 4],
          size: 1
        },
        text: {
          show: true,
          style: 'fill' as const,
          size: 12,
          paddingLeft: 4,
          paddingTop: 4,
          paddingRight: 4,
          paddingBottom: 4,
          color: '#FFFFFF',
          family: 'Helvetica Neue, Arial, sans-serif',
          weight: 'normal',
          borderRadius: 2
        }
      }
    }
  },
  indicator: {
    ohlc: {
      upColor: 'rgba(38, 166, 154, 0.7)',
      downColor: 'rgba(239, 83, 80, 0.7)',
      noChangeColor: '#888888'
    },
    bars: [{
      style: 'fill' as const,
      upColor: 'rgba(38, 166, 154, 0.7)',
      downColor: 'rgba(239, 83, 80, 0.7)',
      noChangeColor: '#888888'
    }],
    lines: [
      { style: 'solid' as const, smooth: false, size: 1, color: '#FF9600' },
      { style: 'solid' as const, smooth: false, size: 1, color: '#9C27B0' },
      { style: 'solid' as const, smooth: false, size: 1, color: '#2196F3' },
      { style: 'solid' as const, smooth: false, size: 1, color: '#E91E63' },
      { style: 'solid' as const, smooth: false, size: 1, color: '#00BCD4' }
    ],
    tooltip: {
      offsetLeft: 8,
      offsetTop: 8,
      offsetRight: 8,
      offsetBottom: 8,
      showRule: 'always' as const,
      showType: 'standard' as const,
      legend: {
        size: 12,
        family: 'Helvetica Neue, Arial, sans-serif',
        weight: 'normal',
        color: '#76808F',
        marginLeft: 8,
        marginTop: 6,
        marginRight: 8,
        marginBottom: 6,
        defaultValue: 'n/a'
      }
    }
  },
  xAxis: {
    show: true,
    size: 'auto' as const,
    axisLine: {
      show: true,
      color: '#DDDDDD',
      size: 1
    },
    tickText: {
      show: true,
      color: '#76808F',
      family: 'Helvetica Neue, Arial, sans-serif',
      weight: 'normal',
      size: 12,
      marginStart: 4,
      marginEnd: 4
    },
    tickLine: {
      show: true,
      size: 1,
      length: 3,
      color: '#DDDDDD'
    }
  },
  yAxis: {
    show: true,
    size: 'auto' as const,
    axisLine: {
      show: true,
      color: '#DDDDDD',
      size: 1
    },
    tickText: {
      show: true,
      color: '#76808F',
      family: 'Helvetica Neue, Arial, sans-serif',
      weight: 'normal',
      size: 12,
      marginStart: 4,
      marginEnd: 4
    },
    tickLine: {
      show: true,
      size: 1,
      length: 3,
      color: '#DDDDDD'
    }
  },
  separator: {
    size: 1,
    color: '#DDDDDD',
    fill: true,
    activeBackgroundColor: 'rgba(230, 230, 230, 0.15)'
  },
  crosshair: {
    show: true,
    horizontal: {
      show: true,
      line: {
        show: true,
        style: 'dashed' as const,
        dashedValue: [4, 2],
        size: 1,
        color: '#888888'
      },
      text: {
        show: true,
        style: 'fill' as const,
        color: '#FFFFFF',
        size: 12,
        family: 'Helvetica Neue, Arial, sans-serif',
        weight: 'normal',
        borderRadius: 2,
        paddingLeft: 4,
        paddingRight: 4,
        paddingTop: 4,
        paddingBottom: 4,
        backgroundColor: '#686D76'
      }
    },
    vertical: {
      show: true,
      line: {
        show: true,
        style: 'dashed' as const,
        dashedValue: [4, 2],
        size: 1,
        color: '#888888'
      },
      text: {
        show: true,
        style: 'fill' as const,
        color: '#FFFFFF',
        size: 12,
        family: 'Helvetica Neue, Arial, sans-serif',
        weight: 'normal',
        borderRadius: 2,
        paddingLeft: 4,
        paddingRight: 4,
        paddingTop: 4,
        paddingBottom: 4,
        backgroundColor: '#686D76'
      }
    }
  }
}
```

#### Passo 4.2: Tema Escuro

Criar `src/styles/themes/dark.ts`:

```typescript
/**
 * Tema Escuro - Dark Theme
 * Otimizado para uso noturno e redução de fadiga visual
 */
export const darkTheme = {
  grid: {
    show: true,
    horizontal: {
      show: true,
      size: 1,
      color: '#292929',
      style: 'dashed' as const,
      dashedValue: [2, 2]
    },
    vertical: {
      show: true,
      size: 1,
      color: '#292929',
      style: 'dashed' as const,
      dashedValue: [2, 2]
    }
  },
  candle: {
    type: 'candle_solid' as const,
    bar: {
      upColor: '#26A69A',
      downColor: '#EF5350',
      noChangeColor: '#888888',
      upBorderColor: '#26A69A',
      downBorderColor: '#EF5350',
      noChangeBorderColor: '#888888',
      upWickColor: '#26A69A',
      downWickColor: '#EF5350',
      noChangeWickColor: '#888888'
    },
    tooltip: {
      offsetLeft: 8,
      offsetTop: 8,
      offsetRight: 8,
      offsetBottom: 8,
      showRule: 'always' as const,
      showType: 'standard' as const,
      legend: {
        size: 12,
        family: 'Helvetica Neue, Arial, sans-serif',
        weight: 'normal',
        color: '#929AA5',
        marginLeft: 8,
        marginTop: 6,
        marginRight: 8,
        marginBottom: 6,
        defaultValue: 'n/a'
      }
    },
    priceMark: {
      show: true,
      last: {
        show: true,
        upColor: '#26A69A',
        downColor: '#EF5350',
        noChangeColor: '#888888',
        line: {
          show: true,
          style: 'dashed' as const,
          dashedValue: [4, 4],
          size: 1
        },
        text: {
          show: true,
          style: 'fill' as const,
          size: 12,
          paddingLeft: 4,
          paddingTop: 4,
          paddingRight: 4,
          paddingBottom: 4,
          color: '#FFFFFF',
          family: 'Helvetica Neue, Arial, sans-serif',
          weight: 'normal',
          borderRadius: 2
        }
      }
    }
  },
  indicator: {
    ohlc: {
      upColor: 'rgba(38, 166, 154, 0.7)',
      downColor: 'rgba(239, 83, 80, 0.7)',
      noChangeColor: '#888888'
    },
    bars: [{
      style: 'fill' as const,
      upColor: 'rgba(38, 166, 154, 0.7)',
      downColor: 'rgba(239, 83, 80, 0.7)',
      noChangeColor: '#888888'
    }],
    lines: [
      { style: 'solid' as const, smooth: false, size: 1, color: '#FF9600' },
      { style: 'solid' as const, smooth: false, size: 1, color: '#9C27B0' },
      { style: 'solid' as const, smooth: false, size: 1, color: '#2196F3' },
      { style: 'solid' as const, smooth: false, size: 1, color: '#E91E63' },
      { style: 'solid' as const, smooth: false, size: 1, color: '#00BCD4' }
    ],
    tooltip: {
      offsetLeft: 8,
      offsetTop: 8,
      offsetRight: 8,
      offsetBottom: 8,
      showRule: 'always' as const,
      showType: 'standard' as const,
      legend: {
        size: 12,
        family: 'Helvetica Neue, Arial, sans-serif',
        weight: 'normal',
        color: '#929AA5',
        marginLeft: 8,
        marginTop: 6,
        marginRight: 8,
        marginBottom: 6,
        defaultValue: 'n/a'
      }
    }
  },
  xAxis: {
    show: true,
    size: 'auto' as const,
    axisLine: {
      show: true,
      color: '#333333',
      size: 1
    },
    tickText: {
      show: true,
      color: '#929AA5',
      family: 'Helvetica Neue, Arial, sans-serif',
      weight: 'normal',
      size: 12,
      marginStart: 4,
      marginEnd: 4
    },
    tickLine: {
      show: true,
      size: 1,
      length: 3,
      color: '#333333'
    }
  },
  yAxis: {
    show: true,
    size: 'auto' as const,
    axisLine: {
      show: true,
      color: '#333333',
      size: 1
    },
    tickText: {
      show: true,
      color: '#929AA5',
      family: 'Helvetica Neue, Arial, sans-serif',
      weight: 'normal',
      size: 12,
      marginStart: 4,
      marginEnd: 4
    },
    tickLine: {
      show: true,
      size: 1,
      length: 3,
      color: '#333333'
    }
  },
  separator: {
    size: 1,
    color: '#333333',
    fill: true,
    activeBackgroundColor: 'rgba(50, 50, 50, 0.15)'
  },
  crosshair: {
    show: true,
    horizontal: {
      show: true,
      line: {
        show: true,
        style: 'dashed' as const,
        dashedValue: [4, 2],
        size: 1,
        color: '#888888'
      },
      text: {
        show: true,
        style: 'fill' as const,
        color: '#FFFFFF',
        size: 12,
        family: 'Helvetica Neue, Arial, sans-serif',
        weight: 'normal',
        borderRadius: 2,
        paddingLeft: 4,
        paddingRight: 4,
        paddingTop: 4,
        paddingBottom: 4,
        backgroundColor: '#505050'
      }
    },
    vertical: {
      show: true,
      line: {
        show: true,
        style: 'dashed' as const,
        dashedValue: [4, 2],
        size: 1,
        color: '#888888'
      },
      text: {
        show: true,
        style: 'fill' as const,
        color: '#FFFFFF',
        size: 12,
        family: 'Helvetica Neue, Arial, sans-serif',
        weight: 'normal',
        borderRadius: 2,
        paddingLeft: 4,
        paddingRight: 4,
        paddingTop: 4,
        paddingBottom: 4,
        backgroundColor: '#505050'
      }
    }
  }
}
```

#### Passo 4.3: Estilos Globais

Criar `src/styles/globals.css`:

```css
/**
 * Estilos Globais da Aplicação
 */

/* Reset básico */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

/* Variáveis CSS - Light Theme */
:root {
  --bg-primary: #FFFFFF;
  --bg-secondary: #F5F5F5;
  --bg-tertiary: #FAFAFA;
  
  --text-primary: #1A1A1A;
  --text-secondary: #666666;
  --text-tertiary: #999999;
  
  --border-color: #E0E0E0;
  --border-color-hover: #BDBDBD;
  
  --primary-color: #1976D2;
  --primary-hover: #1565C0;
  
  --success-color: #26A69A;
  --error-color: #EF5350;
  
  --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.12);
  --shadow-md: 0 4px 6px rgba(0, 0, 0, 0.1);
  --shadow-lg: 0 10px 20px rgba(0, 0, 0, 0.15);
  
  --transition-fast: 150ms ease;
  --transition-medium: 250ms ease;
  --transition-slow: 350ms ease;
  
  --border-radius-sm: 4px;
  --border-radius-md: 8px;
  --border-radius-lg: 12px;
  
  --spacing-xs: 4px;
  --spacing-sm: 8px;
  --spacing-md: 16px;
  --spacing-lg: 24px;
  --spacing-xl: 32px;
  
  --font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 
                 'Helvetica Neue', Arial, sans-serif;
}

/* Dark Theme Variables */
[data-theme="dark"] {
  --bg-primary: #1A1A1A;
  --bg-secondary: #242424;
  --bg-tertiary: #2A2A2A;
  
  --text-primary: #FFFFFF;
  --text-secondary: #B0B0B0;
  --text-tertiary: #808080;
  
  --border-color: #333333;
  --border-color-hover: #444444;
  
  --primary-color: #42A5F5;
  --primary-hover: #2196F3;
  
  --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.3);
  --shadow-md: 0 4px 6px rgba(0, 0, 0, 0.4);
  --shadow-lg: 0 10px 20px rgba(0, 0, 0, 0.5);
}

/* Body */
body {
  font-family: var(--font-family);
  color: var(--text-primary);
  background-color: var(--bg-primary);
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  line-height: 1.6;
  transition: background-color var(--transition-medium),
              color var(--transition-medium);
}

/* Scrollbar customizado */
::-webkit-scrollbar {
  width: 8px;
  height: 8px;
}

::-webkit-scrollbar-track {
  background: var(--bg-secondary);
}

::-webkit-scrollbar-thumb {
  background: var(--border-color-hover);
  border-radius: 4px;
}

::-webkit-scrollbar-thumb:hover {
  background: var(--text-tertiary);
}

/* Seleção de texto */
::selection {
  background-color: var(--primary-color);
  color: white;
}

/* Links */
a {
  color: var(--primary-color);
  text-decoration: none;
  transition: color var(--transition-fast);
}

a:hover {
  color: var(--primary-hover);
}

/* Botões base */
button {
  font-family: var(--font-family);
  cursor: pointer;
  border: none;
  outline: none;
  transition: all var(--transition-fast);
}

button:disabled {
  cursor: not-allowed;
  opacity: 0.5;
}

/* Input base */
input,
select,
textarea {
  font-family: var(--font-family);
  color: var(--text-primary);
  background-color: var(--bg-secondary);
  border: 1px solid var(--border-color);
  border-radius: var(--border-radius-sm);
  padding: var(--spacing-sm) var(--spacing-md);
  transition: all var(--transition-fast);
}

input:focus,
select:focus,
textarea:focus {
  outline: none;
  border-color: var(--primary-color);
  box-shadow: 0 0 0 3px rgba(25, 118, 210, 0.1);
}

/* Utility classes */
.text-center { text-align: center; }
.text-left { text-align: left; }
.text-right { text-align: right; }

.flex { display: flex; }
.flex-col { flex-direction: column; }
.items-center { align-items: center; }
.justify-center { justify-content: center; }
.justify-between { justify-content: space-between; }

.gap-xs { gap: var(--spacing-xs); }
.gap-sm { gap: var(--spacing-sm); }
.gap-md { gap: var(--spacing-md); }
.gap-lg { gap: var(--spacing-lg); }

.p-xs { padding: var(--spacing-xs); }
.p-sm { padding: var(--spacing-sm); }
.p-md { padding: var(--spacing-md); }
.p-lg { padding: var(--spacing-lg); }

.m-xs { margin: var(--spacing-xs); }
.m-sm { margin: var(--spacing-sm); }
.m-md { margin: var(--spacing-md); }
.m-lg { margin: var(--spacing-lg); }

.rounded-sm { border-radius: var(--border-radius-sm); }
.rounded-md { border-radius: var(--border-radius-md); }
.rounded-lg { border-radius: var(--border-radius-lg); }

.shadow-sm { box-shadow: var(--shadow-sm); }
.shadow-md { box-shadow: var(--shadow-md); }
.shadow-lg { box-shadow: var(--shadow-lg); }

/* Animações */
@keyframes fadeIn {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}

@keyframes slideIn {
  from {
    transform: translateY(-10px);
    opacity: 0;
  }
  to {
    transform: translateY(0);
    opacity: 1;
  }
}

.animate-fadeIn {
  animation: fadeIn var(--transition-medium) ease-in-out;
}

.animate-slideIn {
  animation: slideIn var(--transition-medium) ease-in-out;
}
```

---

### CONTINUAÇÃO NA PRÓXIMA MENSAGEM...

Este plano está ficando muito extenso. Vou continuar na próxima parte com:
- Componentes React
- Configuração final
- Deploy
- Testes

Você quer que eu continue agora ou prefere revisar essa primeira parte? 🎯
