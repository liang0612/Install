!addincludedir "include" ;��Ӳ��Ŀ¼


!ifndef NSIS_UNICODE
!AddPluginDir .\Plugins
!else
!AddPluginDir .\Unicode
!endif

Var MSG     ;MSG�������붨�壬��������ǰ�棬����WndProc::onCallback���������������Ҫ�����Ϣ����,���ڼ�¼��Ϣ��Ϣ
Var Dialog  ;Dialog����Ҳ��Ҫ���壬��������NSISĬ�ϵĶԻ���������ڱ��洰���пؼ�����Ϣ

Var BGImage  ;����Сͼ
Var ImageHandle

Var BGImageLong  ;������ͼ
Var ImageHandleLong

Var AirBubblesImage ;��װ������������ʾͼƬ
Var AirBubblesHandle

Var btn_Close ;�رհ�ť
Var btn_instetup ;������װ��ť
Var btn_ins ; �Զ��尲װ��ť
Var btn_instend ;��������
var cbk_license ;��װЭ�鹴ѡ��
Var Txt_Xllicense ;��װЭ�鳬�����ı�
Var page1HNW ; ��һ��ҳ����
Var flag ;��־λ �����л�����Զ��尴ťʱ���ֵı仯
Var txb_AppFolder ;��װĿ¼�ı���
Var AppFolder ;��װĿ¼
Var AppSourceFolder ;�ĵ���װĿ¼
var btn_browse
Var txt_FileSize ;����ռ��СMb
Var txt_AvailableSpace ;���ÿռ�Gb
var txt_installDir ;��װĿ¼
Var tex_installOptions ;��װѡ��
Var ckb_cocos2d ;Cocos2d��ѡ��
Var ckb_CocosStudio ;CocosStudio ��ѡ��
Var ccstemp
Var tex_Install ;��װ�ı�
Var PB_ProgressBar
Var txt_installProgress ;��װ�����ı�

;---------------------------ȫ�ֱ���ű�Ԥ����ĳ���-----------------------------------------------------
!define PRODUCT_NAME "Cocos"
!define PRODUCT_VERSION "3.10"
!define PRODUCT_PUBLISHER "Cocos"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

;---------------------------�������ѹ�����ͣ�Ҳ����ͨ���������ű����ƣ�------------------------------------
SetCompressor lzma
SetCompress force

;Ӧ�ó�����ʾ����
Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
;Ӧ�ó�������ļ���
OutFile "${PRODUCT_NAME} ${PRODUCT_VERSION}.exe"
;��װ·��
!define DIR "C:\${PRODUCT_NAME}" ;�������ﶨ��·��
InstallDir "${DIR}"
InstallDirRegKey HKLM "${PRODUCT_UNINST_KEY}" "UninstallString"
ShowInstDetails nevershow ;�����Ƿ���ʾ��װ��ϸ��Ϣ��
ShowUnInstDetails nevershow ;�����Ƿ���ʾɾ����ϸ��Ϣ��

;MUI Ԥ���峣��
!define MUI_ABORTWARNING ;�˳���ʾ

;!define MUI_CUSTOMFUNCTION_ABORT ABORT
;MUI_CUSTOMFUNCTION_ABORT

;��װͼ���·������
!define MUI_ICON "Icon\Cocos_Setup.ico"
;ж��ͼ���·������
!define MUI_UNICON "Icon\Uninstall.ico"
;ʹ�õ�UI
!define MUI_UI "UI\mod.exe"

;ʹ��ReserveFile�Ǽӿ찲װ��չ���ٶȣ������뿴����
ReserveFile "images\CocosBG.png"
ReserveFile "images\close.bmp"
ReserveFile "images\browse.bmp"
ReserveFile "images\custom.bmp"
ReserveFile "images\install.bmp"
ReserveFile "images\CocosBG_long.bmp"
ReserveFile "images\empty_bg.bmp"
ReserveFile "images\full_bg.bmp"
ReserveFile "images\express.bmp"
ReserveFile "images\AirBubbles.bmp"
ReserveFile "images\successful.bmp"
ReserveFile "images\ck1.bmp"
ReserveFile "images\ck1_1.bmp"
ReserveFile "images\cktrue.bmp"
ReserveFile "images\ckfalse.bmp"
;DLL
ReserveFile `${NSISDIR}\Plugins\nsDialogs.dll`
ReserveFile `${NSISDIR}\Plugins\nsWindows.dll`
ReserveFile `${NSISDIR}\Plugins\SkinBtn.dll`
ReserveFile `${NSISDIR}\Plugins\SkinButton.dll`
ReserveFile `${NSISDIR}\Plugins\SkinProgress.dll`
ReserveFile `${NSISDIR}\Plugins\System.dll`
ReserveFile `${NSISDIR}\Plugins\WndProc.dll`
ReserveFile `${NSISDIR}\Plugins\nsisSlideshow.dll`
ReserveFile `${NSISDIR}\Plugins\FindProcDLL.dll`
ReserveFile `${NSISDIR}\Plugins\Resource.dll`
ReserveFile `${NSISDIR}\Plugins\nsResize.dll`
ReserveFile `${NSISDIR}\Plugins\nsResize.dll`


; ------ MUI �ִ����涨�� (1.67 �汾���ϼ���) ------
!include "MUI.nsh"
!include "WinCore.nsh"
!include "nsWindows.nsh"
!include "LogicLib.nsh"
!include "WinMessages.nsh"
!include "LoadRTF.nsh"
!include "nsResize.nsh"

!include "nsDialogs_createTextMultiline.nsh"
!include "LogicLib.nsh"

!define MUI_CUSTOMFUNCTION_GUIINIT onGUIInit
;�Զ���ҳ��
Page custom  Page.1 Page.1leave
;Page instfiles InstFilesPageShow
; ��װ����ҳ��
Page custom InstFilesPageShow
;!define MUI_PAGE_CUSTOMFUNCTION_SHOW InstFilesPageShow
;!insertmacro MUI_PAGE_INSTFILES

; ��װ���ҳ��
Page custom InstallFinish

# �Զ���ж�ؽ��� Custom UninstPage
UninstPage custom un.UnPageWelcome
;ж�ط���ҳ��
UninstPage custom un.FeedbackPage
UninstPage custom un.InstallFiles
Uninstpage custom un.InstallFinish

; ��װ�����������������
!insertmacro MUI_LANGUAGE "SimpChinese"


!macro __ChangeWindowSize width hight
	${NSW_SetWindowSize} $HWNDPARENT ${width} ${hight}
  System::Alloc 16
  System::Call user32::GetWindowRect(i$HWNDPARENT,isR0)
  System::Call *$R0(i.R1,i.R2,i.R3,i.R4)
  IntOp $R3 $R3 - $R1
  IntOp $R4 $R4 - $R2
  System::Call gdi32::CreateRoundRectRgn(i0,i0,iR3,iR4,i4,i4)i.r0
  System::Call user32::SetWindowRgn(i$HWNDPARENT,ir0,i1)
  System::Free $R0
!macroend

!macro __CustomSetFont controlHWD FontName Size weight
		CreateFont $R1 ${FontName} ${Size} ${weight}
		SendMessage ${controlHWD} ${WM_SETFONT} $R1 1
!macroend

