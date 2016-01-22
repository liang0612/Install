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
var IsEnglish ;��ǰ�����Ƿ���Ӣ��
Var txt_Userdata ;�û������ı�
Var txb_AppDocument ;�û����ݱ���λ��
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
ReserveFile "images\CocosBG_EN.bmp"
ReserveFile "images\close.bmp"
ReserveFile "images\browse.bmp"
ReserveFile "images\browse_CT.bmp"
ReserveFile "images\browse_EN.bmp"
ReserveFile "images\custom.bmp"
ReserveFile "images\install.bmp"
ReserveFile "images\CocosBG_long.bmp"
ReserveFile "images\CocosBG_EN_long.bmp"
ReserveFile "images\empty_bg.bmp"
ReserveFile "images\full_bg.bmp"
ReserveFile "images\express.bmp"
ReserveFile "images\express_CT.bmp"
ReserveFile "images\express_EN.bmp"
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
ReserveFile `Plugins\Resource.dll`
ReserveFile `Plugins\nsResize.dll`

; ------ MUI �ִ����涨�� (1.67 �汾���ϼ���) ------
!include "MUI.nsh"
!include "WinCore.nsh"
!include "nsWindows.nsh"
!include "LogicLib.nsh"
!include "WinMessages.nsh"
!include "LoadRTF.nsh"
!include "nsResize.nsh"
!include "FileFunc.nsh"
!include "nsDialogs_createTextMultiline.nsh"
!include "LogicLib.nsh"


!define MUI_CUSTOMFUNCTION_GUIINIT onGUIInit
;�Զ���ҳ��
Page custom  Page.1 Page.1leave
;Page instfiles InstFilesPageShow
; ��װ����ҳ��
Page custom InstFilesPageShow InstallFilesFinish
;!define MUI_PAGE_CUSTOMFUNCTION_SHOW InstFilesPageShow
;!insertmacro MUI_PAGE_INSTFILES

; ��װ���ҳ��
Page custom InstallFinish

!define MUI_CUSTOMFUNCTION_UNGUIINIT un.onGUIInit1
# �Զ���ж�ؽ��� Custom UninstPage
UninstPage custom un.UnPageWelcome
;ж�ط���ҳ��
UninstPage custom un.FeedbackPage
;UninstPage custom un.InstallFiles
!define MUI_PAGE_CUSTOMFUNCTION_SHOW un.InstallFiles1
!insertmacro MUI_UNPAGE_INSTFILES
Uninstpage custom un.InstallFinish

; ��װ�����������������
!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "SimpChinese"
!insertmacro MUI_LANGUAGE "TradChinese"

!include "Language\CocosLanguage.nsi"

