; -----------------------------------------
; AutoHotkey Script Corrigido com GUI e Lógica de Pause via F24
; Inclui leitura do conteúdo do Clipboard se nenhum texto for selecionado
; -----------------------------------------

#NoEnv
#Persistent
#SingleInstance, Force

; Definindo o ícone do Tray
Menu, Tray, Icon, megafone.ico

; Leitura das configurações do arquivo INI
IniRead, selectedVoiceIndex, config.ini, Settings, VoiceIndex, 0
IniRead, volumeLevel, config.ini, Settings, Volume, 80
IniRead, speedRate, config.ini, Settings, Rate, 0

; Garantindo que as variáveis são numéricas
selectedVoiceIndex += 0
volumeLevel += 0
speedRate += 0

; Variáveis globais
Memory8 := ""
currentText := "" ; Armazena o texto que está sendo lido atualmente
isPaused := false ; Estado da leitura (pausado ou não)
voice := ComObjCreate("SAPI.SpVoice") ; Criar o objeto de voz SAPI
global F24Mode := false ; Variável para monitorar o estado da tecla F24

; Obter a lista de vozes disponíveis
voices := voice.GetVoices()

; Definir a voz, volume e velocidade iniciais
SetVoiceSettings()

; Função para aplicar as configurações de voz
SetVoiceSettings() {
    global voice, voices, selectedVoiceIndex, volumeLevel, speedRate

    ; Verificar se o índice da voz é válido
    if (selectedVoiceIndex < 0 || selectedVoiceIndex >= voices.Count) {
        selectedVoiceIndex := 0 ; Definir para padrão se inválido
    }

    voice.Voice := voices.Item(selectedVoiceIndex)
    voice.Volume := volumeLevel
    voice.Rate := speedRate
}

; Hotkey para abrir a GUI de configurações (Ctrl+Alt+W ou F21)
;F21
^+a::
    ; Construir a lista de vozes para a GUI, incluindo os índices
    voicesList := ""
    Loop % voices.Count {
        voiceDesc := voices.Item(A_Index - 1).GetDescription()
        voicesList .= A_Index - 1 . ": " . voiceDesc
        if (A_Index < voices.Count)
            voicesList .= "|"
    }

    ; Criar a GUI
    Gui, SettingsGUI:New, , Configurações de Leitura
    Gui, Add, Text,, Escolha a voz:
    Gui, Add, DropDownList, vVoiceChoice w400 AltSubmit, %voicesList%
    Gui, Add, Text,, Volume (0-100):
    Gui, Add, Slider, vVolumeChoice Range0-100 w400, %volumeLevel%
    Gui, Add, Text,, Velocidade (-10 a 10):
    Gui, Add, Slider, vSpeedChoice Range-10-10 w400, %speedRate%
    Gui, Add, Button, gSaveSettings, Salvar
    Gui, Add, Button, gCancelSettings, Cancelar

    ; Mostrar a GUI
    Gui, Show,, Configurações de Leitura

    ; Definir a seleção padrão
    GuiControl, Choose, VoiceChoice, % selectedVoiceIndex + 1
return

SaveSettings:
    Gui, Submit

    ; Atualizar as configurações com os valores selecionados
    selectedVoiceIndex := VoiceChoice - 1
    volumeLevel := VolumeChoice
    speedRate := SpeedChoice

    ; Salvar configurações no arquivo INI
    IniWrite, %selectedVoiceIndex%, config.ini, Settings, VoiceIndex
    IniWrite, %volumeLevel%, config.ini, Settings, Volume
    IniWrite, %speedRate%, config.ini, Settings, Rate

    ; Aplicar as novas configurações
    SetVoiceSettings()

    ; Mostrar confirmação
    MsgBox, Configurações salvas com sucesso.

    ; Fechar a GUI
    Gui, Destroy
return

CancelSettings:
    Gui, Destroy
return

SettingsGUIClose:
    Gui, Destroy
return

; Função para obter o texto selecionado sem usar o Clipboard
GetSelectedText() {
    ClipboardBackup := ClipboardAll
    Clipboard := ""
    Send ^c
    ClipWait, 1
    selectedText := Clipboard
    Clipboard := ClipboardBackup
    return selectedText
}

; Hotkey para copiar texto selecionado e iniciar/retomar leitura (F23)
;F22::
^+z::
    ; Obter o texto selecionado
    selectedText := GetSelectedText()
    
    ; Se não houver texto selecionado, usar o conteúdo da área de transferência
    if (selectedText = "") {
        selectedText := Clipboard
        if (selectedText = "") {
            MsgBox, Nenhum texto selecionado ou disponível na área de transferência.
            return
        }
    }

    ; Armazena o texto em Memory9
    Memory9 := selectedText

    if (F24Mode) {
        ; Se o texto já está sendo lido e está pausado, retoma a leitura
        if (Memory8 = currentText && isPaused) {
            voice.Resume()
            isPaused := false
        }
        ; Caso contrário, inicia uma nova leitura
        else {
            voice.Speak("", 1) ; O "1" força o SAPI a parar a leitura
            currentText := Memory9
            SetVoiceSettings()
            voice.Speak(currentText, 19) ; O "19" permite pausar
            isPaused := false
        }
    }
    else {
        ; Inicia uma nova leitura do começo
        voice.Speak("", 1) ; Interrompe qualquer leitura anterior
        currentText := Memory9
        SetVoiceSettings()
        voice.Speak(currentText, 19) ; Lê o novo texto
        isPaused := false
    }
return

; Hotkey para pausar/retomar a leitura com F24 pressionada
;F24 & F23::
;    if !isPaused {
;        voice.Pause()
;        isPaused := true
;    } else {
;        voice.Resume()
;        isPaused := false
;    }
;return

; Hotkey para monitorar o estado de F24
;F24::
;    global F24Mode
;    F24Mode := true
;return

;F24 Up::
;    global F24Mode
;    F24Mode := false
;return

; Hotkey para recarregar o script (F22)
;F22::Reload

; Hotkey Ctrl+Alt+Win+Numpad4 para recarregar o script
^!#Numpad4::Reload

; Hotkey Ctrl+Alt+Esc para sair do script
^!Esc::ExitApp