;�ƶ��ؼ�λ��
!macro __MoveControl controlHWD x y
	nsResize::GetPos ${controlHWD}
	Pop $R1
	Pop $R2
	nsResize::GetSize ${controlHWD}
	Pop $0
	Pop $1
	IntOp $0 $0 - $R1
	IntOp $1 $1 - $R2
	IntOp $R1 $R1 + ${x}
	IntOp $R2 $R2 + ${y}

	nsResize::Set ${controlHWD} $R1 $R2 $0 $1
!macroend

!define ChangeWindowSize `!insertmacro __ChangeWindowSize`
!define CustomSetFont `!insertmacro __CustomSetFont`
!define MoveControlPositon `!insertmacro __MoveControl`

Function .onInit
    InitPluginsDir ;��ʼ�����
    File `/ONAME=$PLUGINSDIR\bg.bmp` `images\CocosBG.bmp` ;��һ�󱳾�CocosBG_long.bmp
		File `/ONAME=$PLUGINSDIR\bgLong.bmp` `images\CocosBG_long.bmp` ;��һ�󱳾�
    
    File `/oname=$PLUGINSDIR\btn_install.bmp` `images\install.bmp` ;������װ
		File `/oname=$PLUGINSDIR\browse.bmp` `images\browse.bmp` ;�����ť����
    File `/oname=$PLUGINSDIR\btn_Close.bmp` `images\Close.bmp` ;�ر�
    File `/oname=$PLUGINSDIR\btn_custom.bmp` `images\custom.bmp`  ;�Զ��尲װ
    File `/oname=$PLUGINSDIR\btn_express.bmp` `images\express.bmp` ;��������
    File `/oname=$PLUGINSDIR\AirBubbles.bmp` `images\AirBubbles.bmp` ;��������
    ;������Ƥ��
	  File `/oname=$PLUGINSDIR\Progress.bmp` `images\empty_bg.bmp`
  	File `/oname=$PLUGINSDIR\ProgressBar.bmp` `images\full_bg.bmp`
   	File `/oname=$PLUGINSDIR\successful.bmp` `images\successful.bmp`
  	
    ;��ʼ��
    SkinBtn::Init "$PLUGINSDIR\btn_strongbtn.bmp"
    SkinBtn::Init "$PLUGINSDIR\btn_Close.bmp"
		SkinBtn::Init "$PLUGINSDIR\btn_custom.bmp"
		SkinBtn::Init "$PLUGINSDIR\btn_install.bmp"
		SkinBtn::Init "$PLUGINSDIR\btn_express.bmp"
		SkinBtn::Init "$PLUGINSDIR\browse.bmp"
FunctionEnd

Function onGUIInit
	;����ظ�����
  System::Call 'kernel32::CreateMutexA(i 0, i 0, t "CocosInstall") i .r1 ?e'
  Pop $R1																																		 ;;;;$$$$$��װ�����Ѿ�����
  StrCmp $R1 0 +3
  MessageBox MB_OK|MB_ICONINFORMATION|MB_TOPMOST "�����Ѿ������С�"
  Abort

  ;����Ƿ���������
  RETRY:
  FindProcDLL::FindProc "CocosInstall.exe" ;�������н�������
  StrCmp $R0 1 0 +3
  MessageBox MB_RETRYCANCEL|MB_ICONINFORMATION|MB_TOPMOST '��⵽ "${PRODUCT_NAME}" ��������,���ȹرպ����ԣ����ߵ��"ȡ��"�˳�!' IDRETRY RETRY
	Quit
 ;�����߿�
    System::Call `user32::SetWindowLong(i$HWNDPARENT,i${GWL_STYLE},0x9480084C)i.R0`
    ;����һЩ���пؼ�
    GetDlgItem $0 $HWNDPARENT 1034
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1035
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1036
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1037
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1038
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1039
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1256
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1028
    ShowWindow $0 ${SW_HIDE}

    ${NSW_SetWindowSize} $HWNDPARENT 600 480 ;�ı��������С
    System::Call User32::GetDesktopWindow()i.R0

		Push "C:\Cocos"
		Pop $AppFolder
    ;Բ��
    System::Alloc 16
  	System::Call user32::GetWindowRect(i$HWNDPARENT,isR0)
  	System::Call *$R0(i.R1,i.R2,i.R3,i.R4)
  	IntOp $R3 $R3 - $R1
  	IntOp $R4 $R4 - $R2
  	System::Call gdi32::CreateRoundRectRgn(i0,i0,iR3,iR4,i4,i4)i.r0
  	System::Call user32::SetWindowRgn(i$HWNDPARENT,ir0,i1)
  	System::Free $R0
FunctionEnd

;�����ޱ߿��ƶ�
Function onGUICallback
  ${If} $MSG = ${WM_LBUTTONDOWN}
    SendMessage $HWNDPARENT ${WM_NCLBUTTONDOWN} ${HTCAPTION} $0
  ${EndIf}
FunctionEnd

Function show
  ebanner::show /NOUNLOAD /HALIGN=LEFT /VALIGN=BOTTOM "$PLUGINSDIR\Transbg.png"
FunctionEnd

Function Page.1

    GetDlgItem $0 $HWNDPARENT 1
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 2
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 3
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1990
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1991
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1992
    ShowWindow $0 ${SW_HIDE}

    nsDialogs::Create 1044
    Pop $page1HNW
    ${If} $page1HNW == error
        Abort
    ${EndIf}
    SetCtlColors $page1HNW ""  transparent ;�������͸��

    ${NSW_SetWindowSize} $page1HNW 600 630 ;�ı�Page��С
    
    ;�Զ��尲װ��ť
    ${NSD_CreateButton} 480 435 92 16 ""
    Pop $btn_ins
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_custom.bmp $btn_ins
    GetFunctionAddress $3 onCustonClick
    SkinBtn::onClick $btn_ins $3
    
    ;������װ
    ${NSD_CreateButton} 210 350 180 48 ""
    Pop $btn_instetup
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_install.bmp $btn_instetup
    GetFunctionAddress $3 onClickins
    SkinBtn::onClick $btn_instetup $3
    SetCtlColors $btn_instetup FFFFFF transparent
    
    ;�رհ�ť
    ${NSD_CreateButton} 576 8 24 20 ""
    Pop $btn_Close
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_Close.bmp $btn_Close
    GetFunctionAddress $3 ABORT
    SkinBtn::onClick $btn_Close $3