!macro __ChangeWindowSize width hight
	${NSW_SetWindowSize} $HWNDPARENT ${width} ${hight}
	${NSW_SetWindowSize} $page1HNW ${width} ${hight}
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
  	Push ${LANG_ENGLISH}
   	Pop $LANGUAGE
		${If} $LANGUAGE == 1033
    	Push True
   		Pop $IsEnglish
    ${Else}
      Push False
   		Pop $IsEnglish
		${EndIf}

    InitPluginsDir ;��ʼ�����
    File `/ONAME=$PLUGINSDIR\bg.bmp` `images\CocosBG.bmp` ;��һ����
		File `/ONAME=$PLUGINSDIR\bgLong.bmp` `images\CocosBG_long.bmp` ;��һ�󱳾�
    
    File `/ONAME=$PLUGINSDIR\bgEN.bmp` `images\CocosBG_EN.bmp` ;��һ����
    File `/ONAME=$PLUGINSDIR\bgLongEN.bmp` `images\CocosBG_EN_long.bmp` ;��һ�󱳾�
    
    File `/oname=$PLUGINSDIR\btn_install.bmp` `images\install.bmp` ;������װ
    
		File `/oname=$PLUGINSDIR\browse.bmp` `images\browse.bmp` ;�����ť����
		File `/oname=$PLUGINSDIR\browse_CT.bmp` `images\browse_CT.bmp` ;�����ť����
		File `/oname=$PLUGINSDIR\browse_EN.bmp` `images\browse_EN.bmp` ;�����ť����
		
    File `/oname=$PLUGINSDIR\btn_Close.bmp` `images\Close.bmp` ;�ر�
    File `/oname=$PLUGINSDIR\btn_custom.bmp` `images\custom.bmp`  ;�Զ��尲װ
    
    File `/oname=$PLUGINSDIR\btn_express.bmp` `images\express.bmp` ;��������
    File `/oname=$PLUGINSDIR\btn_express_CT.bmp` `images\express_CT.bmp` ;��������
    File `/oname=$PLUGINSDIR\btn_express_EN.bmp` `images\express_EN.bmp` ;��������
    
    File `/oname=$PLUGINSDIR\AirBubbles.bmp` `images\AirBubbles.bmp`
    ;������Ƥ��
	  File `/oname=$PLUGINSDIR\Progress.bmp` `images\empty_bg.bmp`
  	File `/oname=$PLUGINSDIR\ProgressBar.bmp` `images\full_bg.bmp`
   	File `/oname=$PLUGINSDIR\successful.bmp` `images\successful.bmp`
  	LogSet on
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

  	${NSW_SetWindowSize} $page1HNW 600 480
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
    ${NSD_CreateLabel} 20 436 80 25 $(MSG_InstallDir)
    Pop $txt_installDir
    SetCtlColors $txt_installDir 363636 FFFFFF
		${CustomSetFont} $txt_installDir "΢���ź�" 12 0
		ShowWindow $txt_installDir ${SW_HIDE}
		
		;��װĿ¼�ı���
		${NSD_CreateText} 100 435 395 25 "C:\Cocos"
		Pop $txb_AppFolder
		SetCtlColors $txb_AppFolder 363636 FFFFFF
		${CustomSetFont} $txb_AppFolder "΢���ź�" 10 550
		${NSD_SetText} $txb_AppFolder $AppFolder
		ShowWindow $txb_AppFolder ${SW_HIDE}
		
		;�����ť
		${NSD_CreateButton} 500 435 60 25 ""
    Pop $btn_browse
    SkinBtn::Set /IMGID=$(MSG_Browse) $btn_browse
    ${NSD_OnClick} $btn_browse SelectAppFolder
		ShowWindow $btn_browse ${SW_HIDE}
		
    ${NSD_CreateLabel} 100 472 180 25 $(MSG_FilesSize)
    Pop $txt_FileSize
    SetCtlColors $txt_FileSize 363636 FFFFFF
		${CustomSetFont} $txt_FileSize "΢���ź�" 10 550
		ShowWindow $txt_FileSize ${SW_HIDE}

    ${NSD_CreateLabel} 280 472 200 25 $(MSG_AvailableSpace)
    Pop $txt_AvailableSpace
    SetCtlColors $txt_AvailableSpace 363636 FFFFFF
		${CustomSetFont} $txt_AvailableSpace "΢���ź�" 10 550
		ShowWindow $txt_AvailableSpace ${SW_HIDE}
		
		${NSD_CreateLabel} 20 497 80 25 $(MSG_InstallOptions)
    Pop $tex_installOptions
    SetCtlColors $tex_installOptions 363636 FFFFFF
		${CustomSetFont} $tex_installOptions "΢���ź�" 12 550
		ShowWindow $tex_installOptions ${SW_HIDE}
		
		${NSD_CreateCheckbox} 100 520 300 25 $(MSG_Cocos2dx)
    Pop $ckb_cocos2d
    SetCtlColors $ckb_cocos2d "" FFFFFF
    ${NSD_Check} $ckb_cocos2d
		${CustomSetFont} $ckb_cocos2d "΢���ź�" 10 550
		ShowWindow $ckb_cocos2d ${SW_HIDE}
    EnableWindow $ckb_cocos2d 0
    
		${NSD_CreateCheckbox} 100 547 300 25 $(MSG_CocosStudio)
    Pop $ckb_CocosStudio
    SetCtlColors $ckb_CocosStudio "" FFFFFF
    ${NSD_Check} $ckb_CocosStudio
		${CustomSetFont} $ckb_CocosStudio "΢���ź�" 10 550
		ShowWindow $ckb_CocosStudio ${SW_HIDE}
		
		${NSD_CreateLabel} 100 580 120 25 $(MSG_Userdata)
		Pop $txt_Userdata
		SetCtlColors $txt_Userdata "" FFFFFF
		${CustomSetFont} $txt_Userdata "΢���ź�" 10 550
		
		${NSD_CreateText} 220 580 270 25 $DOCUMENTS
		Pop $txb_AppDocument
		SetCtlColors $txb_AppDocument 363636 FFFFFF
		${CustomSetFont} $txb_AppDocument "΢���ź�" 10 550
		
		${NSD_CreateLabel} 220 610 180 25 $(MSG_FilesSize)
    Pop $0
    SetCtlColors $0 363636 FFFFFF
		${CustomSetFont} $0 "΢���ź�" 10 400

    ${NSD_CreateLabel} 380 610 200 25 $(MSG_AvailableSpace)
    Pop $0
    SetCtlColors $0 363636 FFFFFF
		${CustomSetFont} $0 "΢���ź�" 10 400

		;�����ť
		${NSD_CreateButton} 500 580 60 25 ""
    Pop $0
    SkinBtn::Set /IMGID=$(MSG_Browse) $0
