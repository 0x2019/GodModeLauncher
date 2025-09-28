.386
.model flat, stdcall
option casemap:none

include \masm32\include\windows.inc
include \masm32\include\shell32.inc
include \masm32\include\kernel32.inc

includelib \masm32\lib\shell32.lib
includelib \masm32\lib\kernel32.lib

.data
    szOpen     db "open",0
    szGodMode  db "shell:::{ED7BA470-8E54-465E-825C-99712043E01C}",0
    szControl  db "control.exe",0

.code
start:
    invoke GetVersion
    mov   ebx, eax
    and   ebx, 0FFh

    cmp   ebx, 6               	; OS 메이저 버전이 6 (Vista-11) 이상이면 szGodMode 실행
    jl    fallback_pre_vista	; 6 미만(95/98/ME/2000/XP/2003)은 fallback

    invoke ShellExecuteA, NULL, addr szOpen, addr szGodMode, NULL, NULL, SW_SHOWNORMAL
    jmp   quit

fallback_pre_vista:
    invoke ShellExecuteA, NULL, addr szOpen, addr szControl, NULL, NULL, SW_SHOWNORMAL

quit:
    invoke ExitProcess, 0
end start