#------------------------------------------
#�Զ���չ��֮��Ŀؼ�
#------------------------------------------
    ${NSD_CreateLabel} 20 436 80 25 "��װĿ¼ :"
    Pop $txt_installDir
    SetCtlColors $txt_installDir 363636 FFFFFF
		${CustomSetFont} $txt_installDir "΢���ź�" 12 550
		ShowWindow $txt_installDir ${SW_HIDE}
		
		;��װĿ¼�ı���
		${NSD_CreateText} 100 435 334 25 "C:\Cocos"
		Pop $txb_AppFolder
		SetCtlColors $txb_AppFolder 363636 FFFFFF
		${CustomSetFont} $txb_AppFolder "΢���ź�" 12 550
		${NSD_SetText} $txb_AppFolder $AppFolder
		ShowWindow $txb_AppFolder ${SW_HIDE}
		
		;�����ť
		${NSD_CreateButton} 442 435 60 25 ""
    Pop $btn_browse
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_browse.bmp $btn_browse
    ${NSD_OnClick} $btn_browse SelectAppFolder
		ShowWindow $btn_browse ${SW_HIDE}
		
    ${NSD_CreateLabel} 100 472 180 25 "����ռ� : 141.1MB"
    Pop $txt_FileSize
    SetCtlColors $txt_FileSize 363636 FFFFFF
		${CustomSetFont} $txt_FileSize "΢���ź�" 10 550
		ShowWindow $txt_FileSize ${SW_HIDE}

    ${NSD_CreateLabel} 280 472 200 25 "���ÿռ� : 10.14GB"
    Pop $txt_AvailableSpace
    SetCtlColors $txt_AvailableSpace 363636 FFFFFF
		${CustomSetFont} $txt_AvailableSpace "΢���ź�" 10 550
		ShowWindow $txt_AvailableSpace ${SW_HIDE}
		
		${NSD_CreateLabel} 20 497 80 25 "��װѡ�� :"
    Pop $tex_installOptions
    SetCtlColors $tex_installOptions 363636 FFFFFF
		${CustomSetFont} $tex_installOptions "΢���ź�" 12 550
		ShowWindow $tex_installOptions ${SW_HIDE}
		
		${NSD_CreateCheckbox} 100 520 300 25 " ���		Cocos2d-x"
    Pop $ckb_cocos2d
    SetCtlColors $ckb_cocos2d "" FFFFFF
    ${NSD_Check} $ckb_cocos2d
		${CustomSetFont} $ckb_cocos2d "΢���ź�" 10 550
		ShowWindow $ckb_cocos2d ${SW_HIDE}
    EnableWindow $ckb_cocos2d 0
    
		${NSD_CreateCheckbox} 100 547 300 25 " �༭��		CocosStudio"
    Pop $ckb_CocosStudio
    SetCtlColors $ckb_CocosStudio "" FFFFFF
    ${NSD_Check} $ckb_CocosStudio
		${CustomSetFont} $ckb_CocosStudio "΢���ź�" 10 550
		ShowWindow $ckb_CocosStudio ${SW_HIDE}
#------------------------------------------
#���Э��
#------------------------------------------
    ${NSD_CreateCheckbox} 20 432 100 20 "���Ķ���ͬ��"
    Pop $cbk_license
    SetCtlColors $cbk_license "" FFFFFF
    ${NSD_Check} $cbk_license
    ${NSD_OnClick} $cbk_license Chklicense
    
    ${NSD_CreateLink} 124 435 100 16 "Cocos��������"
    Pop $Txt_Xllicense
    SetCtlColors $Txt_Xllicense 0074F3 FFFFFF
    ${NSD_OnClick} $Txt_Xllicense xllicense

    ${NSD_CreateBitmap} 0 0 100% 100% ""
    Pop $BGImageLong
    ${NSD_SetImage} $BGImageLong $PLUGINSDIR\bgLong.bmp $ImageHandleLong
    ShowWindow $BGImageLong ${SW_HIDE}

    ;��������ͼ
    ${NSD_CreateBitmap} 0 0 100% 100% ""
    Pop $BGImage
    ${NSD_SetImage} $BGImage $PLUGINSDIR\bg.bmp $ImageHandle

    GetFunctionAddress $0 onGUICallback
    WndProc::onCallback $BGImage $0 ;�����ޱ߿����ƶ�
    WndProc::onCallback $BGImageLong $0 ;�����ޱ߿����ƶ�
		nsDialogs::Show
FunctionEnd

Function Page.1leave
	${NSD_GetText} $txb_AppFolder  $R0  ;������õİ�װ·��

   ;�ж�Ŀ¼�Ƿ���ȷ
	ClearErrors
	CreateDirectory "$R0"
	IfErrors 0 +3
  MessageBox MB_ICONINFORMATION|MB_OK "'$R0' ��װĿ¼�����ڣ����������á�"
  Return
	StrCpy $INSTDIR  $R0
FunctionEnd

Function InstFilesPageShow
  	GetDlgItem $0 $HWNDPARENT 1
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 2
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 3
    ShowWindow $0 ${SW_HIDE}
    nsDialogs::Create 1044
    Pop $0
    ${If} $0 == error
        Abort
    ${EndIf}
    SetCtlColors $0 ""  transparent ;�������͸��

    System::Call "user32::MoveWindow(i $0, i 0, i 0, i 600, i 480) i r2"

		${NSD_CreateProgressBar} 70 380 460 12 ""
    Pop $PB_ProgressBar
	  SkinProgress::Set $PB_ProgressBar "$PLUGINSDIR\ProgressBar.bmp" "$PLUGINSDIR\Progress.bmp"

    ${NSD_CreateButton} 50 350 42 31 "100%"
    Pop $AirBubblesImage
    SkinBtn::Set /IMGID=$PLUGINSDIR\AirBubbles.bmp $AirBubblesImage
    SetCtlColors $AirBubblesImage 4691f8 transparent
		${CustomSetFont} $AirBubblesImage "Arial" 10 400
		
    ${NSD_CreateBitmap} 0 0 100% 100% ""
    Pop $BGImage
    ${NSD_SetImage} $BGImage $PLUGINSDIR\bg.bmp $ImageHandle

    GetFunctionAddress $0 NSD_TimerFun
    nsDialogs::CreateTimer $0 1
    
    GetFunctionAddress $0 AirBubblesPosition
    nsDialogs::CreateTimer $0 1
    
    GetFunctionAddress $0 onGUICallback
    WndProc::onCallback $BGImage $0 ;�����ޱ߿����ƶ�
    nsDialogs::Show
    ${NSD_FreeImage} $ImageHandle

FunctionEnd

Var proPosition
Function AirBubblesPosition
	SendMessage $PB_ProgressBar ${PBM_GETPOS} 0 0 $0
	${IF} $proPosition < $0
		IntOp $proPosition $0 + 0
		${NSD_SetText} $AirBubblesImage "$0%"
		IntOp $0 $0 * 46
		IntOp $0 $0 / 10
		IntOp $0 $0 + 48
	  nsResize::Set $AirBubblesImage $0 350 45 31
	${EndIf}
	
FunctionEnd

Function NSD_TimerFun
    GetFunctionAddress $0 NSD_TimerFun
    nsDialogs::KillTimer $0
    !if 1   ;�Ƿ��ں�̨����,1��Ч
        GetFunctionAddress $0 InstallationMainFun
        BgWorker::CallAndWait
    !else
        Call InstallationMainFun
    !endif
FunctionEnd

Function InstallationMainFun
 		;Call NextPage
    ;SetOutPath $INSTDIR
    SendMessage $PB_ProgressBar ${PBM_SETRANGE32} 0 100
    Sleep 1000
    SendMessage $PB_ProgressBar ${PBM_SETPOS} 10 0
  	;File "F:\Work3.0\Mono_3.0\build\Builder\*.*"
  	;SetOutPath "$DOCUMENTS\Cocos1"
  	;File "F:\Work3.0\Mono_3.0\build\Builder\*.*"
  	Sleep 1000
  	SendMessage $PB_ProgressBar ${PBM_SETPOS} 20 0
  	Sleep 1000
  	SendMessage $PB_ProgressBar ${PBM_SETPOS} 30 0
  	Sleep 1000
  	SendMessage $PB_ProgressBar ${PBM_SETPOS} 40 0
  	Sleep 1000
  	SendMessage $PB_ProgressBar ${PBM_SETPOS} 50 0
  	Sleep 1000
  	SendMessage $PB_ProgressBar ${PBM_SETPOS} 60 0
  	Sleep 1000
  	SendMessage $PB_ProgressBar ${PBM_SETPOS} 70 0
  	Sleep 1000
  	SendMessage $PB_ProgressBar ${PBM_SETPOS} 80 0
  	Sleep 1000
  	SendMessage $PB_ProgressBar ${PBM_SETPOS} 90 0
  	Sleep 1000
    SendMessage $PB_ProgressBar ${PBM_SETPOS} 100 0
    WriteUninstaller "$INSTDIR\uninst.exe"
    Call NextPage