#------------------------------------------
#���Э��
#------------------------------------------
    ${NSD_CreateCheckbox} 20 432 100 20 $(MSG_CheckLince)
    Pop $cbk_license
    SetCtlColors $cbk_license "" FFFFFF
    ${NSD_Check} $cbk_license
    ${NSD_OnClick} $cbk_license Chklicense
    
    ${NSD_CreateLink} 124 435 100 16 $(MSG_CocosAgreement)
    Pop $Txt_Xllicense
    SetCtlColors $Txt_Xllicense 0074F3 FFFFFF
    ${NSD_OnClick} $Txt_Xllicense xllicense
    
 		;��������ͼ
    ${NSD_CreateBitmap} 0 0 100% 100% ""
    Pop $BGImageLong
    ${NSD_SetImage} $BGImageLong $(MSG_BGImage_Long) $ImageHandleLong
    ShowWindow $BGImageLong ${SW_HIDE}

    ${NSD_CreateBitmap} 0 0 100% 100%  ""
    Pop $BGImage
    ${NSD_SetImage} $BGImage $(MSG_BGImage) $ImageHandle
    call EnglishPageSmall
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
  MessageBox MB_ICONINFORMATION|MB_OK "'$R0' $(MSG_DirNotExist)"
  Return
	StrCpy $INSTDIR  $R0
FunctionEnd

;����δչ��ʱӢ��ҳ�沼��
Function EnglishPageSmall
	${If} $IsEnglish == True
 		nsResize::Set $cbk_license 20 432 200 16
 		nsResize::Set $Txt_Xllicense 35 450 200 16
 	${EndIf}
FunctionEnd

;����չ��ʱӢ��ҳ�沼��
Function EnglishPageExpand
	${If} $IsEnglish == True
		nsResize::Set $txt_installDir 20 436 120 25
		nsResize::Set $txb_AppFolder 140 435 350 25
    nsResize::Set $btn_browse  500 435 60 25
  	nsResize::Set $cbk_license 20 625 200 20
 		nsResize::Set $Txt_Xllicense 35 645 200 16
    nsResize::Set $txt_FileSize 140 472 180 25
    nsResize::Set $txt_AvailableSpace 320 472 200 25
    nsResize::Set $btn_ins 480 635 92 16
    nsResize::Set $txt_Userdata 100 580 170 25
		nsResize::Set $txb_AppDocument 270 580 220 25
 	${EndIf}
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
		${ChangeWindowSize} 600 480
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
    ${NSD_SetImage} $BGImage $(MSG_BGImage) $ImageHandle

    GetFunctionAddress $0 NSD_TimerFun
    nsDialogs::CreateTimer $0 1
    
    GetFunctionAddress $0 AirBubblesPosition
    nsDialogs::CreateTimer $0 1000
    
    GetFunctionAddress $0 onGUICallback
    WndProc::onCallback $BGImage $0 ;�����ޱ߿����ƶ�
    nsDialogs::Show
    ${NSD_FreeImage} $ImageHandle
FunctionEnd
;��װ��ɴ���
Function InstallFilesFinish
call WriterRegistry
FunctionEnd

Var proPosition
Function AirBubblesPosition
	SendMessage $PB_ProgressBar ${PBM_GETPOS} 0 0 $0
	IntOp $1 $0 + 1
	${IF} $proPosition < 95
		SendMessage $PB_ProgressBar ${PBM_SETPOS} $1 0
		IntOp $proPosition $0 + 0
		${NSD_SetText} $AirBubblesImage "$0%"
		IntOp $0 $0 * 46
		IntOp $0 $0 / 10
		IntOp $0 $0 + 48
	  nsResize::Set $AirBubblesImage $0 345 45 31
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

Var BANNER
Var COUNT
Var ARCHIVE

Function ServiceCallback
 	Pop $R8
  Pop $R9
  System::Int64Op $R8 * 100
  Pop $R0
  System::Int64Op $R0 / $R9
  Pop $R3
  SendMessage $PB_ProgressBar ${PBM_SETPOS} $R3 0
FunctionEnd

