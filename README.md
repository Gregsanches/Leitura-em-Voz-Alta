# 🔊 Leitura em Voz Alta — Ferramenta de Acessibilidade e Revisão Textual

> Script AutoHotkey para leitura de textos selecionados pela pessoa usuária. Seu principal objetivo é auxiliar as pessoas criadoras de conteúdo de materiais destinadas ao público usuário de leitores de tela na verificação de **acessibilidade, ortografia e qualidade da escrita do conteúdo**.

---

## 📌 Para que serve?

Esta ferramenta foi criada para apoiar quem produz conteúdo digital com preocupação real com **acessibilidade**. Com ela, você pode:

- **Verificar textos alternativos (alt text)** de imagens — ouvindo como o leitor de tela vai interpretá-los
- **Ouvir seus textos** para identificar erros ortográficos e gramaticais que os olhos deixam passar
- **Testar textos invisíveis** (como `aria-label`), títulos ocultos e descrições complementares 
- **Fazer uma leitura de OCR** de qualquer conteúdo copiado para a área de transferência (recomenda-se utilizar o OCR do PowerToys — [baixar aqui](https://aka.ms/getPowertoys)

O foco é simples: **ouvir o texto como uma pessoa que usa leitor de tela vai ouvi-lo**, antes de publicar.

---

## 🖥️ Requisitos

| Requisito | Detalhes |
|-----------|----------|
| Sistema operacional | Windows 10 ou 11 |
| AutoHotkey | Versão 1.1 (AHK v1) — [baixar aqui](https://www.autohotkey.com/) |
| Vozes SAPI | Vozes instaladas no Windows (painel de Controle → Fala) |

> **Atenção:** o script usa AutoHotkey **v1**, não a v2. Certifique-se de instalar a versão correta.

---

## 📁 Estrutura dos arquivos

Após baixar, seu diretório deve conter:

```
📂 leitura-em-voz-alta/
├── Leitura_em_voz_alta.ahk   ← script principal
├── config.ini                 ← configurações de voz, volume e velocidade (gerado automaticamente)
└── megafone.ico               ← ícone da bandeja do sistema (opcional)
```

> Se o arquivo `config.ini` não existir, ele será criado automaticamente com valores padrão na primeira vez que você abrir as configurações.

---

## 🚀 Como usar

### 1. Instale o AutoHotkey v1.1

Acesse [autohotkey.com](https://www.autohotkey.com/download/1.1/) e instale a versão **v1.1**.

### 2. Baixe os arquivos do repositório

Você pode clonar via Git:

```bash
git clone https://github.com/seu-usuario/leitura-em-voz-alta.git
```

Ou simplesmente baixar o ZIP pelo botão **Code → Download ZIP** no GitHub.

### 3. Execute o script

Clique duas vezes no arquivo `Leitura_em_voz_alta.ahk`.

Um ícone de megafone aparecerá na bandeja do sistema (próximo ao relógio), indicando que o script está ativo.

---

## ⌨️ Atalhos disponíveis

| Atalho | Ação |
|--------|------|
| `Ctrl + Shift + Z` | **Iniciar leitura** do texto selecionado (ou do clipboard, se nada estiver selecionado) |
| `Ctrl + Shift + A` | **Abrir configurações** de voz, volume e velocidade |
| `Ctrl + Alt + Win + Numpad4` | **Recarregar** o script |
| `Ctrl + Alt + Esc` | **Encerrar** o script |

> **DICA:** você pode alterar os atalhos da maneira que melhor lhe for conveniente..

### Como funciona a leitura

1. **Selecione o texto** que deseja ouvir em qualquer aplicativo (navegador, editor, e-mail, etc.)
2. Pressione **`Ctrl + Shift + Z`**
3. O texto será lido pela voz configurada no Windows
4. Se **nenhum texto estiver selecionado**, o script lê automaticamente o conteúdo da **área de transferência** (clipboard). **Serve para leitura de textos vindas de OCR**
5. Para **iniciar uma nova leitura**, pressione o atalho novamente com outro texto selecionado — a leitura anterior é interrompida

---

## ⚙️ Configurações de voz

Pressione `Ctrl + Shift + A` para abrir o painel de configurações:

| Opção | Descrição |
|-------|-----------|
| **Voz** | Lista de vozes SAPI instaladas no seu Windows |
| **Volume** | De 0 a 100 |
| **Velocidade** | De -10 (mais lento) a +10 (mais rápido) |

As configurações são salvas automaticamente no arquivo `config.ini` e carregadas sempre que o script for iniciado.

### Como instalar mais vozes no Windows

1. Acesse **Configurações → Hora e idioma → Fala**
2. Em "Vozes", clique em **Adicionar vozes**
3. Selecione o idioma desejado (ex: Português Brasil)
4. Após instalar, reinicie o script para que as novas vozes apareçam na lista

---

## 💡 Casos de uso práticos

### Verificação de acessibilidade
Copie o texto alternativo de uma imagem e pressione `Ctrl + Shift + Z` para ouvir como um leitor de tela vai anunciá-lo. Textos muito longos, vagos ou redundantes ficam evidentes quando escutados.

### Revisão ortográfica e gramatical
Selecione um parágrafo e ouça. Erros de concordância, palavras repetidas e frases truncadas são muito mais perceptíveis ao ouvido do que à leitura visual.

### Teste de textos invisíveis
Cole em um editor de texto simples os conteúdos de `aria-label`, `title` ou legendas de tabelas e ouça como soam isolados do contexto visual.

### Revisão de e-mails e documentos
Antes de enviar, selecione tudo (`Ctrl + A`) e ouça o documento inteiro para uma revisão final.

---

## 🔧 Personalização avançada

O script pode ser editado diretamente no arquivo `.ahk` com qualquer editor de texto. Algumas possibilidades:

- **Trocar os atalhos de teclado** alterando as linhas que começam com `^+z::` ou `^+a::`
- **Alterar o ícone da bandeja** trocando o arquivo `megafone.ico`
- **Reativar atalhos comentados** (como pausar com F24) removendo o `;` no início das linhas relevantes

> Após qualquer edição, use `Ctrl + Alt + Win + Numpad4` para recarregar o script sem precisar fechá-lo manualmente.

---

## ❓ Problemas comuns

**O script não abre / não funciona**
→ Verifique se o AutoHotkey instalado é a versão **v1.1**, não a v2.

**Nenhuma voz é lida / erro de voz**
→ Certifique-se de ter ao menos uma voz SAPI instalada. Abra as configurações (`Ctrl + Shift + A`) e verifique se alguma voz aparece na lista.

**O ícone de megafone não aparece**
→ O arquivo `megafone.ico` precisa estar na mesma pasta do script. Sem ele, o ícone padrão do AHK é usado — o script funciona normalmente.

**A leitura começa mas não para**
→ Pressione `Ctrl + Shift + Z` com qualquer texto selecionado para interromper a leitura atual e iniciar uma nova.

---

## 📄 Licença

Este projeto é disponibilizado como software livre para uso pessoal e educacional. Sinta-se à vontade para adaptar conforme suas necessidades.

---

## 🤝 Contribuições

Sugestões, melhorias e correções são bem-vindas! Abra uma *issue* ou envie um *pull request*.