FunctionEnd

;��װ���ҳ��
Function InstallFinish
  	GetDlgItem $0 $HWNDPARENT 1
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 2
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 3
    ShowWindow $0 ${SW_HIDE}


    nsDialogs::Create 1044
    Pop $0
    ${If} $0 == error
        Abort
    ${EndIf}
    SetCtlColors $0 ""  transparent ;�������͸��

    ${NSW_SetWindowSize} $0 600 480 ;�ı�Page��С

    ;��������
    ${NSD_CreateButton} 210 380 180 48 ""
    Pop $btn_instend
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_express.bmp $btn_instend
    GetFunctionAddress $3 onClickexpress
    SkinBtn::onClick $btn_instend $3
    
    ${NSD_CreateBitmap} 234 335 24 24 ""
		Pop $0
		${NSD_SetImage} $0 $PLUGINSDIR\successful.bmp $1

		${NSD_CreateLabel} 266 328 200 50 "��װ�ɹ�!"
		Pop $0
		SetCtlColors $0 363636 FFFFFF
		${CustomSetFont} $0 "΢���ź�" 18 400
		
		;�Զ��尲װ��ť
    ${NSD_CreateButton} 488 436 92 16 ""
    Pop $btn_ins
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_custom.bmp $btn_ins
    GetFunctionAddress $3 OpenFolder
    SkinBtn::onClick $btn_ins $3
    
    ;��������ͼ
    ${NSD_CreateBitmap} 0 0 100% 100% ""
    Pop $BGImage
    ${NSD_SetImage} $BGImage $PLUGINSDIR\bg.bmp $ImageHandle

    GetFunctionAddress $0 onGUICallback
    WndProc::onCallback $BGImage $0 ;�����ޱ߿����ƶ�
    nsDialogs::Show

    ${NSD_FreeImage} $ImageHandle
FunctionEnd

Function Page.4

FunctionEnd

Function ABORT
	MessageBox MB_ICONQUESTION|MB_YESNO|MB_ICONSTOP '��ȷ��Ҫ��Cocos��װ����' IDNO CANCEL
	SendMessage $hwndparent ${WM_CLOSE} 0 0
	CANCEL:
	Abort
FunctionEnd

Function onClickins
 MessageBox MB_OK $DOCUMENTS
	Call NextPage
FunctionEnd

Function SelectAppFolder
	nsDialogs::SelectFolderDialog /NOUNLOAD "ѡ��Cocos2d��װĿ¼" $AppFolder
	Pop $0
	${If} $0 != "error"
		Push $0
		Pop $AppFolder
	${EndIf}
	${NSD_SetText} $txb_AppFolder $AppFolder
FunctionEnd

;����ҳ����ת������
Function RelGotoPage
  IntCmp $R9 0 0 Move Move
    StrCmp $R9 "X" 0 Move
      StrCpy $R9 "120"
  Move:
  SendMessage $HWNDPARENT "0x408" "$R9" ""
FunctionEnd

Function NextPage
  StrCpy $R9 1 ;Goto the next page
  Call RelGotoPage
  Abort
FunctionEnd

;�Զ��尲װ��ť�������
Function onCustonClick
	${If} $flag == "True"
		${ChangeWindowSize} 600 480
		ShowWindow $BGImageLong ${SW_HIDE}
		ShowWindow $BGImage ${SW_SHOW}
		
		ShowWindow $txt_installDir ${SW_HIDE}
    ShowWindow $txb_AppFolder ${SW_HIDE}
    ShowWindow $btn_browse ${SW_HIDE}
    ShowWindow $txt_FileSize ${SW_HIDE}
    ShowWindow $txt_AvailableSpace ${SW_HIDE}
    ShowWindow $tex_installOptions ${SW_HIDE}
    ShowWindow $ckb_cocos2d ${SW_HIDE}
    ShowWindow $ckb_CocosStudio ${SW_HIDE}
 		nsResize::Set $btn_ins 480 435 92 16
 		nsResize::Set $cbk_license 20 432 100 20
 		nsResize::Set $Txt_Xllicense 124 435 100 16
 		Push "False"
		Pop $flag
	${Else}
		${ChangeWindowSize} 600 630
		ShowWindow $BGImage ${SW_HIDE}
		ShowWindow $BGImageLong ${SW_SHOW}
		
		ShowWindow $txt_installDir ${SW_SHOW}
    ShowWindow $txb_AppFolder ${SW_SHOW}
    ShowWindow $btn_browse ${SW_SHOW}
    ShowWindow $txt_FileSize ${SW_SHOW}
    ShowWindow $txt_AvailableSpace ${SW_SHOW}
    ShowWindow $tex_installOptions ${SW_SHOW}
    ShowWindow $ckb_cocos2d ${SW_SHOW}
    ShowWindow $ckb_CocosStudio ${SW_SHOW}
 		nsResize::Set $btn_ins 480 585 92 16
 		nsResize::Set $cbk_license 20 582 100 20
 		nsResize::Set $Txt_Xllicense 124 585 100 16

 		Push "True"
 		Pop $flag
	${EndIf}
FunctionEnd

;�򿪰�װĿ¼
Function OpenFolder
  ExecShell "open" $INSTDIR
FunctionEnd

Function Chklicense
 Pop $cbk_license
  ${NSD_GetState} $cbk_license $0
  ${If} $0 == 1
    EnableWindow $btn_instetup 1 ;��ָ���Ĵ��ڻ�ؼ��Ƿ��������0��ֹ
    EnableWindow $btn_ins 1
  ${Else}
    EnableWindow $btn_instetup 0 ;��ָ���Ĵ��ڻ�ؼ��Ƿ��������0��ֹ
    EnableWindow $btn_ins 0
  ${EndIf}
FunctionEnd

;�������鰴ť�������
Function onClickexpress
	MessageBox MB_OK '����Cocos'
	ABORT
FunctionEnd

Function xllicense
  ExecShell "open" "http://api.cocos.com/cn/LICENSE%20AGREEMENT%20CN.pdf"
FunctionEnd

Section "-LogSetOn"
  LogSet on
SectionEnd

