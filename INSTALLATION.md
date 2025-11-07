# 📋 Guia de Instalação - KLineChart Pro

## 🚀 Servidor Já Está Rodando!

O servidor de documentação do KLineChart Pro está **ATIVO** e pronto para uso!

### 🌐 Endereços de Acesso

- **Local**: http://localhost:5173/
- **Rede**: http://21.0.0.182:5173/

---

## 📦 Sobre o Projeto

**KLineChart Pro** é uma biblioteca de gráficos financeiros construída sobre o KLineChart, oferecendo:

- 📊 Gráficos de candles profissionais
- 💹 Indicadores técnicos integrados
- 🎨 Temas personalizáveis
- 🌍 Suporte multi-idioma (i18n)
- 📱 Responsivo e otimizado

---

## 🛠️ Tecnologias Utilizadas

- **Node.js** - Runtime JavaScript
- **TypeScript** - Linguagem tipada
- **Vite** - Build tool e dev server
- **VitePress** - Gerador de documentação
- **Solid.js** - Framework reativo
- **KLineChart** - Biblioteca base de gráficos

---

## 💻 Comandos Disponíveis

### Iniciar Servidor de Documentação
```bash
# Método 1: Usando o script personalizado
./start-server.sh

# Método 2: Usando npm diretamente
npm run docs:dev -- --host 0.0.0.0
```

### Construir Biblioteca
```bash
# Build completo (core + types)
npm run build

# Build apenas core
npm run build-core

# Gerar tipos TypeScript
npm run build-dts
```

### Documentação
```bash
# Desenvolvimento
npm run docs:dev

# Build para produção
npm run docs:build

# Preview da build
npm run docs:preview

# Deploy (GitHub Pages)
npm run docs:deploy
```

---

## 🔄 Reiniciar o Servidor

Se precisar reiniciar o servidor:

```bash
# 1. Parar o servidor (Ctrl+C ou kill o processo)
pkill -f "vitepress dev"

# 2. Iniciar novamente
./start-server.sh
```

---

## 📁 Estrutura do Projeto

```
BABYSIX/
├── src/              # Código fonte da biblioteca
├── docs/             # Documentação (VitePress)
│   ├── .vitepress/   # Configuração do VitePress
│   ├── en-US/        # Docs em inglês
│   └── *.md          # Páginas de documentação
├── dist/             # Build de produção
├── package.json      # Dependências e scripts
├── vite.config.ts    # Configuração do Vite
└── start-server.sh   # Script de inicialização

```

---

## 🐛 Resolução de Problemas

### Porta 5173 já em uso
```bash
# Encontrar processo usando a porta
lsof -i :5173

# Matar processo
kill -9 <PID>
```

### Reinstalar dependências
```bash
rm -rf node_modules package-lock.json
npm install
```

### Limpar cache do Vite
```bash
rm -rf node_modules/.vite
```

---

## 📚 Links Úteis

- **Documentação Oficial**: https://pro.klinecharts.com
- **GitHub**: https://github.com/klinecharts/pro
- **KLineChart**: https://klinecharts.com

---

## ✅ Status da Instalação

- ✅ Dependências instaladas (590 packages)
- ✅ Servidor de documentação rodando
- ✅ Acessível na rede local
- ✅ Pronto para desenvolvimento

---

**Data da Instalação**: 2025-11-07
**Versão**: 0.1.1
**Node.js**: $(node -v)
**NPM**: $(npm -v)