Function InstallationMainFun
 		;Call NextPage
 		WriteUninstaller "$INSTDIR\uninst.exe"
    SetOutPath "$INSTDIR\Cocos Studio"
    SendMessage $PB_ProgressBar ${PBM_SETRANGE32} 0 100
    ;SendMessage $PB_ProgressBar ${PBM_SETPOS} 10 0
  	File /r "F:\Work3.0\Mono_3.0\build\Temp\ReleaseWin32\*.*"
  	;SetOutPath "$DOCUMENTS\Cocos1"
  	;File "F:\Work3.0\Mono_3.0\build\Builder\*.*"
  	SendMessage $PB_ProgressBar ${PBM_SETPOS} 20 0
  	call AirBubblesPosition
  	Sleep 180000
  	SetOutPath $INSTDIR
  	;File /r "F:\Work3.0\Mono_3.0\build\Temp\Temp.7z"
  	;SendMessage $PB_ProgressBar ${PBM_SETPOS} 30 0
  	
		;GetFunctionAddress $R9 ServiceCallback
  	;Nsis7z::ExtractWithCallback "Temp.7z" $R9
  
    SendMessage $PB_ProgressBar ${PBM_SETPOS} 100 0
    Call AirBubblesPosition
    Sleep 1000
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
    SkinBtn::Set /IMGID=$(MSG_ExperienceNow) $btn_instend
    GetFunctionAddress $3 onClickexpress
    SkinBtn::onClick $btn_instend $3
    
    ${NSD_CreateBitmap} 234 335 24 24 ""
		Pop $0
		${NSD_SetImage} $0 $PLUGINSDIR\successful.bmp $1
		${If} $IsEnglish == True
      nsResize::Set $0 170 335 24 24
		${EndIf}
		
		${NSD_CreateLabel} 266 328 200 50 $(MSG_InstallSuccessful)
		Pop $0
		SetCtlColors $0 363636 FFFFFF
		${CustomSetFont} $0 "΢���ź�" 18 400
		
		${If} $IsEnglish == True 
      nsResize::Set $0 200 330 400 30
		${EndIf}
		;�Զ��尲װ��ť
    ${NSD_CreateButton} 488 436 92 16 ""
    Pop $btn_ins
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_custom.bmp $btn_ins
    GetFunctionAddress $3 OpenFolder
    SkinBtn::onClick $btn_ins $3
    
    ;��������ͼ
    ${NSD_CreateBitmap} 0 0 100% 100% ""
    Pop $BGImage
    ${NSD_SetImage} $BGImage $(MSG_BGImage) $ImageHandle

    GetFunctionAddress $0 onGUICallback
    WndProc::onCallback $BGImage $0 ;�����ޱ߿����ƶ�
    nsDialogs::Show

    ${NSD_FreeImage} $ImageHandle
FunctionEnd

Function Page.4

FunctionEnd

Function ABORT
	MessageBox MB_ICONQUESTION|MB_YESNO|MB_ICONSTOP $(MSG_QuitCocos) IDNO CANCEL
	SendMessage $hwndparent ${WM_CLOSE} 0 0
	CANCEL:
	Abort
FunctionEnd

Function onClickins
 MessageBox MB_OK $DOCUMENTS
	Call NextPage
FunctionEnd

Function SelectAppFolder
	nsDialogs::SelectFolderDialog /NOUNLOAD $(MSG_SelectDirIn2dx)
	Pop $0
	${If} $0 != "error"
		Push $0
		Pop $AppFolder
	${EndIf}
	${NSD_SetText} $txb_AppFolder $AppFolder
	${DriveSpace} $AppFolder "/D=F /S=M" $R0
	IntOp $R0 $R0 / 1024
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
		Call EnglishPageSmall
 		Push "False"
		Pop $flag
	${Else}
		${ChangeWindowSize} 600 665
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
 		nsResize::Set $btn_ins 480 635 92 16
 		nsResize::Set $cbk_license 20 635 100 20
 		nsResize::Set $Txt_Xllicense 124 640 100 16
    call EnglishPageExpand
 		Push "True"
 		Pop $flag
	${EndIf}
FunctionEnd
;дע���
Function WriterRegistry
	WriteRegStr HKLM "SOFTWARE\ChuKong\Cocos\CocosStudio" "AppFolder" "$INSTDIR\Cocos Studio"
FunctionEnd

;������ݷ�ʽ
Function CreateShortcut

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
	MessageBox MB_OK '$(MSG_ExperienceNow)'
	ABORT
FunctionEnd

Function xllicense
  ExecShell "open" "http://api.cocos.com/cn/LICENSE%20AGREEMENT%20CN.pdf"