Section MainSetup
DetailPrint "��װCocos��..."
Sleep 1000
SetDetailsPrint None ;����ʾ��Ϣ
nsisSlideshow::Show /NOUNLOAD /auto=$PLUGINSDIR\Slides.dat
Sleep 500 ;�ڰ�װ��������ִͣ�� "����ʱ��(��λΪ:ms)" ���롣"����ʱ��(��λΪ:ms)" ������һ�������� ���� "$0" ��һ�����֣����� "666"��
SetOutPath $INSTDIR
;File /r "Thunder Network\*.*"
SendMessage $PB_ProgressBar ${PBM_SETRANGE} 0 100
    SendMessage $PB_ProgressBar ${PBM_SETPOS} 10 0
    Sleep 1000
    SendMessage $PB_ProgressBar ${PBM_SETPOS} 20 0
    Sleep 1000
    SendMessage $PB_ProgressBar ${PBM_SETPOS} 30 0
    Sleep 1000
    SendMessage $PB_ProgressBar ${PBM_SETPOS} 40 0
    Sleep 1000
    SendMessage $PB_ProgressBar ${PBM_SETPOS} 50 0
    Sleep 1000
    SendMessage $PB_ProgressBar ${PBM_SETPOS} 60 0
    Sleep 1000
    SendMessage $PB_ProgressBar ${PBM_SETPOS} 70 0
    Sleep 1000
    SendMessage $PB_ProgressBar ${PBM_SETPOS} 80 0
    Sleep 1000
    SendMessage $PB_ProgressBar ${PBM_SETPOS} 90 0
    Sleep 1000
    SendMessage $PB_ProgressBar ${PBM_SETPOS} 100 0

Sleep 50
Sleep 50
Sleep 50
Sleep 500
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 500
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 500
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 500
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 50
/*
    ${If} $Ckbox1_State == 1
    DetailPrint "������ѡ��״̬���������д����"
    ${EndIf}
*/
nsisSlideshow::Stop
SetAutoClose true
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe" ;����ж���ļ�
SectionEnd

;ж��ҳ�����
Var toolTipText
Var ck1
Var ck1Text
Var ck1Flag

Var ck2
Var ck2Text
Var ck2Flag

Var ck3
Var ck3Text
Var ck3Flag

Var ck4
Var ck4Text
Var ck4Flag

Var ck5
Var ck5Text
Var ck5Flag

Var ck6
Var ck6Text
Var ck6Flag

Var ck7
Var ck7Text
Var ck7Flag

Var ck8
Var ck8Text
Var ck8Flag

Var otherText

Function un.onInit
    InitPluginsDir ;��ʼ�����
    File `/ONAME=$PLUGINSDIR\bg.bmp` `images\UnPageBG.bmp` ;ж��ҳ�汳��
    File `/ONAME=$PLUGINSDIR\logo.bmp` `images\UninstallLogo.bmp`
    File `/ONAME=$PLUGINSDIR\ck1.bmp` `images\ck1.bmp`
    File `/ONAME=$PLUGINSDIR\ck1_1.bmp` `images\ck1_1.bmp`
    File `/ONAME=$PLUGINSDIR\ck1.png` `images\ck1.png`
    File `/ONAME=$PLUGINSDIR\ck1_1.png` `images\ck1_1.png`
    
    File `/ONAME=$PLUGINSDIR\cktrue.bmp` `images\cktrue.bmp`
    File `/ONAME=$PLUGINSDIR\ckfalse.bmp` `images\ckfalse.bmp`
    File /oname=$PLUGINSDIR\button1.png images\button1.png
    File /oname=$PLUGINSDIR\Cocos.vsf "Skin\Cocos.vsf"
  	NSISVCLStyles::LoadVCLStyle  $PLUGINSDIR\Cocos.vsf
  	SkinBtn::Init "$PLUGINSDIR\ck1.bmp"
  	SkinBtn::Init "$PLUGINSDIR\ck1_1.bmp"
FunctionEnd

Function un.onGUIInit
  System::Call `user32::SetWindowLong(i$HWNDPARENT,i${GWL_STYLE},0x9480084C)i.R0`
    ;����һЩ���пؼ�
    GetDlgItem $0 $HWNDPARENT 1034
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1035
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1036
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1037
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1038
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1039
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1256
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1028
    ShowWindow $0 ${SW_HIDE}
	
    ${NSW_SetWindowSize} $HWNDPARENT 520 400 ;�ı��������С
    System::Call User32::GetDesktopWindow()i.R0
    ;Բ��
    System::Alloc 16
  	System::Call user32::GetWindowRect(i$HWNDPARENT,isR0)
  	System::Call *$R0(i.R1,i.R2,i.R3,i.R4)
  	IntOp $R3 $R3 - $R1
  	IntOp $R4 $R4 - $R2
  	System::Call gdi32::CreateRoundRectRgn(i0,i0,iR3,iR4,i4,i4)i.r0
  	System::Call user32::SetWindowRgn(i$HWNDPARENT,ir0,i1)
  	System::Free $R0
FunctionEnd

;ж�ػ�ӭҳ��
Function un.UnPageWelcome
  GetDlgItem $0 $HWNDPARENT 1 ;��һ��/�ر� ��ť
  ShowWindow $0 ${SW_HIDE}    ;����
  GetDlgItem $0 $HWNDPARENT 2 ;ȡ�� ��ť
  ShowWindow $0 ${SW_HIDE}
  GetDlgItem $0 $HWNDPARENT 3 ;��һ�� ��ť
  ShowWindow $0 ${SW_HIDE}    ;����

  GetDlgItem $0 $HWNDPARENT 1990
  ShowWindow $0 ${SW_HIDE}
  GetDlgItem $0 $HWNDPARENT 1991
  ShowWindow $0 ${SW_HIDE}
  GetDlgItem $0 $HWNDPARENT 1992
  ShowWindow $0 ${SW_HIDE}
  
  nsDialogs::Create /NOUNLOAD 1044
  Pop $0
  ${If} $0 == error
    Abort
  ${EndIf}
  SetCtlColors $0 ""  transparent ;�������͸��
  ${NSW_SetWindowSize} $0 520 400 ;�ı�Page��С

  ${NSD_CreateLabel} 20 11 100 30 "Cocosж��"
  Pop $R1
	NSISVCLStyles::RemoveStyleControl $R1
  SetCtlColors $R1 fffffff transparent
	${CustomSetFont} $R1 "΢���ź�" 16 400
	GetFunctionAddress $0 un.onGUICallback
	WndProc::onCallback $R1 $0
	
  ${NSD_CreateButton} 50 50 100 40 "Button"
  Pop $1
  SetCtlColors $1 0xEFEFEF
  SkinButton::SetSkin $1 $PLUGINSDIR\button1.png
	NSISVCLStyles::RemoveStyleControl $1
  ${NSD_CreateLabel} 113 247 287 30 "��������ʲô,�ҸĻ�����ô?"
  Pop $toolTipText
  SetCtlColors $toolTipText fffffff transparent
	${CustomSetFont} $toolTipText "RTWSYueGoTrial-Regular" 18 400
	GetFunctionAddress $0 un.onGUICallback
	WndProc::onCallback $toolTipText $0
	NSISVCLStyles::RemoveStyleControl $toolTipText
	
	SetCtlColors $otherText b6d8fe 418BDB
	${CustomSetFont} $otherText "΢���ź�" 10 500

  ${NSD_CreateButton} 112 325 150 40 "����ж��"
  Pop $0
  NSISVCLStyles::RemoveStyleControl $0
  GetFunctionAddress $3 un.NextPage
	SkinBtn::onClick $0 $3

	
  ${NSD_CreateButton} 282 325 150 40 "��������"
  Pop $0
  NSISVCLStyles::RemoveStyleControl $0
  
	${NSD_CreateBitmap} 159 38 200 200 ""
	Pop $0
	${NSD_SetImage} $0 $PLUGINSDIR\logo.bmp $1
	
	GetFunctionAddress $3 un.onGUICallback
  WndProc::onCallback $0 $3 ;�����ޱ߿����ƶ�
  WndProc::onCallback $1 $3 ;�����ޱ߿����ƶ�
;��������ͼ
  ${NSD_CreateBitmap} 0 0 100% 100% ""
  Pop $BGImage
  ${NSD_SetImage} $BGImage $PLUGINSDIR\bg.bmp $ImageHandle
  
  GetFunctionAddress $0 un.onGUICallback
  WndProc::onCallback $BGImage $0 ;�����ޱ߿����ƶ�
  WndProc::onCallback $BGImageLong $0 ;�����ޱ߿����ƶ�
  nsDialogs::Show
FunctionEnd

Function un.FeedbackPage
  GetDlgItem $0 $HWNDPARENT 1 ;��һ��/�ر� ��ť
  ShowWindow $0 ${SW_HIDE}    ;����
  GetDlgItem $0 $HWNDPARENT 2 ;ȡ�� ��ť
  ShowWindow $0 ${SW_HIDE}
  GetDlgItem $0 $HWNDPARENT 3 ;��һ�� ��ť
  ShowWindow $0 ${SW_HIDE}    ;����

  GetDlgItem $0 $HWNDPARENT 1990
  ShowWindow $0 ${SW_HIDE}
  GetDlgItem $0 $HWNDPARENT 1991
  ShowWindow $0 ${SW_HIDE}
  GetDlgItem $0 $HWNDPARENT 1992
  ShowWindow $0 ${SW_HIDE}
 
  nsDialogs::Create /NOUNLOAD 1044
  Pop $0
  ${If} $0 == error
    Abort
  ${EndIf}

  ;SetCtlColors $0 ""  transparent ;�������͸��
  ${NSW_SetWindowSize} $0 520 400 ;�ı�Page��С

  ${NSD_CreateLabel} 20 11 100 30 "Cocosж��"
  Pop $R1
  NSISVCLStyles::RemoveStyleControl $R1
  SetCtlColors $R1 98c8fe transparent
	${CustomSetFont} $R1 "΢���ź�" 10 700
	;GetFunctionAddress $0 un.onGUICallback
	;WndProc::onCallback $R1 $0
	
	;����ѡ��--------------------------------------------------------------
	${NSD_CreateButton} 50 92 16 16 ""
  Pop $ck1
  NSISVCLStyles::RemoveStyleControl $ck1
  SkinBtn::Set /IMGID=$PLUGINSDIR\ckfalse.bmp $ck1
  GetFunctionAddress $2 un.ck1Click
  SkinBtn::onClick $ck1 $2
  ${NSD_CreateLabel} 76 90 124 20 "����ʹ��,Ҳ������ѧ"
  pop $ck1Text
  NSISVCLStyles::RemoveStyleControl $ck1Text
  SetCtlColors $ck1Text 98c8fe transparent
	${CustomSetFont} $ck1Text "΢���ź�" 10 700
	;GetFunctionAddress $0 un.MouseDown
	;WndProc::onCallback $ck1Text $0
	
	${NSD_CreateButton} 270 92 16 16 ""
  Pop $ck2
  NSISVCLStyles::RemoveStyleControl $ck2
  SkinBtn::Set /IMGID=$PLUGINSDIR\ckfalse.bmp $ck2
  GetFunctionAddress $2 un.ck2Click
  SkinBtn::onClick $ck2 $2
	${NSD_CreateLabel} 296 90 130 20 "����bug,��������"
  pop $ck2Text
  NSISVCLStyles::RemoveStyleControl $ck2Text
  SetCtlColors $ck2Text 98c8fe transparent
	${CustomSetFont} $ck2Text "΢���ź�" 10 700

	${NSD_CreateButton} 50 122 16 16 ""
  Pop $ck3
  NSISVCLStyles::RemoveStyleControl $ck3
  SkinBtn::Set /IMGID=$PLUGINSDIR\ckfalse.bmp $ck3
  GetFunctionAddress $2 un.ck3Click
  SkinBtn::onClick $ck3 $2
	${NSD_CreateLabel} 76 120 130 20 "���治�Ѻ�,������"
  pop $ck3Text
  NSISVCLStyles::RemoveStyleControl $ck3Text
  SetCtlColors $ck3Text 98c8fe transparent
	${CustomSetFont} $ck3Text "΢���ź�" 10 700

	${NSD_CreateButton} 270 122 16 16 ""
  Pop $ck4
  NSISVCLStyles::RemoveStyleControl $ck4
  SkinBtn::Set /IMGID=$PLUGINSDIR\ckfalse.bmp $ck4
  GetFunctionAddress $2 un.ck4Click
  SkinBtn::onClick $ck4 $2
	${NSD_CreateLabel} 296 120 130 20 "���ܲ�����"
  pop $ck4Text
  NSISVCLStyles::RemoveStyleControl $ck4Text
  SetCtlColors $ck4Text 98c8fe transparent
	${CustomSetFont} $ck4Text "΢���ź�" 10 700

	${NSD_CreateButton} 50 154 16 16 ""
  Pop $ck5
  NSISVCLStyles::RemoveStyleControl $ck5
  SkinBtn::Set /IMGID=$PLUGINSDIR\ckfalse.bmp $ck5
  GetFunctionAddress $2 un.ck5Click
  SkinBtn::onClick $ck5 $2
	${NSD_CreateLabel} 76 152 130 20 "�ڿ����в����ܰﵽ��"
  pop $ck5Text
  NSISVCLStyles::RemoveStyleControl $ck5Text
  SetCtlColors $ck5Text 98c8fe transparent
	${CustomSetFont} $ck5Text "΢���ź�" 10 700

	${NSD_CreateButton} 270 154 16 16 ""
  Pop $ck6
  NSISVCLStyles::RemoveStyleControl $ck6
  SkinBtn::Set /IMGID=$PLUGINSDIR\ckfalse.bmp $ck6
  GetFunctionAddress $2 un.ck6Click
  SkinBtn::onClick $ck6 $2
	${NSD_CreateLabel} 296 152 130 20 "��������ͬ���Ʒ"
  pop $ck6Text
  NSISVCLStyles::RemoveStyleControl $ck6Text
  SetCtlColors $ck6Text 98c8fe transparent
	${CustomSetFont} $ck6Text "΢���ź�" 10 700

	${NSD_CreateButton} 50 192 16 16 ""
  Pop $ck7
  NSISVCLStyles::RemoveStyleControl $ck7
  SkinBtn::Set /IMGID=$PLUGINSDIR\ckfalse.bmp $ck7
  GetFunctionAddress $2 un.ck7Click
  SkinBtn::onClick $ck7 $2
	${NSD_CreateLabel} 76 190 130 20 "����ԭ��"
  pop $ck7Text
  NSISVCLStyles::RemoveStyleControl $ck7Text
  SetCtlColors $ck7Text 98c8fe transparent
	${CustomSetFont} $ck7Text "΢���ź�" 10 700

	${NSD_CreateButton} 270 192 16 16 ""
  Pop $ck8
  NSISVCLStyles::RemoveStyleControl $ck8
  SkinBtn::Set /IMGID=$PLUGINSDIR\ckfalse.bmp $ck8
  GetFunctionAddress $2 un.ck8Click
  SkinBtn::onClick $ck8 $2
	${NSD_CreateLabel} 296 190 130 20 "���°�װ"
  pop $ck8Text
  NSISVCLStyles::RemoveStyleControl $ck8Text
  SetCtlColors $ck8Text 98c8fe transparent
	${CustomSetFont} $ck8Text "΢���ź�" 10 700
	;����ѡ��  ����--------------------------------------------------------
	
	;${NSD_CreateTextMultiline} 50 220 420 70 "����д����ԭ��"
	;Pop $otherText
	;SetCtlColors $otherText b6d8fe 4087D8
	;${CustomSetFont} $otherText "΢���ź�" 8 700
	nsDialogs::CreateControl EDIT \
		"${__NSD_Text_STYLE}||${ES_MULTILINE}|${ES_WANTRETURN}|${ES_AUTOVSCROLL}|${ES_AUTOHSCROLL}|${WS_BORDER}" \
		"${__NSD_Text_EXSTYLE}" \
		50 220 420 70 \
		"����д����ԭ��"
		Pop $otherText
	SetCtlColors $otherText b6d8fe 418BDB
	${CustomSetFont} $otherText "΢���ź�" 10 500
	EnableWindow $otherText 0
	
	${NSD_CreateButton} 112 325 150 40 "��ʼж��"
  Pop $0
  NSISVCLStyles::RemoveStyleControl $0
  GetFunctionAddress $3 un.NextPage
	SkinBtn::onClick $0 $3


  ${NSD_CreateButton} 282 325 150 40 "ȡ��"
  Pop $0
  NSISVCLStyles::RemoveStyleControl $0
