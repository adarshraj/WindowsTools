; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
; General Asm Template by Lahar 
; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл

.686					;Use 686 instuction set to have all inel commands
.model flat, stdcall	;Use flat memory model since we are in 32bit 
option casemap: none	;Variables and others are case sensitive

include Template.inc	;Include our files containing libraries

; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
; Our initialised variables will go into in this .data section
; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
.data
	szAppName	db	"Windows Tools 1.0",0
	szOpen		db	"Open",0
	stButtonFont LOGFONT <13,0,0,0,FW_NORMAL,0,0,0,DEFAULT_CHARSET,OUT_TT_PRECIS,0,0,0,"Verdana">
	szRestore		db	"\restore\rstrui.exe",0
	szComService	db	"\com\comexp.msc",0
	nSize		dd	150

; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
; Our uninitialised variables will go into in this .data? section
; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
.data?
	hInstance			HINSTANCE	?
	dwHidden			DWORD		?
	dwCommn				DWORD		?
	dwGames				DWORD		?
	dwMisc				DWORD		?
	hFont				HFONT		?
	szSysDir			db	150	dup (?)
	szTempBuffer		db	150	dup (?)

; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
; Our constant values will go onto this section
; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
.const
	IDD_DLGBOX	equ	1001
	IDC_OK1		equ	1002
	IDC_OK2		equ 1012
	IDC_OK3		equ 1015
	IDC_OK4		equ 1018
	IDC_ME		EQU	1020
	IDC_DES		EQU	1007
	IDC_CB1		EQU	1008
	IDC_CB2		EQU	1011
	IDC_CB3		EQU	1014
	IDC_CB4 	EQU	1017
	APP_ICON	equ	2000
	APP_CURSOR	equ	2001
	
	;Hidden Apps Constants
	ID_HIDDEN_ACCWIZ		EQU	0
	ID_HIDDEN_BACKUP		EQU	1
	ID_HIDDEN_CERTIFICATE	EQU	2
	ID_HIDDEN_CHAREDIT		EQU	3
	ID_HIDDEN_CHARMAP		EQU	4
	ID_HIDDEN_CLIPBOARD		EQU	5
	ID_HIDDEN_COMPOSERV		EQU	6
	ID_HIDDEN_DEFRAG		EQU	7
	ID_HIDDEN_DEVICEMGR		EQU	8
	ID_HIDDEN_DIRECTX		EQU	9
	ID_HIDDEN_DISKCLR		EQU	10
	ID_HIDDEN_DISKMGR		EQU 11
	ID_HIDDEN_DRVERVER		EQU	12
	ID_HIDDEN_WATSON		EQU	13
	ID_HIDDEN_EVENTVIEW		EQU 14
	ID_HIDDEN_SIGNATURE		EQU	15
	ID_HIDDEN_GRPPOLICY		EQU	16
	ID_HIDDEN_IEXPRESS		EQU	17
	ID_HIDDEN_INDEX			EQU 18
	ID_HIDDEN_LOCALUSER		EQU 19
	ID_HIDDEN_SHAREDDIR		EQU	20
	ID_HIDDEN_OBJPACK		EQU 21
	ID_HIDDEN_ODBCADMIN		EQU	22
	ID_HIDDEN_PROGMGR		EQU	23
	ID_HIDDEN_REGEDIT		EQU	24
	ID_HIDDEN_RASPHBOOK		EQU	25
	ID_HIDDEN_REMSTORAGE	EQU	26
	ID_HIDDEN_REMSTOOPE		EQU	27
	ID_HIDDEN_SECSYSTEM		EQU	28
	ID_HIDDEN_SYNCRO		EQU	29
	ID_HIDDEN_SYSKEY		EQU	30
	ID_HIDDEN_SYSCONFEDIT	EQU	31
	ID_HIDDEN_SYSCONUTIL	EQU	32
	ID_HIDDEN_SYSPERF		EQU	33
	ID_HIDDEN_TELNET		EQU	34
	ID_HIDDEN_UTIMGR		EQU	35
	ID_HIDDEN_VOLCTRL		EQU 36
	ID_HIDDEN_WMI			EQU	37
	ID_HIDDEN_WMP51			EQU	38
	ID_HIDDEN_WORKCHAT		EQU	39
	
	;Common Apps Constants
	ID_COMMON_CALC			EQU	0
	ID_COMMON_CMD			EQU	1
	ID_COMMON_IE			EQU	2
	ID_COMMON_NOTEPAD		EQU	3
	ID_COMMON_OUTLOOK		EQU	4
	ID_COMMON_PAINT			EQU	5
	ID_COMMON_SOUNDREC		EQU	6
	ID_COMMON_WMK			EQU	7
	ID_COMMON_WMP			EQU	8
	ID_COMMON_WORDPAD		EQU	9
	
	;Game Constants
	ID_GAME_FREECELL		EQU	0
	ID_GAME_HEARTS			EQU	1
	ID_GAME_INTBACK			EQU	2
	ID_GAME_INTCHECK		EQU	3
	ID_GAME_INTHEARTS		EQU	4
	ID_GAME_INTREVERSI		EQU	5
	ID_GAME_INTSPADE		EQU	6
	ID_GAME_MINE			EQU	7
	ID_GAME_PINBALL			EQU	8
	ID_GAME_SOLTAIRE		EQU	9
	ID_GAME_SPIDY			EQU	10
	
	;Misc Constants
	ID_MISC_ADDRESS			EQU	0
	ID_MISC_CONTROL			EQU	1
	ID_MISC_EXPLORER		EQU	2
	ID_MISC_SETTINGTRANS	EQU	3
	ID_MISC_HYPER			EQU 4
	ID_MISC_MAGNIFIER		EQU	5
	ID_MISC_NARRATOR		EQU	6
	ID_MISC_OSK				EQU	7
	ID_MISC_REMOTEDESKTOP	EQU	8
	ID_MISC_SYSINFO			EQU	9
	ID_MISC_SYSRESTORE		EQU	10
	ID_MISC_TASKMANAGER		EQU	11
	ID_MISC_TOUR			EQU	12
	ID_MISC_UPDATE			EQU	13
	ID_MISC_WINVERSION		EQU	14


; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
; This is the section to write our main code
; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
.code

start:	
	invoke GetModuleHandle, NULL
	mov hInstance, eax
	invoke InitCommonControls
	invoke DialogBoxParam, hInstance, IDD_DLGBOX, NULL, addr DlgProc, NULL
	invoke ExitProcess, NULL

DlgProc		proc	hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM
	.if uMsg == WM_INITDIALOG
		invoke SetWindowText, hWnd, addr szAppName
		invoke LoadIcon, hInstance, APP_ICON
		invoke SendMessage, hWnd, WM_SETICON, 1, eax
		
		invoke LoadCursor, hInstance,IDC_HAND
		invoke SendMessage, hWnd, WM_SETCURSOR, 1, eax
		invoke LoadCursor, hInstance,APP_CURSOR
		invoke SetCursor,EAX
		invoke ShowCursor, TRUE
		
		invoke GetSystemDirectory, addr szSysDir, addr nSize
		invoke CreateFontIndirect,addr stButtonFont
		mov hFont, eax
			
		invoke SendDlgItemMessage, hWnd, IDC_CB1, WM_SETFONT, hFont, TRUE
		invoke SendDlgItemMessage, hWnd, IDC_CB2, WM_SETFONT, hFont, TRUE
		invoke SendDlgItemMessage, hWnd, IDC_CB3, WM_SETFONT, hFont, TRUE
		invoke SendDlgItemMessage, hWnd, IDC_CB4, WM_SETFONT, hFont, TRUE	
		invoke SendDlgItemMessage, hWnd, IDC_DES, WM_SETFONT, hFont, TRUE
		
		; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
		; Hidden Apps
		; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_ACCWIZ,SADD("Accessibility Wizard")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_BACKUP,SADD("Backup")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_CERTIFICATE,SADD("Certificates")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_CHAREDIT,SADD("Character Editor")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_CHARMAP,SADD("Character Map")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_CLIPBOARD,SADD("Clipboard Viewer")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_COMPOSERV,SADD("Component Services")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_DEFRAG,SADD("Defragmenter")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_DEVICEMGR,SADD("Device Manager")	
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_DIRECTX,SADD("DirectX")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_DISKCLR,SADD("Disk Cleaner")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_DISKMGR,SADD("Disk Manager")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_DRVERVER,SADD("Driver Verifier")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_WATSON,SADD("Dr. Watson")		
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_EVENTVIEW,SADD("Event Viewer")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_SIGNATURE,SADD("File Signature Verifier")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_GRPPOLICY,SADD("Group Policy Editor")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_IEXPRESS,SADD("IExpress Wizard")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_INDEX,SADD("Indexing Services")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_LOCALUSER,SADD("Local user & Group Manager")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_SHAREDDIR,SADD("Network Shared Folders")	
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_OBJPACK,SADD("Object Packager")	
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_ODBCADMIN,SADD("ODBC Administrator")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_PROGMGR,SADD("Program Manager")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_REGEDIT,SADD("Registry Editor")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_RASPHBOOK,SADD("Remote Access Phone Book")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_REMSTORAGE,SADD("Removable Storage")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_REMSTOOPE,SADD("Removable storage operator")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_SECSYSTEM,SADD("Security Settings ")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_SYNCRO,SADD("Synchronization Tool")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_SYSKEY,SADD("SysKey")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_SYSCONFEDIT,SADD("System Configuration Editor")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_SYSCONUTIL,SADD("System Configuration Utility")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_SYSPERF,SADD("System Performance")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_TELNET,SADD("Telnet")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_UTIMGR,SADD("Utility Manager")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_VOLCTRL,SADD("Volume Control")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_WMI,SADD("Wnidows Mgmt infrastructure")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_WMP51,SADD("Windows Media Player 5.1")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_INSERTSTRING,ID_HIDDEN_WORKCHAT,SADD("Workgroup Chat")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB1,CB_SELECTSTRING,ID_HIDDEN_CHAREDIT,SADD("Character Editor")
		
		; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
		; Common Apps
		; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
		INVOKE SendDlgItemMessage, hWnd, IDC_CB2,CB_INSERTSTRING,ID_COMMON_CALC,SADD("Calculator")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB2,CB_INSERTSTRING,ID_COMMON_CMD,SADD("Command Prompt")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB2,CB_INSERTSTRING,ID_COMMON_IE,SADD("Internet Explorer")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB2,CB_INSERTSTRING,ID_COMMON_NOTEPAD,SADD("Notepad")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB2,CB_INSERTSTRING,ID_COMMON_OUTLOOK,SADD("Outlook Express")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB2,CB_INSERTSTRING,ID_COMMON_PAINT,SADD("Paint")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB2,CB_INSERTSTRING,ID_COMMON_SOUNDREC,SADD("Sound Recorder")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB2,CB_INSERTSTRING,ID_COMMON_WMK,SADD("Windows Movie Maker")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB2,CB_INSERTSTRING,ID_COMMON_WMP,SADD("Windows Media Player")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB2,CB_INSERTSTRING,ID_COMMON_WORDPAD,SADD("Wordpad")	
		INVOKE SendDlgItemMessage, hWnd, IDC_CB2,CB_SELECTSTRING,ID_COMMON_CALC,SADD("Calculator")	
		
		; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
		; Games
		; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
		INVOKE SendDlgItemMessage, hWnd, IDC_CB3,CB_INSERTSTRING,ID_GAME_FREECELL,SADD("Freecell")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB3,CB_INSERTSTRING,ID_GAME_HEARTS	,SADD("Hearts")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB3,CB_INSERTSTRING,ID_GAME_INTBACK,SADD("Internet Backgammon")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB3,CB_INSERTSTRING,ID_GAME_INTCHECK,SADD("Internet Checkers")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB3,CB_INSERTSTRING,ID_GAME_INTHEARTS,SADD("Internet Hearts")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB3,CB_INSERTSTRING,ID_GAME_INTREVERSI,SADD("Internet Reversi")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB3,CB_INSERTSTRING,ID_GAME_INTSPADE,SADD("Internet Spades")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB3,CB_INSERTSTRING,ID_GAME_MINE,SADD("Minesweeper")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB3,CB_INSERTSTRING,ID_GAME_PINBALL	,SADD("Pinball")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB3,CB_INSERTSTRING,ID_GAME_SOLTAIRE,SADD("Solitaire")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB3,CB_INSERTSTRING,ID_GAME_SPIDY,SADD("Spider Solitaire")	
		INVOKE SendDlgItemMessage, hWnd, IDC_CB3,CB_SELECTSTRING,ID_GAME_FREECELL,SADD("Freecell")
	
		; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
		; Misc Apps
		; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
		INVOKE SendDlgItemMessage, hWnd, IDC_CB4,CB_INSERTSTRING,ID_MISC_ADDRESS,SADD("Address Book")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB4,CB_INSERTSTRING,ID_MISC_CONTROL,SADD("Control Panel")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB4,CB_INSERTSTRING,ID_MISC_EXPLORER,SADD("Explorer")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB4,CB_INSERTSTRING,ID_MISC_SETTINGTRANS,SADD("Files & Settings Transfer ")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB4,CB_INSERTSTRING,ID_MISC_HYPER,SADD("Hyper Terminal")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB4,CB_INSERTSTRING,ID_MISC_MAGNIFIER,SADD("Magnifier")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB4,CB_INSERTSTRING,ID_MISC_NARRATOR,SADD("Narrator")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB4,CB_INSERTSTRING,ID_MISC_OSK,SADD("On-Screen Keyboard")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB4,CB_INSERTSTRING,ID_MISC_REMOTEDESKTOP,SADD("Remote Desktop")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB4,CB_INSERTSTRING,ID_MISC_SYSINFO,SADD("System Information")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB4,CB_INSERTSTRING,ID_MISC_SYSRESTORE,SADD("System Restore")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB4,CB_INSERTSTRING,ID_MISC_TASKMANAGER,SADD("Task Manager")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB4,CB_INSERTSTRING,ID_MISC_TOUR,SADD("Windows Tour")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB4,CB_INSERTSTRING,ID_MISC_UPDATE,SADD("Windows Update")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB4,CB_INSERTSTRING,ID_MISC_WINVERSION,SADD("Windows Version")
		INVOKE SendDlgItemMessage, hWnd, IDC_CB4,CB_SELECTSTRING,ID_MISC_ADDRESS,SADD("Address Book")
	
	.elseif uMsg == WM_COMMAND
		mov eax, wParam
		;Hidden Files OK Button
		.if eax == IDC_OK1
			.if dwHidden == ID_HIDDEN_ACCWIZ
				invoke WinExec, SADD("accwiz.exe"),SW_SHOW
			.elseif dwHidden == ID_HIDDEN_BACKUP
				invoke WinExec, SADD("ntbackup.exe"),SW_SHOW
			.elseif dwHidden ==ID_HIDDEN_CERTIFICATE
				invoke ShellExecute,hWnd,addr szOpen,SADD("certmgr.msc"),NULL,NULL,SW_SHOW
			.elseif dwHidden == ID_HIDDEN_CHAREDIT	
				invoke WinExec, SADD("eudcedit.exe"),SW_SHOW
			.elseif dwHidden == ID_HIDDEN_CHARMAP	
				invoke WinExec, SADD("charmap.exe"),SW_SHOW	
			.elseif dwHidden == ID_HIDDEN_CLIPBOARD	
				invoke ShellExecute,hWnd,addr szOpen,SADD("clipbrd"),NULL,NULL,SW_SHOW
			.elseif dwHidden == ID_HIDDEN_COMPOSERV
				invoke RtlZeroMemory, addr szTempBuffer, 150
				invoke lstrcat,addr szTempBuffer, addr szSysDir
				invoke lstrcat,addr szTempBuffer, addr szComService
				invoke ShellExecute,hWnd,addr szOpen,addr szTempBuffer,NULL,NULL,SW_SHOW
			.elseif dwHidden == ID_HIDDEN_DEFRAG	
				invoke ShellExecute,hWnd,addr szOpen,SADD("dfrg.msc"),NULL,NULL,SW_SHOW
			.elseif dwHidden == ID_HIDDEN_DEVICEMGR
				invoke ShellExecute,hWnd,addr szOpen,SADD("devmgmt.msc"),NULL,NULL,SW_SHOW
			.elseif dwHidden == ID_HIDDEN_DIRECTX	
				invoke ShellExecute,hWnd,addr szOpen,SADD("dxdiag.exe"),NULL,NULL,SW_SHOW
			.elseif dwHidden == ID_HIDDEN_DISKCLR	
				invoke ShellExecute,hWnd,addr szOpen,SADD("cleanmgr.exe"),NULL,NULL,SW_SHOW
			.elseif dwHidden == ID_HIDDEN_DISKMGR
				invoke ShellExecute,hWnd,addr szOpen,SADD("diskmgmt.msc"),NULL,NULL,SW_SHOW
			.elseif dwHidden == ID_HIDDEN_DRVERVER	
				invoke ShellExecute,hWnd,addr szOpen,SADD("verifier.exe"),NULL,NULL,SW_SHOW
			.elseif dwHidden == ID_HIDDEN_WATSON	
				invoke ShellExecute,hWnd,addr szOpen,SADD("drwtsn32.exe"),NULL,NULL,SW_SHOW
			.elseif dwHidden == ID_HIDDEN_EVENTVIEW
				invoke ShellExecute,hWnd,addr szOpen,SADD("eventvwr.msc"),NULL,NULL,SW_SHOW
			.elseif dwHidden == ID_HIDDEN_SIGNATURE	
				invoke ShellExecute,hWnd,addr szOpen,SADD("sigverif.exe"),NULL,NULL,SW_SHOW
			.elseif dwHidden == ID_HIDDEN_GRPPOLICY
				invoke ShellExecute,hWnd,addr szOpen,SADD("gpedit.msc"),NULL,NULL,SW_SHOW
			.elseif dwHidden == ID_HIDDEN_IEXPRESS	
				invoke ShellExecute,hWnd,addr szOpen,SADD("iexpress.exe"),NULL,NULL,SW_SHOW
			.elseif dwHidden == ID_HIDDEN_INDEX
				invoke ShellExecute,hWnd,addr szOpen,SADD("ciadv.msc"),NULL,NULL,SW_SHOW
			.elseif dwHidden == ID_HIDDEN_LOCALUSER
				invoke ShellExecute,hWnd,addr szOpen,SADD("lusrmgr.msc"),NULL,NULL,SW_SHOW
			.elseif dwHidden == ID_HIDDEN_SHAREDDIR	
				invoke ShellExecute,hWnd,addr szOpen,SADD("shrpubw.exe"),NULL,NULL,SW_SHOW
			.elseif dwHidden == ID_HIDDEN_OBJPACK	
				invoke ShellExecute,hWnd,addr szOpen,SADD("packager.exe"),NULL,NULL,SW_SHOW	
			.elseif dwHidden == ID_HIDDEN_ODBCADMIN	
				invoke ShellExecute,hWnd,addr szOpen,SADD("odbcad32.exe"),NULL,NULL,SW_SHOW
			.elseif dwHidden == ID_HIDDEN_PROGMGR	
				invoke ShellExecute,hWnd,addr szOpen,SADD("progman.exe"),NULL,NULL,SW_SHOW
			.elseif dwHidden == ID_HIDDEN_REGEDIT	
				invoke ShellExecute,hWnd,addr szOpen,SADD("regedt32.exe"),NULL,NULL,SW_SHOW
			.elseif dwHidden == ID_HIDDEN_RASPHBOOK
				invoke ShellExecute,hWnd,addr szOpen,SADD("rasphone.exe"),NULL,NULL,SW_SHOW
			.elseif dwHidden == ID_HIDDEN_REMSTORAGE
				invoke ShellExecute,hWnd,addr szOpen,SADD("ntmsmgr.msc"),NULL,NULL,SW_SHOW
			.elseif dwHidden == ID_HIDDEN_REMSTOOPE
				invoke ShellExecute,hWnd,addr szOpen,SADD("ntmsoprq.msc"),NULL,NULL,SW_SHOW
			.elseif dwHidden == ID_HIDDEN_SECSYSTEM	
				invoke ShellExecute,hWnd,addr szOpen,SADD("secpol.msc"),NULL,NULL,SW_SHOW
			.elseif dwHidden == ID_HIDDEN_SYNCRO	
				invoke ShellExecute,hWnd,addr szOpen,SADD("mobsync.exe"),NULL,NULL,SW_SHOW
			.elseif dwHidden == ID_HIDDEN_SYSKEY	
				invoke ShellExecute,hWnd,addr szOpen,SADD("syskey.exe"),NULL,NULL,SW_SHOW
			.elseif dwHidden == ID_HIDDEN_SYSCONFEDIT
				invoke ShellExecute,hWnd,addr szOpen,SADD("sysedit.exe"),NULL,NULL,SW_SHOW
			.elseif dwHidden == ID_HIDDEN_SYSCONUTIL
				invoke ShellExecute,hWnd,addr szOpen,SADD("msconfig.exe"),NULL,NULL,SW_SHOW
			.elseif dwHidden == ID_HIDDEN_SYSPERF	
				invoke ShellExecute,hWnd,addr szOpen,SADD("perfmon.exe"),NULL,NULL,SW_SHOW
			.elseif dwHidden == ID_HIDDEN_TELNET	
				invoke ShellExecute,hWnd,addr szOpen,SADD("telnet.exe"),NULL,NULL,SW_SHOW
			.elseif dwHidden == ID_HIDDEN_UTIMGR	
				invoke ShellExecute,hWnd,addr szOpen,SADD("utilman.exe"),NULL,NULL,SW_SHOW 	
			.elseif dwHidden == ID_HIDDEN_VOLCTRL	
				invoke ShellExecute,hWnd,addr szOpen,SADD("sndvol32.exe"),NULL,NULL,SW_SHOW 	
			.elseif dwHidden == ID_HIDDEN_WMI
				invoke ShellExecute,hWnd,addr szOpen,SADD("mmc"),NULL,NULL,SW_SHOW
			.elseif dwHidden == ID_HIDDEN_WMP51	
				invoke ShellExecute,hWnd,addr szOpen,SADD("mplay32.exe"),NULL,NULL,SW_SHOW 	
			.elseif dwHidden == ID_HIDDEN_WORKCHAT	
				invoke ShellExecute,hWnd,addr szOpen,SADD("winchat.exe"),NULL,NULL,SW_SHOW 					
			.endif	
		;Common Files OK Button	
		.elseif eax == IDC_OK2
			.if dwCommn == ID_COMMON_CALC
				invoke WinExec, SADD("calc.exe"),SW_SHOW
			.elseif dwCommn == ID_COMMON_CMD
				invoke WinExec, SADD("cmd.exe"),SW_SHOW
			.elseif dwCommn == ID_COMMON_IE
				invoke ShellExecute,hWnd,addr szOpen,SADD("iexplore"),NULL,NULL,SW_SHOW
			.elseif dwCommn == ID_COMMON_NOTEPAD
				invoke WinExec, SADD("notepad.exe"),SW_SHOW 	
			.elseif dwCommn == ID_COMMON_OUTLOOK
				invoke ShellExecute,hWnd,addr szOpen,SADD("msimn"),NULL,NULL,SW_SHOW	
			.elseif dwCommn == ID_COMMON_PAINT	
				invoke WinExec, SADD("mspaint.exe"),SW_SHOW 	
			.elseif dwCommn == ID_COMMON_SOUNDREC
				invoke ShellExecute,hWnd,addr szOpen,SADD("sndrec32"),NULL,NULL,SW_SHOW
			.elseif dwCommn == ID_COMMON_WMK
				invoke ShellExecute,hWnd,addr szOpen,SADD("moviemk"),NULL,NULL,SW_SHOW	
			.elseif dwCommn == ID_COMMON_WMP
				invoke ShellExecute,hWnd,addr szOpen,SADD("wmplayer.exe"),SADD("/prefetch:1"),NULL,SW_SHOW	
			.elseif dwCommn == ID_COMMON_WORDPAD
				invoke WinExec, SADD("write.exe"),SW_SHOW 	
			.endif	
		;Game File OK Button	
		.elseif eax == IDC_OK3
			.if dwGames == ID_GAME_FREECELL
				invoke WinExec, SADD("freecell.exe"),SW_SHOW 	
			.elseif dwGames == ID_GAME_HEARTS
				invoke WinExec, SADD("mshearts.exe"),SW_SHOW 	
			.elseif dwGames == ID_GAME_INTBACK
				invoke ShellExecute,hWnd,addr szOpen,SADD("bckgzm.exe"),NULL,NULL,SW_SHOW
			.elseif dwGames == ID_GAME_INTCHECK
				invoke ShellExecute,hWnd,addr szOpen,SADD("chkrzm.exe"),NULL,NULL,SW_SHOW
			.elseif dwGames == ID_GAME_INTHEARTS
				invoke ShellExecute,hWnd,addr szOpen,SADD("hrtzzm.exe"),NULL,NULL,SW_SHOW
			.elseif dwGames == ID_GAME_INTREVERSI
				invoke ShellExecute,hWnd,addr szOpen,SADD("Rvsezm.exe"),NULL,NULL,SW_SHOW
			.elseif dwGames == ID_GAME_INTSPADE
				invoke ShellExecute,hWnd,addr szOpen,SADD("shvlzm.exe"),NULL,NULL,SW_SHOW
			.elseif dwGames == ID_GAME_MINE
				invoke WinExec, SADD("winmine.exe"),SW_SHOW 
			.elseif dwGames == ID_GAME_PINBALL
				invoke ShellExecute,hWnd,addr szOpen,SADD("PINBALL.EXE"),NULL,NULL,SW_SHOW
			.elseif dwGames == ID_GAME_SOLTAIRE
				invoke WinExec, SADD("Sol.exe"),SW_SHOW 
			.elseif dwGames == ID_GAME_SPIDY
				invoke WinExec, SADD("spider.exe"),SW_SHOW 
			.endif
		;Misc app OK Button	
		.elseif eax == IDC_OK4
			.if dwMisc == ID_MISC_ADDRESS	
				invoke ShellExecute,hWnd,addr szOpen,SADD("wab.exe"),NULL,NULL,SW_SHOW	
			.elseif dwMisc == ID_MISC_CONTROL	
				invoke WinExec, SADD("control.exe"),SW_SHOW 		
			.elseif dwMisc == ID_MISC_EXPLORER
				invoke WinExec, SADD("explorer.exe"),SW_SHOW 
			.elseif dwMisc == ID_MISC_SETTINGTRANS		
				invoke ShellExecute,hWnd,addr szOpen,SADD("migwiz"),NULL,NULL,SW_SHOW	
			.elseif dwMisc == ID_MISC_HYPER
				invoke ShellExecute,hWnd,addr szOpen,SADD("hypertrm"),NULL,NULL,SW_SHOW
			.elseif dwMisc == ID_MISC_MAGNIFIER
				invoke ShellExecute,hWnd,addr szOpen,SADD("magnify"),NULL,NULL,SW_SHOW
			.elseif dwMisc == ID_MISC_NARRATOR
				invoke ShellExecute,hWnd,addr szOpen,SADD("narrator"),NULL,NULL,SW_SHOW
			.elseif dwMisc == ID_MISC_OSK
				invoke ShellExecute,hWnd,addr szOpen,SADD("osk"),NULL,NULL,SW_SHOW
			.elseif dwMisc == ID_MISC_REMOTEDESKTOP
				invoke ShellExecute,hWnd,addr szOpen,SADD("mstsc"),NULL,NULL,SW_SHOW
			.elseif dwMisc == ID_MISC_SYSINFO
				invoke ShellExecute,hWnd,addr szOpen,SADD("msinfo32"),NULL,NULL,SW_SHOW
			.elseif dwMisc == ID_MISC_SYSRESTORE
				invoke RtlZeroMemory, addr szTempBuffer, 150
				invoke lstrcat,addr szTempBuffer, addr szSysDir
				invoke lstrcat,addr szTempBuffer, addr szRestore
				invoke ShellExecute,hWnd,addr szOpen,addr szTempBuffer, NULL,NULL,SW_SHOW
			.elseif dwMisc == ID_MISC_TASKMANAGER
				invoke ShellExecute,hWnd,addr szOpen,SADD("taskmgr"),NULL,NULL,SW_SHOW
			.elseif dwMisc == ID_MISC_TOUR
				invoke ShellExecute,hWnd,addr szOpen,SADD("tourstart"),NULL,NULL,SW_SHOW
			.elseif dwMisc == ID_MISC_UPDATE
				invoke ShellExecute,hWnd,addr szOpen,SADD("wupdmgr"),NULL,NULL,SW_SHOW
			.elseif dwMisc == ID_MISC_WINVERSION
				invoke ShellExecute,hWnd,addr szOpen,SADD("winver"),NULL,NULL,SW_SHOW
			.endif	
		;Me	
		.elseif eax == IDC_ME
			 invoke SetDlgItemText, hWnd, IDC_DES,SADD("Created By Lahar on 01/01/2008. My first app of this year. Tested in my WindowXP SP2 only. Others, i don't know. I'm not responsible for anything happened to your system by using this app. Contact me at WinAsm forum. Hav fun.")
		;Hidden apps combo selection change so as to fill app description
		.elseif ax == IDC_CB1
    	    SHR eax,16
    		.if ax == CBN_SELCHANGE
    			invoke SendDlgItemMessage, hWnd,IDC_CB1,CB_GETCURSEL,NULL,NULL	
    			MOV dwHidden, eax
    			.if dwHidden == ID_HIDDEN_ACCWIZ
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Use the Accessibility Wizard to configure your system to meet your vision, hearing, and mobility needs.")
    			.elseif dwHidden == ID_HIDDEN_BACKUP
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Archives data to protect it from accidental loss. ")
    			.elseif dwHidden == ID_HIDDEN_CERTIFICATE
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("The Certificates snap-in allows you to browse the contents of the certificate stores for yourself, a service, or a computer.")
    			.elseif dwHidden == ID_HIDDEN_CHAREDIT
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Allows creation or modification of characters.")
    			.elseif dwHidden == ID_HIDDEN_CHARMAP
    			    invoke SetDlgItemText, hWnd, IDC_DES,SADD("Findes unusual characters and helps to copy them.")
    			.elseif dwHidden == ID_HIDDEN_CLIPBOARD
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("View content of clipboard. ")
    			.elseif dwHidden ==	ID_HIDDEN_COMPOSERV
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Your system and non system services can be seen through this app ")
    			.elseif dwHidden == ID_HIDDEN_DEFRAG
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Disk Defragmenter. ")
    			.elseif dwHidden ==	ID_HIDDEN_DEVICEMGR
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("You can use Device Manager to view a list of hardware devices installed on your computer and set properties for each device.")
    			.elseif dwHidden == ID_HIDDEN_DIRECTX
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Diagnose & test DirectX, video & sound cards. ")
    			.elseif dwHidden == ID_HIDDEN_DISKCLR
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Clean your system and hence gain some valuble memory. ")
    			.elseif dwHidden == ID_HIDDEN_DISKMGR
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Dynamic disk and volume management.")
    			.elseif dwHidden == ID_HIDDEN_DRVERVER
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Utility for monitoring the actions of drivers, might be useful for people having driver problems.  ")
    			.elseif dwHidden == ID_HIDDEN_WATSON
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Troubleshooting/Debugging tool ")
    			.elseif dwHidden ==	ID_HIDDEN_EVENTVIEW
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Event Viewer Snapin Launcher. Displays event logs.")
    			.elseif dwHidden == ID_HIDDEN_SIGNATURE
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Digital signature verifier ")
    			.elseif dwHidden ==	ID_HIDDEN_GRPPOLICY
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("This snap-in allows you to edit Group Policy Objects which can be linked to a Site, Domain, or Organizational Unit in the Active Directory or stored on a computer.")
    			.elseif dwHidden == ID_HIDDEN_IEXPRESS
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Create self-extracting / self-installing package. ")
    			.elseif dwHidden ==	ID_HIDDEN_INDEX	
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Provides fast and flexible searching on file contents and properties.")
    			.elseif dwHidden ==	ID_HIDDEN_LOCALUSER
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Manages Local Users and Groups")
    			.elseif dwHidden == ID_HIDDEN_SHAREDDIR
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Creates shared folders on network. ")
    			.elseif dwHidden == ID_HIDDEN_OBJPACK
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("To do with packaging objects for insertion in files, appears to have comprehensive help files ")	
    			.elseif dwHidden == ID_HIDDEN_ODBCADMIN
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Deals with ODBC. ")
    			.elseif dwHidden == ID_HIDDEN_PROGMGR
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Legacy Windows 3.x desktop shell ")
    			.elseif dwHidden == ID_HIDDEN_REGEDIT
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Edit your registry. ")
    			.elseif dwHidden == ID_HIDDEN_RASPHBOOK
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Send me the documentation if u have. ")
    			.elseif dwHidden == ID_HIDDEN_REMSTORAGE
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Catalogs removable media and manages automated libraries.")
    			.elseif dwHidden ==	ID_HIDDEN_REMSTOOPE
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Catalogs removable media and manages automated libraries.")
    			.elseif dwHidden == ID_HIDDEN_SECSYSTEM
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("The Security Settings Extension snap-in extends the Group Policy snap-in and helps you define security policies for computers in your domain.")
    			.elseif dwHidden == ID_HIDDEN_SYNCRO
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Allow synchronization of files on the network for when working offline. ")
    			.elseif dwHidden == ID_HIDDEN_SYSKEY
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Secures XP Account database. ")  			
    			.elseif dwHidden == ID_HIDDEN_SYSCONFEDIT
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Modify System.ini & Win.ini just like in Win98! ")
    			.elseif dwHidden == ID_HIDDEN_SYSCONUTIL
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Utility to manage the system configurations.")
    			.elseif dwHidden == ID_HIDDEN_SYSPERF
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Allows you to open a Windows Performance console. Tells everything about your pc performance ")
    			.elseif dwHidden == ID_HIDDEN_TELNET
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Telnet Client and Telnet Server work together to allow users to communicate with a remote computer.  ")
    			.elseif dwHidden == ID_HIDDEN_UTIMGR
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Opens accessibility programs.")
    			.elseif dwHidden == ID_HIDDEN_VOLCTRL
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Control your system volume. ")
    			.elseif dwHidden == ID_HIDDEN_WMI
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Allows configuration and control of the Windows Management Instrumentation (WMI) service.")
    			.elseif dwHidden == ID_HIDDEN_WMP51	
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Retro version of Windows Media Player, very basic. ")
    			.elseif dwHidden == ID_HIDDEN_WORKCHAT
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("An old NT utility to allow chat sessions over a LAN. ")
    			.endif		
    		.endif	
    	;Common apps combo selection change so as to fill app description	
    	.elseif ax == IDC_CB2
    	    SHR eax,16
    		.if ax == CBN_SELCHANGE	
    		    invoke SendDlgItemMessage, hWnd,IDC_CB2,CB_GETCURSEL,NULL,NULL	
    			MOV dwCommn, eax
    			.if dwCommn == ID_COMMON_CALC
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Performs basic arithmetic tasks with an on-screen calculator.")
    			.elseif dwCommn == ID_COMMON_CMD	
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Performs text-based (command-line) functions.")
    			.elseif dwCommn == ID_COMMON_IE
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Internet Explorer - Go browse the internet ")
    			.elseif dwCommn == ID_COMMON_NOTEPAD
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Creates and edits text files using basic text formatting.")
    			.elseif dwCommn == ID_COMMON_OUTLOOK
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Outlook Express - Get your E-mails")
    			.elseif dwCommn == ID_COMMON_PAINT	
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Creates and edits drawings, and displays and edits scanned photos.")
    			.elseif dwCommn == ID_COMMON_SOUNDREC
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Records sounds if a microphone and sound card are installed.")
    			.elseif dwCommn == ID_COMMON_WMK
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("This application allows you to record, organize, edit and share Windows Media on your computer, via e-mail or the Internet.")
    			.elseif dwCommn == ID_COMMON_WMP
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Play digital media including music, videos, CDs and DVDs")
    			.elseif dwCommn == ID_COMMON_WORDPAD
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Creates and edits text documents with complex formatting.")
    			.endif	
    		.endif
    	;Game apps combo selection change so as to fill app description	
    	.elseif ax == IDC_CB3
    	    SHR eax,16
    		.if ax == CBN_SELCHANGE	
    		    invoke SendDlgItemMessage, hWnd,IDC_CB3,CB_GETCURSEL,NULL,NULL	
    			MOV dwGames, eax
    			.if dwGames == ID_GAME_FREECELL
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Begins the Freecell card game.")
    			.elseif dwGames == ID_GAME_HEARTS	
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Begins the Hearts card game.")
    			.elseif dwGames == ID_GAME_INTBACK	
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Play the board game Backgammon with another person over the Internet.")	
    			.elseif dwGames == ID_GAME_INTCHECK
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Play the board game Checkers with another person over the Internet.")
    			.elseif dwGames == ID_GAME_INTHEARTS
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Play the card game Hearts with other people from around the world.")
    			.elseif dwGames == ID_GAME_INTREVERSI
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Play the board game Reversi with another person over the Internet.")
    			.elseif dwGames == ID_GAME_INTSPADE
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Play the card game Spades with other people from around the world.")
    			.elseif dwGames == ID_GAME_MINE
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Begins a game of Minesweeper.")
    			.elseif dwGames == ID_GAME_PINBALL
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Begins a game of 3-D Pinball.")
    			.elseif dwGames == ID_GAME_SOLTAIRE
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Begins the Solitaire card game.")
    			.elseif dwGames == ID_GAME_SPIDY
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Begins the Spider Solitaire card game.")
    			.endif			
    		.endif
    	;Misc apps combo selection change so as to fill app description	
    	.elseif ax == IDC_CB4
    	    SHR eax,16
    		.if ax == CBN_SELCHANGE	
    		    invoke SendDlgItemMessage, hWnd,IDC_CB4,CB_GETCURSEL,NULL,NULL	
    			MOV dwMisc, eax
    			.if dwMisc == ID_MISC_ADDRESS
    			    invoke SetDlgItemText, hWnd, IDC_DES,SADD("Manages your contacts and finds people and businesses using directory services. ")
    			.elseif dwMisc == ID_MISC_CONTROL
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Windows Control Panel.")
    			.elseif dwMisc == ID_MISC_EXPLORER
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Microsoft Windows Explorer.")
    			.elseif dwMisc == ID_MISC_SETTINGTRANS
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Migrates files and settings from one computer to another.")
    			.elseif dwMisc == ID_MISC_HYPER
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Connects to other computers, Internet telnet sites, bulletin board systems, online services, and host computers using either a modem or a null-modem cable.")
    			.elseif dwMisc == ID_MISC_MAGNIFIER
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Enlarges selected text and other on-screen items for easier viewing.")
    			.elseif dwMisc == ID_MISC_NARRATOR
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Reads on-screen text, dialog boxes, menus, and buttons aloud if speakers or a sound output device is installed.")
    			.elseif dwMisc == ID_MISC_OSK
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Displays a keyboard that is controlled by a mouse or switch input device.")
    			.elseif dwMisc == ID_MISC_REMOTEDESKTOP
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Connect to a computer's desktop from a remote location, and run applications as if you were sitting at its console.")
    			.elseif dwMisc == ID_MISC_SYSINFO
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Display current System Information.")
    			.elseif dwMisc == ID_MISC_SYSRESTORE
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Restores system to chosen restore point")
    			.elseif dwMisc == ID_MISC_TASKMANAGER
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Control your applications and see the performance of your system.")
    			.elseif dwMisc == ID_MISC_TOUR
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Lets have a tour in and around the windows.")
    			.elseif dwMisc == ID_MISC_UPDATE
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Update your windows to prevent it from security holes and to update windows components.")
    			.elseif dwMisc == ID_MISC_WINVERSION
    				invoke SetDlgItemText, hWnd, IDC_DES,SADD("Forgot your windows version. No problem")
    			.endif	
    		.endif
		.endif
	.elseif uMsg == WM_CLOSE
		invoke EndDialog, hWnd, NULL
	.endif
	
	xor eax, eax				 
	Ret
DlgProc EndP

end start	
	 