FunctionEnd


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
		Push ${LANG_ENGLISH}
   	Pop $LANGUAGE
   	${If} $LANGUAGE == 1033
    	Push True
   		Pop $IsEnglish
    ${Else}
      Push False
   		Pop $IsEnglish
		${EndIf}
    InitPluginsDir ;��ʼ�����UnPageBG.bmp

    File `/ONAME=$PLUGINSDIR\bg.bmp` `images\UninstallBG.bmp` ;ж��ҳ�汳��
    File `/ONAME=$PLUGINSDIR\bg_CT.bmp` `images\UninstallBG_CT.bmp` ;ж��ҳ�汳��
    File `/ONAME=$PLUGINSDIR\bg_EN.bmp` `images\UninstallBG_EN.bmp` ;ж��ҳ�汳��
    
    File `/ONAME=$PLUGINSDIR\bg_fb.bmp` `images\UnPageBG.bmp` ;ж��ҳ�汳��
    
    File `/ONAME=$PLUGINSDIR\finishBG.bmp` `images\UnPageFinishBG.bmp`
    File `/ONAME=$PLUGINSDIR\finishBG_CT.bmp` `images\UnPageFinishBG_CT.bmp`
    File `/ONAME=$PLUGINSDIR\finishBG_EN.bmp` `images\UnPageFinishBG_EN.bmp`
    
    File `/ONAME=$PLUGINSDIR\ck1.bmp` `images\ck1.bmp`
    File `/ONAME=$PLUGINSDIR\ck1_1.bmp` `images\ck1_1.bmp`
    File `/ONAME=$PLUGINSDIR\ck1.png` `images\ck1.png`
    File `/ONAME=$PLUGINSDIR\ck1_1.png` `images\ck1_1.png`
    
    File `/ONAME=$PLUGINSDIR\cktrue.bmp` `images\cktrue.bmp`
    File `/ONAME=$PLUGINSDIR\ckfalse.bmp` `images\ckfalse.bmp`
    File /oname=$PLUGINSDIR\Cocos.vsf "Skin\Cocos.vsf"
  	NSISVCLStyles::LoadVCLStyle  $PLUGINSDIR\Cocos.vsf
  	SkinBtn::Init "$PLUGINSDIR\ck1.bmp"
  	SkinBtn::Init "$PLUGINSDIR\ck1_1.bmp"
FunctionEnd

Function un.onGUIInit1
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

  ${NSD_CreateLabel} 20 11 100 30 $(un.MSG_CocosUninstaller)
  Pop $R1
	NSISVCLStyles::RemoveStyleControl $R1
  SetCtlColors $R1 A7BAF5 transparent
	${CustomSetFont} $R1 "΢���ź�" 16 400
	GetFunctionAddress $0 un.onGUICallback
	WndProc::onCallback $R1 $0
	
  ${NSD_CreateButton} 112 325 150 40 "����ж��"
  Pop $0
  NSISVCLStyles::RemoveStyleControl $0
  GetFunctionAddress $3 un.NextPage
	SkinBtn::onClick $0 $3

	
  ${NSD_CreateButton} 282 325 150 40 "��������"
  Pop $0
  NSISVCLStyles::RemoveStyleControl $0
  

;��������ͼ
  ${NSD_CreateBitmap} 0 0 100% 100% ""
  Pop $BGImage
  ${NSD_SetImage} $BGImage $(un.MSG_UninstallBG) $ImageHandle
  
  GetFunctionAddress $0 un.onGUICallback
  WndProc::onCallback $BGImage $0 ;�����ޱ߿����ƶ�
  WndProc::onCallback $BGImageLong $0 ;�����ޱ߿����ƶ�
  nsDialogs::Show
FunctionEnd