;��������ͼ
  ${NSD_CreateBitmap} 0 0 100% 100% ""
  Pop $BGImage
  ${NSD_SetImage} $BGImage $PLUGINSDIR\bg.bmp $ImageHandle

  GetFunctionAddress $0 un.onGUICallback
  WndProc::onCallback $BGImage $0 ;�����ޱ߿����ƶ�
  WndProc::onCallback $BGImageLong $0 ;�����ޱ߿����ƶ�
  nsDialogs::Show
FunctionEnd

Function un.onGUICallback
  ${If} $MSG = ${WM_LBUTTONDOWN}
    SendMessage $HWNDPARENT ${WM_NCLBUTTONDOWN} ${HTCAPTION} $0
  ${EndIf}
FunctionEnd

Function un.InstallFiles
  GetDlgItem $0 $HWNDPARENT 1 ;��һ��/�ر� ��ť
  ShowWindow $0 ${SW_HIDE}    ;����
  GetDlgItem $0 $HWNDPARENT 2 ;ȡ�� ��ť
  ShowWindow $0 ${SW_HIDE}
  GetDlgItem $0 $HWNDPARENT 3 ;��һ�� ��ť
  ShowWindow $0 ${SW_HIDE}    ;����

  GetDlgItem $0 $HWNDPARENT 1990
  ShowWindow $0 ${SW_HIDE}
  GetDlgItem $0 $HWNDPARENT 1991
  ShowWindow $0 ${SW_HIDE}
  GetDlgItem $0 $HWNDPARENT 1992
  ShowWindow $0 ${SW_HIDE}

  nsDialogs::Create /NOUNLOAD 1044
  Pop $0
  ${If} $0 == error
    Abort
  ${EndIf}
  SetCtlColors $0 ""  transparent ;�������͸��
  ${NSW_SetWindowSize} $0 520 400 ;�ı�Page��С

  ${NSD_CreateLabel} 20 11 100 30 "Cocosж��"
  Pop $R1
	NSISVCLStyles::RemoveStyleControl $R1
  SetCtlColors $R1 fffffff transparent
	${CustomSetFont} $R1 "΢���ź�" 16 400
	GetFunctionAddress $0 un.onGUICallback
	WndProc::onCallback $R1 $0


  ${NSD_CreateLabel} 100 247 300 30 "��л����һ��ȹ�������ʱ��~"
  Pop $toolTipText
  SetCtlColors $toolTipText fffffff transparent
	${CustomSetFont} $toolTipText "RTWSYueGoTrial-Regular" 18 400
	GetFunctionAddress $0 un.onGUICallback
	WndProc::onCallback $toolTipText $0
	NSISVCLStyles::RemoveStyleControl $toolTipText

	${NSD_CreateBitmap} 159 38 200 200 ""
	Pop $0
	${NSD_SetImage} $0 $PLUGINSDIR\logo.bmp $1

	GetFunctionAddress $3 un.onGUICallback
  WndProc::onCallback $0 $3 ;�����ޱ߿����ƶ�

;��������ͼ
  ${NSD_CreateBitmap} 0 0 100% 100% ""
  Pop $BGImage
  ${NSD_SetImage} $BGImage $PLUGINSDIR\bg.bmp $ImageHandle

  GetFunctionAddress $0 un.onGUICallback
  WndProc::onCallback $BGImage $0 ;�����ޱ߿����ƶ�
  WndProc::onCallback $BGImageLong $0 ;�����ޱ߿����ƶ�
  nsDialogs::Show
FunctionEnd

Function un.InstallFinish

  GetDlgItem $0 $HWNDPARENT 1 ;��һ��/�ر� ��ť
  ShowWindow $0 ${SW_HIDE}    ;����
  GetDlgItem $0 $HWNDPARENT 2 ;ȡ�� ��ť
  ShowWindow $0 ${SW_HIDE}
  GetDlgItem $0 $HWNDPARENT 3 ;��һ�� ��ť
  ShowWindow $0 ${SW_HIDE}    ;����

  GetDlgItem $0 $HWNDPARENT 1990
  ShowWindow $0 ${SW_HIDE}
  GetDlgItem $0 $HWNDPARENT 1991
  ShowWindow $0 ${SW_HIDE}
  GetDlgItem $0 $HWNDPARENT 1992
  ShowWindow $0 ${SW_HIDE}

  nsDialogs::Create /NOUNLOAD 1044
  Pop $0
  ${If} $0 == error
    Abort
  ${EndIf}
  SetCtlColors $0 ""  transparent ;�������͸��
  ${NSW_SetWindowSize} $0 520 400 ;�ı�Page��С

  ${NSD_CreateLabel} 20 11 100 30 "Cocosж��"
  Pop $R1
	NSISVCLStyles::RemoveStyleControl $R1
  SetCtlColors $R1 fffffff transparent
	${CustomSetFont} $R1 "΢���ź�" 16 400
	GetFunctionAddress $0 un.onGUICallback
	WndProc::onCallback $R1 $0


  ${NSD_CreateLabel} 100 247 300 30 "��л����һ��ȹ�������ʱ��~"
  Pop $toolTipText
  SetCtlColors $toolTipText fffffff transparent
	${CustomSetFont} $toolTipText "RTWSYueGoTrial-Regular" 18 400
	GetFunctionAddress $0 un.onGUICallback
	WndProc::onCallback $toolTipText $0
	NSISVCLStyles::RemoveStyleControl $toolTipText

	${NSD_CreateBitmap} 159 38 200 200 ""
	Pop $0
	${NSD_SetImage} $0 $PLUGINSDIR\logo.bmp $1

	GetFunctionAddress $3 un.onGUICallback
  WndProc::onCallback $0 $3 ;�����ޱ߿����ƶ�

;��������ͼ
  ${NSD_CreateBitmap} 0 0 100% 100% ""
  Pop $BGImage
  ${NSD_SetImage} $BGImage $PLUGINSDIR\bg.bmp $ImageHandle

  GetFunctionAddress $0 un.onGUICallback
  WndProc::onCallback $BGImage $0 ;�����ޱ߿����ƶ�
  WndProc::onCallback $BGImageLong $0 ;�����ޱ߿����ƶ�
  nsDialogs::Show
FunctionEnd

Function un.NextPage
  StrCpy $R9 1 ;Goto the next page
  IntCmp $R9 0 0 Move Move
  StrCmp $R9 "X" 0 Move
  StrCpy $R9 "120"
  Move:
  SendMessage $HWNDPARENT "0x408" "$R9" ""
  Abort
FunctionEnd

Function un.ck1Click
	${If} $ck1Flag == "True"
		ShowWindow $ck1Text ${SW_HIDE}
	  SetCtlColors $ck1Text 98c8fe transparent
	  ShowWindow $ck1Text ${SW_SHOW}
  	SkinBtn::Set /IMGID=$PLUGINSDIR\ckfalse.bmp $ck1
  	Push "False"
		Pop $ck1Flag
	${Else}
		ShowWindow $ck1Text ${SW_HIDE}
	  SetCtlColors $ck1Text fffffff transparent
	  ShowWindow $ck1Text ${SW_SHOW}
		SkinBtn::Set /IMGID=$PLUGINSDIR\cktrue.bmp $ck1
		Push "True"
		Pop $ck1Flag
	${EndIf}
FunctionEnd

Function un.ck2Click
	${If} $ck2Flag == "True"
		ShowWindow $ck2Text ${SW_HIDE}
	  SetCtlColors $ck2Text 98c8fe transparent
	  ShowWindow $ck2Text ${SW_SHOW}
  	SkinBtn::Set /IMGID=$PLUGINSDIR\ckfalse.bmp $ck2
  	Push "False"
		Pop $ck2Flag
	${Else}
		ShowWindow $ck2Text ${SW_HIDE}
	  SetCtlColors $ck2Text fffffff transparent
	  ShowWindow $ck2Text ${SW_SHOW}
		SkinBtn::Set /IMGID=$PLUGINSDIR\cktrue.bmp $ck2
		Push "True"
		Pop $ck2Flag
	${EndIf}
FunctionEnd
Function un.ck3Click
	${If} $ck3Flag == "True"
		ShowWindow $ck3Text ${SW_HIDE}
	  SetCtlColors $ck3Text 98c8fe transparent
	  ShowWindow $ck3Text ${SW_SHOW}
  	SkinBtn::Set /IMGID=$PLUGINSDIR\ckfalse.bmp $ck3
  	Push "False"
		Pop $ck3Flag
	${Else}
		ShowWindow $ck3Text ${SW_HIDE}
	  SetCtlColors $ck3Text fffffff transparent
	  ShowWindow $ck3Text ${SW_SHOW}
		SkinBtn::Set /IMGID=$PLUGINSDIR\cktrue.bmp $ck3
		Push "True"
		Pop $ck3Flag
	${EndIf}
FunctionEnd
Function un.ck4Click
	${If} $ck4Flag == "True"
		ShowWindow $ck4Text ${SW_HIDE}
	  SetCtlColors $ck4Text 98c8fe transparent
	  ShowWindow $ck4Text ${SW_SHOW}
  	SkinBtn::Set /IMGID=$PLUGINSDIR\ckfalse.bmp $ck4
  	Push "False"
		Pop $ck4Flag
	${Else}
		ShowWindow $ck4Text ${SW_HIDE}
	  SetCtlColors $ck4Text fffffff transparent
	  ShowWindow $ck4Text ${SW_SHOW}
		SkinBtn::Set /IMGID=$PLUGINSDIR\cktrue.bmp $ck4
		Push "True"
		Pop $ck4Flag
	${EndIf}
FunctionEnd
Function un.ck5Click
	${If} $ck5Flag == "True"
		ShowWindow $ck5Text ${SW_HIDE}
	  SetCtlColors $ck5Text 98c8fe transparent
	  ShowWindow $ck5Text ${SW_SHOW}
  	SkinBtn::Set /IMGID=$PLUGINSDIR\ckfalse.bmp $ck5
  	Push "False"
		Pop $ck5Flag
	${Else}
		ShowWindow $ck5Text ${SW_HIDE}
	  SetCtlColors $ck5Text fffffff transparent
	  ShowWindow $ck5Text ${SW_SHOW}
		SkinBtn::Set /IMGID=$PLUGINSDIR\cktrue.bmp $ck5
		Push "True"
		Pop $ck5Flag
	${EndIf}
FunctionEnd
Function un.ck6Click
	${If} $ck6Flag == "True"
		ShowWindow $ck6Text ${SW_HIDE}
	  SetCtlColors $ck6Text 98c8fe transparent
	  ShowWindow $ck6Text ${SW_SHOW}
  	SkinBtn::Set /IMGID=$PLUGINSDIR\ckfalse.bmp $ck6
  	Push "False"
		Pop $ck6Flag
	${Else}
		ShowWindow $ck6Text ${SW_HIDE}
	  SetCtlColors $ck6Text fffffff transparent
	  ShowWindow $ck6Text ${SW_SHOW}
		SkinBtn::Set /IMGID=$PLUGINSDIR\cktrue.bmp $ck6
		Push "True"
		Pop $ck6Flag
	${EndIf}
FunctionEnd
Function un.ck7Click
	${If} $ck7Flag == "True"
		ShowWindow $ck7Text ${SW_HIDE}
	  SetCtlColors $ck7Text 98c8fe transparent
	  ShowWindow $ck7Text ${SW_SHOW}
  	SkinBtn::Set /IMGID=$PLUGINSDIR\ckfalse.bmp $ck7
  	EnableWindow $otherText 0
  	Push "False"
		Pop $ck7Flag
	${Else}
		ShowWindow $ck7Text ${SW_HIDE}
	  SetCtlColors $ck7Text fffffff transparent
	  ShowWindow $ck7Text ${SW_SHOW}
		SkinBtn::Set /IMGID=$PLUGINSDIR\cktrue.bmp $ck7
		EnableWindow $otherText 1
		Push "True"
		Pop $ck7Flag
	${EndIf}
FunctionEnd
Function un.ck8Click
	${If} $ck8Flag == "True"
		ShowWindow $ck8Text ${SW_HIDE}
	  SetCtlColors $ck8Text 98c8fe transparent
	  ShowWindow $ck8Text ${SW_SHOW}
  	SkinBtn::Set /IMGID=$PLUGINSDIR\ckfalse.bmp $ck8
  	Push "False"
		Pop $ck8Flag
	${Else}
		ShowWindow $ck8Text ${SW_HIDE}
	  SetCtlColors $ck8Text fffffff transparent
	  ShowWindow $ck8Text ${SW_SHOW}
		SkinBtn::Set /IMGID=$PLUGINSDIR\cktrue.bmp $ck8
		Push "True"
		Pop $ck8Flag
	${EndIf}
FunctionEnd