Function un.EnglishPage
	${If} $IsEnglish == True
		nsResize::Set $ck1 50 92 16 16
  	nsResize::Set $ck1Text 76 90 180 30
  
		nsResize::Set $ck2 270 92 16 16
		nsResize::Set $ck2Text 296 90 180 30

		nsResize::Set $ck3 50 122 16 16
		nsResize::Set $ck3Text 76 120 180 30

		nsResize::Set $ck4 270 122 16 16
		nsResize::Set $ck4Text 296 120 180 30

		nsResize::Set $ck5 50 154 16 16
		nsResize::Set $ck5Text 76 152 180 30

		nsResize::Set $ck6 270 154 16 16
		nsResize::Set $ck6Text 296 152 180 30

		nsResize::Set $ck7 50 187 16 16
		nsResize::Set $ck7Text 76 185 180 30
  
		nsResize::Set $ck8 270 187 16 16
		nsResize::Set $ck8Text 296 185 180 30
	${EndIf}
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

  ${NSD_CreateLabel} 20 11 100 30 $(un.MSG_CocosUninstaller)
  Pop $R1
  NSISVCLStyles::RemoveStyleControl $R1
  SetCtlColors $R1 A7BAF5 transparent
	${CustomSetFont} $R1 $(un.MSg_FontName) 10 700
	;GetFunctionAddress $0 un.onGUICallback
	;WndProc::onCallback $R1 $0
	
	${NSD_CreateLabel} 50 46 300 20 $(un.MSG_LasterTitle)
  pop $0
  NSISVCLStyles::RemoveStyleControl $0
  SetCtlColors $0 fffffff transparent
	${CustomSetFont} $0 $(un.MSg_FontName) 10 700
	
	;����ѡ��--------------------------------------------------------------
	${NSD_CreateButton} 50 92 16 16 ""
  Pop $ck1
  NSISVCLStyles::RemoveStyleControl $ck1
  SkinBtn::Set /IMGID=$PLUGINSDIR\ckfalse.bmp $ck1
  GetFunctionAddress $2 un.ck1Click
  SkinBtn::onClick $ck1 $2
  ${NSD_CreateLabel} 76 90 124 20 $(un.MSG_Reason1)
  pop $ck1Text
  NSISVCLStyles::RemoveStyleControl $ck1Text
  SetCtlColors $ck1Text 98c8fe transparent
	${CustomSetFont} $ck1Text $(un.MSg_FontName) 10 700
	;GetFunctionAddress $0 un.MouseDown
	;WndProc::onCallback $ck1Text $0
	
	${NSD_CreateButton} 270 92 16 16 ""
  Pop $ck2
  NSISVCLStyles::RemoveStyleControl $ck2
  SkinBtn::Set /IMGID=$PLUGINSDIR\ckfalse.bmp $ck2
  GetFunctionAddress $2 un.ck2Click
  SkinBtn::onClick $ck2 $2
	${NSD_CreateLabel} 296 90 130 20 $(un.MSG_Reason2)
  pop $ck2Text
  NSISVCLStyles::RemoveStyleControl $ck2Text
  SetCtlColors $ck2Text 98c8fe transparent
	${CustomSetFont} $ck2Text $(un.MSg_FontName) 10 700

	${NSD_CreateButton} 50 122 16 16 ""
  Pop $ck3
  NSISVCLStyles::RemoveStyleControl $ck3
  SkinBtn::Set /IMGID=$PLUGINSDIR\ckfalse.bmp $ck3
  GetFunctionAddress $2 un.ck3Click
  SkinBtn::onClick $ck3 $2
	${NSD_CreateLabel} 76 120 130 20 $(un.MSG_Reason3)
  pop $ck3Text
  NSISVCLStyles::RemoveStyleControl $ck3Text
  SetCtlColors $ck3Text 98c8fe transparent
	${CustomSetFont} $ck3Text $(un.MSg_FontName) 10 700

	${NSD_CreateButton} 270 122 16 16 ""
  Pop $ck4
  NSISVCLStyles::RemoveStyleControl $ck4
  SkinBtn::Set /IMGID=$PLUGINSDIR\ckfalse.bmp $ck4
  GetFunctionAddress $2 un.ck4Click
  SkinBtn::onClick $ck4 $2
	${NSD_CreateLabel} 296 120 130 20 $(un.MSG_Reason4)
  pop $ck4Text
  NSISVCLStyles::RemoveStyleControl $ck4Text
  SetCtlColors $ck4Text 98c8fe transparent
	${CustomSetFont} $ck4Text $(un.MSg_FontName) 10 700

	${NSD_CreateButton} 50 154 16 16 ""
  Pop $ck5
  NSISVCLStyles::RemoveStyleControl $ck5
  SkinBtn::Set /IMGID=$PLUGINSDIR\ckfalse.bmp $ck5
  GetFunctionAddress $2 un.ck5Click
  SkinBtn::onClick $ck5 $2
	${NSD_CreateLabel} 76 152 130 20 $(un.MSG_Reason5)
  pop $ck5Text
  NSISVCLStyles::RemoveStyleControl $ck5Text
  SetCtlColors $ck5Text 98c8fe transparent
	${CustomSetFont} $ck5Text $(un.MSg_FontName) 10 700

	${NSD_CreateButton} 270 154 16 16 ""
  Pop $ck6
  NSISVCLStyles::RemoveStyleControl $ck6
  SkinBtn::Set /IMGID=$PLUGINSDIR\ckfalse.bmp $ck6
  GetFunctionAddress $2 un.ck6Click
  SkinBtn::onClick $ck6 $2
	${NSD_CreateLabel} 296 152 130 20 $(un.MSG_Reason6)
  pop $ck6Text
  NSISVCLStyles::RemoveStyleControl $ck6Text
  SetCtlColors $ck6Text 98c8fe transparent
	${CustomSetFont} $ck6Text $(un.MSg_FontName) 10 700

	${NSD_CreateButton} 50 187 16 16 ""
  Pop $ck7
  NSISVCLStyles::RemoveStyleControl $ck7
  SkinBtn::Set /IMGID=$PLUGINSDIR\ckfalse.bmp $ck7
  GetFunctionAddress $2 un.ck7Click
  SkinBtn::onClick $ck7 $2
	${NSD_CreateLabel} 76 185 130 20 $(un.MSG_Reason7)
  pop $ck7Text
  NSISVCLStyles::RemoveStyleControl $ck7Text
  SetCtlColors $ck7Text 98c8fe transparent
	${CustomSetFont} $ck7Text $(un.MSg_FontName) 10 700

	${NSD_CreateButton} 270 187 16 16 ""
  Pop $ck8
  NSISVCLStyles::RemoveStyleControl $ck8
  SkinBtn::Set /IMGID=$PLUGINSDIR\ckfalse.bmp $ck8
  GetFunctionAddress $2 un.ck8Click
  SkinBtn::onClick $ck8 $2
	${NSD_CreateLabel} 296 185 130 20 $(un.MSG_Reason8)
  pop $ck8Text
  NSISVCLStyles::RemoveStyleControl $ck8Text
  SetCtlColors $ck8Text 98c8fe transparent
	${CustomSetFont} $ck8Text $(un.MSg_FontName) 10 700
	;����ѡ��  ����--------------------------------------------------------
	
	;${NSD_CreateTextMultiline} 50 220 420 70 "����д����ԭ��"
	;Pop $otherText
	;SetCtlColors $otherText b6d8fe 4087D8
	;${CustomSetFont} $otherText "΢���ź�" 8 700
	nsDialogs::CreateControl EDIT \
		"${__NSD_Text_STYLE}||${ES_MULTILINE}|${ES_WANTRETURN}|${ES_AUTOVSCROLL}|${ES_AUTOHSCROLL}|${WS_BORDER}" \
		"${__NSD_Text_EXSTYLE}" \
		50 220 420 70 \
		$(un.OtherReason)
		Pop $otherText
	SetCtlColors $otherText b6d8fe 418BDB
	${CustomSetFont} $otherText $(un.MSg_FontName) 10 500
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
  ${NSD_SetImage} $BGImage $PLUGINSDIR\bg_fb.bmp $ImageHandle
	Call un.EnglishPage
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
Function un.InstallFiles1
    FindWindow $R2 "#32770" "" $HWNDPARENT

    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $1 $R2 1027
    ShowWindow $0 ${SW_HIDE}

    GetDlgItem $1 $R2 1
    ShowWindow $1 ${SW_HIDE}
    GetDlgItem $1 $R2 2
    ShowWindow $1 ${SW_HIDE}
    GetDlgItem $1 $R2 3
    ShowWindow $1 ${SW_HIDE}

  StrCpy $R0 $R2 ;�ı�ҳ���С,��Ȼ��ͼ����ȫҳ
  System::Call "user32::MoveWindow(i R0, i 0, i 0, i 520, i 400) i r2"
  SetCtlColors $R0 ""  transparent ;�������͸��
  GetFunctionAddress $0 un.onGUICallback
  WndProc::onCallback $R0 $0 ;�����ޱ߿����ƶ�

  GetDlgItem $R0 $R2 1004  ;���ý�����λ��
  System::Call "user32::MoveWindow(i R0, i 16, i 325, i 481, i 18) i r2"

  GetDlgItem $R1 $R2 1006  ;����������ı�ǩ.
  NSISVCLStyles::RemoveStyleControl $R1
  SetCtlColors $R1 ""  FFFFFF ;�������F6F6F6,ע����ɫ������Ϊ͸���������ص�
  System::Call "user32::MoveWindow(i R1, i 16, i 350, i 481, i 12) i r2"

  
  FindWindow $R2 "#32770" "" $HWNDPARENT  ;��ȡ1995������ͼƬ
  GetDlgItem $R0 $R2 1995
  System::Call "user32::MoveWindow(i R0, i 0, i 0, i 498, i 373) i r2"
  ${NSD_SetImage} $R0 $PLUGINSDIR\bg.bmp $ImageHandle

		;�����Ǹ���������ͼ
  FindWindow $R2 "#32770" "" $HWNDPARENT
  GetDlgItem $5 $R2 1004
	;SkinProgress::Set $5 "$PLUGINSDIR\ProgressBar.bmp" "$PLUGINSDIR\Progress.bmp"
	
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
  SetCtlColors $R1 A7BAF5 transparent
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
	
	${NSD_CreateProgressBar} 16 325 481 24 ""
  Pop $PB_ProgressBar
	
	${NSD_CreateBitmap} 159 38 200 200 ""
	Pop $0
	${NSD_SetImage} $0 $PLUGINSDIR\logo.bmp $1


	GetFunctionAddress $3 un.onGUICallback
  WndProc::onCallback $0 $3 ;�����ޱ߿����ƶ�

;��������ͼ
  ${NSD_CreateBitmap} 0 0 100% 100% ""
  Pop $BGImage
  ${NSD_SetImage} $BGImage $PLUGINSDIR\bg.bmp $ImageHandle
  
  GetFunctionAddress $0 un.NSD_TimerFun
  nsDialogs::CreateTimer $0 1
  
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
  SetCtlColors $R1 A7BAF5 transparent
	${CustomSetFont} $R1 "΢���ź�" 16 400
	GetFunctionAddress $0 un.onGUICallback
	WndProc::onCallback $R1 $0
	
  ${NSD_CreateButton} 203 311 113 41 "���"
  Pop $0
  GetFunctionAddress $1 un.FinishClick
  SkinBtn::onClick $0 $1

;��������ͼ
  ${NSD_CreateBitmap} 0 0 100% 100% ""
  Pop $BGImage
  ${NSD_SetImage} $BGImage $(un.MSG_FinishBG) $ImageHandle

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

Function un.NSD_TimerFun
    GetFunctionAddress $0 un.NSD_TimerFun
    nsDialogs::KillTimer $0
    !if 1   ;�Ƿ��ں�̨����,1��Ч
        GetFunctionAddress $0 un.InstallationMainFun
        BgWorker::CallAndWait
    !else
        Call un.InstallationMainFun
    !endif
FunctionEnd

Function un.InstallationMainFun

FunctionEnd

Function un.FinishClick
SendMessage $HWNDPARENT ${WM_CLOSE} 0 0
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
; ������ж�س���ͨ����װ��־ж���ļ���ר�ú������벻Ҫ�����޸�
!macro DelFileByLog LogFile
  ifFileExists `${LogFile}` 0 +4
    Push `${LogFile}`
    Call un.DelFileByLog
    Delete `${LogFile}`
!macroend

Function un.DelFileByLog
  Exch $R0
  Push $R1
  Push $R2
  Push $R3
  FileOpen $R0 $R0 r
  ${Do}
    FileRead $R0 $R1
    ${IfThen} $R1 == `` ${|} ${ExitDo} ${|}
    StrCpy $R1 $R1 -2
    StrCpy $R2 $R1 11
    StrCpy $R3 $R1 20
    ${If} $R2 == "File: wrote"
    ${OrIf} $R2 == "File: skipp"
    ${OrIf} $R3 == "CreateShortCut: out:"
    ${OrIf} $R3 == "created uninstaller:"
      Push $R1
      Push `"`
      Call un.DelFileByLog.StrLoc
      Pop $R2
      ${If} $R2 != ""
        IntOp $R2 $R2 + 1
        StrCpy $R3 $R1 "" $R2
        Push $R3
        Push `"`
        Call un.DelFileByLog.StrLoc
        Pop $R2
        ${If} $R2 != ""
          StrCpy $R3 $R3 $R2
          Delete /REBOOTOK $R3
        ${EndIf}
      ${EndIf}
    ${EndIf}
    StrCpy $R2 $R1 7
    ${If} $R2 == "Rename:"
      Push $R1
      Push "->"
      Call un.DelFileByLog.StrLoc
      Pop $R2
      ${If} $R2 != ""
        IntOp $R2 $R2 + 2
        StrCpy $R3 $R1 "" $R2
        Delete /REBOOTOK $R3
      ${EndIf}
    ${EndIf}
  ${Loop}
  FileClose $R0
  Pop $R3
  Pop $R2
  Pop $R1
  Pop $R0
FunctionEnd

Function un.DelFileByLog.StrLoc
  Exch $R0
  Exch
  Exch $R1
  Push $R2
  Push $R3
  Push $R4
  Push $R5
  StrLen $R2 $R0
  StrLen $R3 $R1
  StrCpy $R4 0
  ${Do}
    StrCpy $R5 $R1 $R2 $R4
    ${If} $R5 == $R0
    ${OrIf} $R4 = $R3
      ${ExitDo}
    ${EndIf}
    IntOp $R4 $R4 + 1
  ${Loop}
  ${If} $R4 = $R3
    StrCpy $R0 ""
  ${Else}
    StrCpy $R0 $R4
  ${EndIf}
  Pop $R5
  Pop $R4
  Pop $R3
  Pop $R2
  Pop $R1
  Exch $R0
FunctionEnd

Section Uninstall
  ;!insertmacro MUI_STARTMENU_GETFOLDER "Application" $ICONS_GROUP
  ;Delete "$INSTDIR\${PRODUCT_NAME}.url"
  Delete "$INSTDIR\uninst.exe"
  ; ���ú�ֻ���ݰ�װ��־ж�ذ�װ�����Լ���װ�����ļ�
  !insertmacro DelFileByLog "$INSTDIR\install.log"
; �����װ���򴴽�������ж��ʱ����Ϊ�յ���Ŀ¼�����ڵݹ���ӵ��ļ�Ŀ¼���������ڲ����Ŀ¼��ʼ���(ע�⣬��Ҫ�� /r �����������ʧȥ DelFileByLog ������)
  ;RMDir "$SMPROGRAMS\$ICONS_GROUP"
  ;Delete "$INSTDIR\install.log"
	Call un.NextPage
SectionEnd
