#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Run_Au3Stripper=y
#Au3Stripper_Parameters=/so
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
; -- coded by opdo.vn
; Sử dụng lại giao diện, thiết kế trò chơi trong mã nguồn này, xin vui lòng dẫn nguồn tác giả
; Tác giả: Phạm Ngọc Vinh
; Blog: www.opdo.vn
; Donate: http://donate.opdo.vn
#include <StaticConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiButton.au3>
#include <Color.au3>
#include <Array.au3>
#include <APIGdiConstants.au3>
#include <WinAPIGdi.au3>

FileInstall('tada.wav',@TempDir & '\tada.wav')
FileInstall('drop.wav',@TempDir & '\drop.wav')
FileInstall('fontawesome.ttf',@TempDir & '\fontawesome.ttf')
_WinAPI_AddFontResourceEx(@TempDir & '\fontawesome.ttf', $FR_PRIVATE) ; load font

Opt("GUIResizeMode", 802)

Global $_GAME_DIA[0], $_GAME_COT[3][3], $_LAST_CONTROLHOVER = -1, $_NUMBER = 1, $_H, $_COUNT = 0, $_MAIN_MENU[5], $_SO_BUOC = 0
Global $GUIMAIN = GUICreate("Ha Noi Tower", 817, 374, -1, -1, $WS_POPUP, -1)
GUISetBkColor(0xFFFFFF, $GUIMAIN)
$Title_Game = GUICtrlCreateLabel("Ha Noi Tower", 0, 0, 818, 45, BitOR($SS_CENTER, $SS_CENTERIMAGE), $GUI_WS_EX_PARENTDRAG)
GUICtrlSetFont(-1, 20, 300, 0, "Segoe UI Light")
GUICtrlSetColor(-1, "0xFFFFFF")
GUICtrlSetBkColor(-1, "0x7e2b99")
$Title_Nen = GUICtrlCreateLabel("", 0, 0, 818, 45)
GUICtrlSetBkColor(-1, "0x7e2b99")
GUICtrlSetState(-1, $GUI_HIDE)
$MAIN_Showmenu = GUICtrlCreateLabel("", 0, 1, 48, 44, BitOR($SS_CENTER, $SS_CENTERIMAGE), -1)
GUICtrlSetFont(-1, 18, 400, 0, "FontAwesome")
GUICtrlSetColor(-1, "0xFFFFFF")
GUICtrlSetBkColor(-1, "0x7e2b99")
$Exit = GUICtrlCreateLabel("", 770, 1, 48, 44, BitOR($SS_CENTER, $SS_CENTERIMAGE), -1)
GUICtrlSetFont(-1, 18, 400, 0, "FontAwesome")
GUICtrlSetColor(-1, "0xFFFFFF")
GUICtrlSetBkColor(-1, "0x7e2b99")
; main menu
$_MAIN_MENU[0] = GUICtrlCreateLabel("Level " & $_NUMBER, 55, 0, 76, 45, BitOR($SS_CENTER, $SS_CENTERIMAGE), -1)
GUICtrlSetFont(-1, 11, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, "0xFFFFFF")
GUICtrlSetBkColor(-1, "0x7e2b99")
$_MAIN_MENU[1] = GUICtrlCreateLabel("About me", 283, 0, 76, 45, BitOR($SS_CENTER, $SS_CENTERIMAGE), -1)
GUICtrlSetFont(-1, 11, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, "0xFFFFFF")
GUICtrlSetBkColor(-1, "0x7e2b99")
$_MAIN_MENU[2] = GUICtrlCreateLabel("Auto play", 131, 0, 76, 45, BitOR($SS_CENTER, $SS_CENTERIMAGE), -1)
GUICtrlSetFont(-1, 11, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, "0xFFFFFF")
GUICtrlSetBkColor(-1, "0x7e2b99")
$_MAIN_MENU[3] = GUICtrlCreateLabel("Rule", 207, 0, 76, 45, BitOR($SS_CENTER, $SS_CENTERIMAGE), -1)
GUICtrlSetFont(-1, 11, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, "0xFFFFFF")
GUICtrlSetBkColor(-1, "0x7e2b99")
$_MAIN_MENU[4] = GUICtrlCreateLabel("Sound: ON", 283+80, 0, 80, 45, BitOR($SS_CENTER, $SS_CENTERIMAGE), -1)
GUICtrlSetFont(-1, 11, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, "0xFFFFFF")
GUICtrlSetBkColor(-1, "0x7e2b99")
For $x In $_MAIN_MENU
	GUICtrlSetState($x, $GUI_HIDE)
Next
$Tab = GUICtrlCreateTab(-100, -100, 0, 0)
$Tab0 = GUICtrlCreateTabItem('tab0')
$Move_Txt = GUICtrlCreateLabel("Your move: " & 0, 0, 45, 818, 25, BitOR($SS_CENTER, $SS_CENTERIMAGE), -1)
GUICtrlSetFont(-1, 10, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, "0x7e2b99")
GUICtrlSetBkColor(-1, "-2")
_Control_Create()
$Tab1 = GUICtrlCreateTabItem('tab1')
GUICtrlCreateLabel("Chúc mừng bạn đã hoàn tất!", 0, 209, 818, 40, BitOR($SS_CENTER, $SS_CENTERIMAGE), -1)
GUICtrlSetFont(-1, 22, 300, 0, "Segoe UI Light")
GUICtrlSetColor(-1, "0x7e2b99")
GUICtrlSetBkColor(-1, "-2")
$PlayAgain1 = GUICtrlCreateLabel("Next level", 396, 283, 73, 40, $SS_CENTERIMAGE, -1)
GUICtrlSetFont(-1, 12, 300, 0, "Segoe UI Light")
GUICtrlSetColor(-1, "0xFFFFFF")
GUICtrlSetBkColor(-1, "0x7e2b99")
$HuyHieu = GUICtrlCreateLabel("", 260, 100, 289, 105, BitOR($SS_CENTER, $SS_CENTERIMAGE), -1)
GUICtrlSetFont(-1, 72, 400, 0, "FontAwesome")
GUICtrlSetColor(-1, "0x7e2b99")
GUICtrlSetBkColor(-1, "-2")
$PlayAgain2 = GUICtrlCreateLabel("", 349, 283, 47, 40, BitOR($SS_CENTER, $SS_CENTERIMAGE), -1)
GUICtrlSetFont(-1, 14, 400, 0, "FontAwesome")
GUICtrlSetColor(-1, "0xFFFFFF")
GUICtrlSetBkColor(-1, "0x7e2b99")
$Tab2 = GUICtrlCreateTabItem('tab2')
GUICtrlCreateLabel("Trò chơi Tháp Hà Nội", -11, 131, 818, 52, $SS_CENTER, -1)
GUICtrlSetFont(-1, 18, 300, 0, "Segoe UI Light")
GUICtrlSetColor(-1, "0x5D2071")
GUICtrlSetBkColor(-1, "-2")
GUICtrlCreateLabel("Mô phỏng thuật toán đệ quy giải bài toán tháp Hà Nội" & @CRLF & "coded by VinhPham (opdo.vn)" & @CRLF & "Sử dụng lại mã nguồn này xin vui lòng dẫn nguồn tác giả", -11, 172, 818, 74, $SS_CENTER, -1)
GUICtrlSetFont(-1, 11, 300, 0, "Segoe UI Light")
GUICtrlSetColor(-1, "0x5D2071")
GUICtrlSetBkColor(-1, "-2")
$Back_Tab2 = GUICtrlCreateLabel("Back", 359, 253, 76, 27, BitOR($SS_CENTER, $SS_CENTERIMAGE), -1)
GUICtrlSetFont(-1, 11, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, "0xFFFFFF")
GUICtrlSetBkColor(-1, "0x7e2b99")
GUICtrlCreateTabItem("")
$Tab3 = GUICtrlCreateTabItem('tab3')
GUICtrlCreateLabel("Luật chơi Tháp Hà Nội", -11, 131, 818, 52, $SS_CENTER, -1)
GUICtrlSetFont(-1, 18, 300, 0, "Segoe UI Light")
GUICtrlSetColor(-1, "0x5D2071")
GUICtrlSetBkColor(-1, "-2")
GUICtrlCreateLabel("Di chuyển toàn bộ đĩa từ cột A sang C sao cho:" & @CRLF & "- Mỗi lần chỉ được di chuyển 1 đĩa, và phải là đĩa trên cùng" & @CRLF & "- Chỉ được đặt đĩa nhỏ lên đĩa lớn (không phân biệt thứ tự)", -11, 172, 818, 74, $SS_CENTER, -1)
GUICtrlSetFont(-1, 11, 300, 0, "Segoe UI Light")
GUICtrlSetColor(-1, "0x5D2071")
GUICtrlSetBkColor(-1, "-2")
$Back_Tab3 = GUICtrlCreateLabel("Back", 359, 253, 76, 27, BitOR($SS_CENTER, $SS_CENTERIMAGE), -1)
GUICtrlSetFont(-1, 11, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, "0xFFFFFF")
GUICtrlSetBkColor(-1, "0x7e2b99")
GUICtrlCreateTabItem("")
GUISetState(@SW_SHOW, $GUIMAIN)
While 1
	$info = GUIGetCursorInfo($GUIMAIN)
	If $info[2] Then
		Do
			$info2 = GUIGetCursorInfo($GUIMAIN)
			_ControlDrag($info[4])
		Until $info2[2] = 0
		Switch $info[4]
			Case $_MAIN_MENU[4]
				if GUICtrlRead($_MAIN_MENU[4]) == 'Sound: ON' Then
					GUICtrlSetData($_MAIN_MENU[4],'Sound: OFF')
					Else
					GUICtrlSetData($_MAIN_MENU[4],'Sound: ON')
				EndIf
			Case $_MAIN_MENU[3] ; rules
				GUICtrlSetState($Tab3, $GUI_SHOW)
			Case $_MAIN_MENU[1]
				GUICtrlSetState($Tab2, $GUI_SHOW)
			Case $Back_Tab2, $Back_Tab3
				GUICtrlSetState($Tab0, $GUI_SHOW)
			Case $_MAIN_MENU[0]
				$lv = _Choose_Level()
				If $lv <> -1 Then _Control_Create($lv)
			Case $_MAIN_MENU[2]
				GUICtrlSetData($_MAIN_MENU[2], 'Stop')
				GUICtrlSetBkColor($_MAIN_MENU[2], "0xf00e46")
				_Control_Create($_NUMBER)
				_HaNoi_Tower($_NUMBER, 1, 2, 3)
				GUICtrlSetData($_MAIN_MENU[2], 'Auto play')
				GUICtrlSetBkColor($_MAIN_MENU[2], "0x7e2b99")
			Case $MAIN_Showmenu
				If GUICtrlRead($Title_Game) = '' Then
					For $x In $_MAIN_MENU
						GUICtrlSetState($x, $GUI_HIDE)
					Next
					GUICtrlSetData($Title_Game, 'Ha Noi Tower')
					GUICtrlSetData($MAIN_Showmenu, '')
					GUICtrlSetState($Title_Nen, $GUI_HIDE)
					GUICtrlSetState($Title_Game, $GUI_SHOW)
				Else
					GUICtrlSetState($Title_Game, $GUI_HIDE)
					GUICtrlSetState($Title_Nen, $GUI_SHOW)
					GUICtrlSetData($MAIN_Showmenu, '')
					GUICtrlSetData($Title_Game, '')
					For $x In $_MAIN_MENU
						GUICtrlSetState($x, $GUI_SHOW)
					Next
				EndIf
			Case $PlayAgain2, $PlayAgain1
				_Control_Create($_NUMBER + 1)
				GUICtrlSetState($Tab0, $GUI_SHOW)
			Case $GUI_EVENT_CLOSE, $Exit
				Exit
		EndSwitch
	EndIf
	If $info[4] Then
		_ControlHover($info[4])
	Else
		_ControlNormal($_LAST_CONTROLHOVER)
	EndIf
WEnd
#Region Hiệu ứng control và move control
Func _ControlHover($control)
	If $control <> $_LAST_CONTROLHOVER Then
		If $_LAST_CONTROLHOVER <> -1 Then _ControlNormal($_LAST_CONTROLHOVER)
		Switch $control
			Case $_MAIN_MENU[0], $_MAIN_MENU[1], $_MAIN_MENU[2], $_MAIN_MENU[3], $Back_Tab2, $Back_Tab3, $_MAIN_MENU[4]
				GUICtrlSetBkColor($control, "0x712689")
			Case $PlayAgain1, $PlayAgain2
				GUICtrlSetBkColor($PlayAgain1, "0x712689")
				GUICtrlSetBkColor($PlayAgain2, "0x712689")
			Case $Exit
				GUICtrlSetColor($control, 0xf00e46)
			Case $MAIN_Showmenu
				GUICtrlSetColor($control, 0x0295a9)
			Case Else
				For $i = 0 To UBound($_GAME_DIA) - 1
					Local $myControl = $_GAME_DIA[$i]
					If $control = $myControl[0] Then
						if $myControl[1] <> -1 Then
						$change_color = _ColorGetRGB($myControl[1])
						$change_color[1] += 15
						if $change_color[1] > 255 then $change_color[1] = 255
						GUICtrlSetBkColor($myControl[0], _ColorSetRGB($change_color))
						EndIf
					EndIf
				Next
		EndSwitch
	EndIf
	$_LAST_CONTROLHOVER = $control
EndFunc   ;==>_ControlHover
Func _ControlNormal($control)
	If $_LAST_CONTROLHOVER <> -1 Then
		Switch $control
			Case $_MAIN_MENU[0], $_MAIN_MENU[1], $_MAIN_MENU[2], $_MAIN_MENU[3], $Back_Tab2, $Back_Tab3, $_MAIN_MENU[4]
				GUICtrlSetBkColor($control, "0x7e2b99")
			Case $PlayAgain1, $PlayAgain2
				GUICtrlSetBkColor($PlayAgain1, "0x7e2b99")
				GUICtrlSetBkColor($PlayAgain2, "0x7e2b99")
			Case $Exit, $MAIN_Showmenu
				GUICtrlSetColor($control, 0xFFFFFF)
			Case Else
				For $i = 0 To UBound($_GAME_DIA) - 1
					Local $myControl = $_GAME_DIA[$i]
					If $control = $myControl[0] Then
						$change_color = $myControl[1]
						GUICtrlSetBkColor($myControl[0], $change_color)
					EndIf
				Next
		EndSwitch
	EndIf
	$_LAST_CONTROLHOVER = -1
EndFunc   ;==>_ControlNormal
Func _ControlDrag($control)
	For $i = 0 To UBound($_GAME_DIA) - 1
		Local $myControl = $_GAME_DIA[$i]
		If $control = $myControl[0] Then
			Local $dia = $_GAME_COT[$myControl[2] - 1][2]
			If $dia[UBound($dia) - 1] <> GUICtrlRead($myControl[0]) Then
				If GUICtrlRead($Move_Txt) <> 'Chỉ được di chuyển đĩa ở trên cùng' Then
					GUICtrlSetData($Move_Txt, 'Chỉ được di chuyển đĩa ở trên cùng')
					GUICtrlSetColor($Move_Txt, 0xFFFFFF)
					GUICtrlSetBkColor($Move_Txt, 0xf00e46)
				EndIf
				Return 0
			EndIf
			$oldPos = ControlGetPos($GUIMAIN, '', $myControl[0])
			Local $oldMouse[2] = [Null, Null], $_LAST_COT_HOVER = -1
			GUICtrlSetFont($myControl[0], 18, 300, 0, "Segoe UI Light")
			Do
				$info_temp = GUIGetCursorInfo($GUIMAIN)
				If $oldMouse[0] = Null Then
					Local $oldMouse[2] = [$info_temp[0], $info_temp[1]]
				EndIf
				Local $biendo[2] = [$info_temp[0] - $oldMouse[0] + ControlGetPos($GUIMAIN, '', $myControl[0])[0], $info_temp[1] - $oldMouse[1] + ControlGetPos($GUIMAIN, '', $myControl[0])[1]]
				GUICtrlSetPos($myControl[0], $biendo[0], $biendo[1])
				Local $oldMouse[2] = [$info_temp[0], $info_temp[1]]
				$checkCollider = _Check_Collider($myControl[0], 1)
				If $checkCollider <> -1 Then
					If $_LAST_COT_HOVER <> $checkCollider Then
						If $_LAST_COT_HOVER <> -1 Then
							GUICtrlSetFont($_GAME_COT[$_LAST_COT_HOVER - 1][0], 14, 600, 0, "Segoe UI Semibold")
							GUICtrlSetBkColor($_GAME_COT[$_LAST_COT_HOVER - 1][0], 0x666666)
							GUICtrlSetBkColor($_GAME_COT[$_LAST_COT_HOVER - 1][1], 0x666666)
						EndIf
						GUICtrlSetFont($_GAME_COT[$checkCollider - 1][0], 25, 600, 0, "Segoe UI Semibold")
						GUICtrlSetBkColor($_GAME_COT[$checkCollider - 1][0], 0x7e2b99)
						GUICtrlSetBkColor($_GAME_COT[$checkCollider - 1][1], 0x7e2b99)
					EndIf
					$_LAST_COT_HOVER = $checkCollider
				Else
					If $_LAST_COT_HOVER <> -1 Then
						GUICtrlSetFont($_GAME_COT[$_LAST_COT_HOVER - 1][0], 14, 600, 0, "Segoe UI Semibold")
						GUICtrlSetBkColor($_GAME_COT[$_LAST_COT_HOVER - 1][0], 0x666666)
						GUICtrlSetBkColor($_GAME_COT[$_LAST_COT_HOVER - 1][1], 0x666666)
					EndIf
					$_LAST_COT_HOVER = -1
				EndIf
			Until $info_temp[2] = 0
			GUICtrlSetFont($myControl[0], 11, 300, 0, "Segoe UI Light")
			If $_LAST_COT_HOVER <> -1 Then
				GUICtrlSetFont($_GAME_COT[$_LAST_COT_HOVER - 1][0], 14, 600, 0, "Segoe UI Semibold")
				GUICtrlSetBkColor($_GAME_COT[$_LAST_COT_HOVER - 1][0], 0x666666)
				GUICtrlSetBkColor($_GAME_COT[$_LAST_COT_HOVER - 1][1], 0x666666)
			EndIf
			$checkCollider = _Check_Collider($myControl[0])
			If $checkCollider = -1 Or $myControl[2] = $checkCollider Then
				GUICtrlSetPos($myControl[0], $oldPos[0], $oldPos[1])
			Else
				_ControlDrop($_GAME_DIA[$i], $checkCollider)
				$myControl[2] = $checkCollider
				$_GAME_DIA[$i] = $myControl
			EndIf
			ExitLoop
		EndIf
	Next
EndFunc   ;==>_ControlDrag
Func _Check_Collider($control, $flag = 0)
	$myPos = ControlGetPos($GUIMAIN, '', $control)
	For $i = 0 To 2
		$cotPos = ControlGetPos($GUIMAIN, '', $_GAME_COT[$i][1])
		If $myPos[0] < $cotPos[0] And $myPos[0] + $myPos[2] > $cotPos[0] + $cotPos[2] Then
			If $myPos[1] + $myPos[3] > $cotPos[1] And $myPos[1] + $myPos[3] < $cotPos[1] + $cotPos[3] Then
				If $flag = 0 Then
					Local $dia = $_GAME_COT[$i][2]
					If IsArray($dia) Then
						For $j = 0 To UBound($dia) - 1
							If Number($dia[$j]) < Number(GUICtrlRead($control)) Then
								GUICtrlSetData($Move_Txt, 'Đĩa lớn KHÔNG được đặt bên trên đĩa nhỏ hơn')
								GUICtrlSetColor($Move_Txt, 0xFFFFFF)
								GUICtrlSetBkColor($Move_Txt, 0xf00e46)
								Return -1
							EndIf
						Next
					EndIf
				EndIf
				Return $i + 1
			EndIf
		EndIf
	Next

	Return -1
EndFunc   ;==>_Check_Collider
Func _ControlDrop($control, $cot)
	Local $myControl = $control
	$dia = $_GAME_COT[$cot - 1][2]
	$cotPos = ControlGetPos($GUIMAIN, '', $_GAME_COT[$cot - 1][0])
	$diaPos = ControlGetPos($GUIMAIN, '', $myControl[0])
	If Not IsArray($dia) Then
		Local $dia[1] = [GUICtrlRead($myControl[0])]
	Else
		_ArrayAdd($dia, GUICtrlRead($myControl[0]))
	EndIf
	$_GAME_COT[$cot - 1][2] = $dia
	Local $diaOld = $_GAME_COT[$myControl[2] - 1][2]
	For $i = 0 To UBound($diaOld) - 1
		If $diaOld[$i] = GUICtrlRead($myControl[0]) Then
			_ArrayDelete($diaOld, $i)
			ExitLoop
		EndIf
	Next
	$_GAME_COT[$myControl[2] - 1][2] = $diaOld
	GUICtrlSetPos($myControl[0], $cotPos[0] + Int((226 - $diaPos[2]) / 2), (310 - $_H) - $_H * (UBound($dia) - 1))

	$_COUNT += 1
	GUICtrlSetData($Move_Txt, 'Your move: ' & $_COUNT & ' - Best move: ' & $_SO_BUOC)
	GUICtrlSetBkColor($Move_Txt, -2)
	GUICtrlSetColor($Move_Txt, 0x7e2b99)
	If _CheckWin() Then
		if GUICtrlRead($_MAIN_MENU[4]) == 'Sound: ON' Then SoundPlay(@TempDir & '\tada.wav')
		Sleep(500)
		GUICtrlSetState($Tab1, $GUI_SHOW)
	Else
		if GUICtrlRead($_MAIN_MENU[4]) == 'Sound: ON' Then SoundPlay(@TempDir & '\drop.wav')
	EndIf
EndFunc   ;==>_ControlDrop
Func _Control_Create($replay = 0)
	GUISwitch($GUIMAIN, $Tab0)
	If $replay = 0 Then
		For $i = 0 To 2
			$_GAME_COT[$i][0] = GUICtrlCreateLabel(Chr(65 + $i), 27 + $i * 265, 310, 226, 34, BitOR($SS_CENTER, $SS_CENTERIMAGE), -1)
			GUICtrlSetFont(-1, 14, 600, 0, "Segoe UI Semibold")
			GUICtrlSetColor(-1, "0xFFFFFF")
			GUICtrlSetBkColor(-1, "0x666666")
			$_GAME_COT[$i][1] = GUICtrlCreateLabel("", 137 + $i * 265, 95, 6, 195 + 20)
			GUICtrlSetBkColor(-1, "0x666666")
		Next
		$i -= 1
		GUICtrlCreateLabel("", 137 + $i * 265 - 45, 95, 45, 25, BitOR($SS_CENTER, $SS_CENTERIMAGE))
		GUICtrlSetFont(-1, 14, 400, 0, "FontAwesome")
		GUICtrlSetBkColor(-1, "0xe50000")
		GUICtrlSetColor(-1, "0xffff32")
	Else
		For $j = 0 To $_NUMBER - 1
			$control = $_GAME_DIA[0]
			GUICtrlDelete($control[0])
			_ArrayDelete($_GAME_DIA, 0)
		Next
		$_GAME_COT[0][2] = ''
		$_GAME_COT[1][2] = ''
		$_GAME_COT[2][2] = ''
		$_NUMBER = $replay
	EndIf
	$_COUNT = 0
	$_SO_BUOC = 0
	_HaNoi_Tower($_NUMBER, 1, 2, 3, 1)
	GUICtrlSetData($_MAIN_MENU[0], "Level " & $_NUMBER)
	GUICtrlSetData($Move_Txt, 'Your move: ' & $_COUNT & ' - Best move: ' & $_SO_BUOC)
	GUICtrlSetBkColor($Move_Txt, -2)
	GUICtrlSetColor($Move_Txt, 0x7e2b99)
	$i = 0
	$_H = Int((195 - 20) / $_NUMBER)
	Local $dia[0]
	For $j = 0 To $_NUMBER - 1
		Local $control[3]
		$myW = 206 - 20 * $j
		if $myW < 20 Then $myW = 20
		$control[0] = GUICtrlCreateLabel($_NUMBER - $j, 27 + Int((226 - $myW) / 2), (310 - $_H) - $_H * $j, $myW, $_H, BitOR($SS_CENTER, $SS_CENTERIMAGE), -1)
		GUICtrlSetFont(-1, 11, 300, 0, "Segoe UI Light")
		GUICtrlSetColor(-1, "0xFFFFFF")
		$change_color = _ColorGetRGB("0x00264c")
		$change_color[1] += 30 * $j
		If $change_color[1] > 255 Then 
			 $change_color[1] = 255
			$change_color[2] += 30 * $j - 255
		EndIf
		If $change_color[2] > 255 Then
			 $change_color[2] = 255
			 $change_color[3] += 30 * $j - 255
		EndIf
		$color = _ColorSetRGB($change_color)
		GUICtrlSetBkColor(-1, $color)
		$control[1] = $color
		$control[2] = 1
		_ArrayAdd($_GAME_DIA, '')
		$_GAME_DIA[$j] = $control
		_ArrayAdd($dia, GUICtrlRead($control[0]))
	Next
	$_GAME_COT[0][2] = $dia
	GUICtrlCreateTabItem("")
EndFunc   ;==>_Control_Create
#EndRegion Hiệu ứng control và move control
#Region Đệ quy giải tháp Hà Nội
Func _HaNoi_Tower($n, $cot1, $cot2, $cot3, $tinh_so_buoc = 0) ; n là số đĩa
	If $n == 1 Then
		;MsgBox(0,0,'chuyen '&$n&' tu '&$cot1&' sang '&$cot3)
		If $tinh_so_buoc = 1 Then
			$_SO_BUOC += 1
		Else
			_Move_Dia($_NUMBER - $n, $cot3)
			If @error Then Return SetError(1, 0, 0)
		EndIf
	Else
		_HaNoi_Tower($n - 1, $cot1, $cot3, $cot2, $tinh_so_buoc)
		If @error Then Return SetError(1, 0, 0)
		;MsgBox(0,0,'chuyen '&$n&' tu '&$cot1&' sang '&$cot3)
		If $tinh_so_buoc = 1 Then
			$_SO_BUOC += 1
		Else
			_Move_Dia($_NUMBER - $n, $cot3)
			If @error Then Return SetError(1, 0, 0)
		EndIf
		_HaNoi_Tower($n - 1, $cot2, $cot1, $cot3, $tinh_so_buoc)
		If @error Then Return SetError(1, 0, 0)
	EndIf
EndFunc   ;==>_HaNoi_Tower
Func _Move_Dia($id, $cot)
	Local $flag = False
	$_LAST_COT_HOVER = -1
	$myControl = $_GAME_DIA[$id]
	$myPos = ControlGetPos($GUIMAIN, '', $myControl[0])
	$cotPos = ControlGetPos($GUIMAIN, '', $_GAME_COT[$cot - 1][0])
	For $i = $myPos[1] To 120 Step -5
		$info = GUIGetCursorInfo($GUIMAIN)
		If $info[2] Then
			Do
				$info = GUIGetCursorInfo($GUIMAIN)
			Until $info[2] = 0
			If $info[4] = $_MAIN_MENU[2] Then
				$flag = True
				ExitLoop
			EndIf
		EndIf
		GUICtrlSetPos($myControl[0], Default, $i)
		$checkCollider = _Check_Collider($myControl[0], 1)
		If $checkCollider <> -1 Then
			If $_LAST_COT_HOVER <> $checkCollider Then
				If $_LAST_COT_HOVER <> -1 Then
					GUICtrlSetFont($_GAME_COT[$_LAST_COT_HOVER - 1][0], 14, 600, 0, "Segoe UI Semibold")
					GUICtrlSetBkColor($_GAME_COT[$_LAST_COT_HOVER - 1][0], 0x666666)
					GUICtrlSetBkColor($_GAME_COT[$_LAST_COT_HOVER - 1][1], 0x666666)
				EndIf
				GUICtrlSetFont($_GAME_COT[$checkCollider - 1][0], 25, 600, 0, "Segoe UI Semibold")
				GUICtrlSetBkColor($_GAME_COT[$checkCollider - 1][0], 0x7e2b99)
				GUICtrlSetBkColor($_GAME_COT[$checkCollider - 1][1], 0x7e2b99)
			EndIf
			$_LAST_COT_HOVER = $checkCollider
		Else
			If $_LAST_COT_HOVER <> -1 Then
				GUICtrlSetFont($_GAME_COT[$_LAST_COT_HOVER - 1][0], 14, 600, 0, "Segoe UI Semibold")
				GUICtrlSetBkColor($_GAME_COT[$_LAST_COT_HOVER - 1][0], 0x666666)
				GUICtrlSetBkColor($_GAME_COT[$_LAST_COT_HOVER - 1][1], 0x666666)
			EndIf
			$_LAST_COT_HOVER = -1
		EndIf
		Sleep(1)
	Next
	If $flag = False Then
		$to = $cotPos[0] + Int(($cotPos[2] - $myPos[2]) / 2)
		$step = $myPos[0] > $to ? -5 : 5
		For $i = $myPos[0] To $to Step $step
			$info = GUIGetCursorInfo($GUIMAIN)
			If $info[2] Then
				Do
					$info = GUIGetCursorInfo($GUIMAIN)
				Until $info[2] = 0
				If $info[4] = $_MAIN_MENU[2] Then
					$flag = True
					ExitLoop
				EndIf
			EndIf
			GUICtrlSetPos($myControl[0], $i)
			$checkCollider = _Check_Collider($myControl[0], 1)
			If $checkCollider <> -1 Then
				If $_LAST_COT_HOVER <> $checkCollider Then
					If $_LAST_COT_HOVER <> -1 Then
						GUICtrlSetFont($_GAME_COT[$_LAST_COT_HOVER - 1][0], 14, 600, 0, "Segoe UI Semibold")
						GUICtrlSetBkColor($_GAME_COT[$_LAST_COT_HOVER - 1][0], 0x666666)
						GUICtrlSetBkColor($_GAME_COT[$_LAST_COT_HOVER - 1][1], 0x666666)
					EndIf
					GUICtrlSetFont($_GAME_COT[$checkCollider - 1][0], 25, 600, 0, "Segoe UI Semibold")
					GUICtrlSetBkColor($_GAME_COT[$checkCollider - 1][0], 0x7e2b99)
					GUICtrlSetBkColor($_GAME_COT[$checkCollider - 1][1], 0x7e2b99)
				EndIf
				$_LAST_COT_HOVER = $checkCollider
			Else
				If $_LAST_COT_HOVER <> -1 Then
					GUICtrlSetFont($_GAME_COT[$_LAST_COT_HOVER - 1][0], 14, 600, 0, "Segoe UI Semibold")
					GUICtrlSetBkColor($_GAME_COT[$_LAST_COT_HOVER - 1][0], 0x666666)
					GUICtrlSetBkColor($_GAME_COT[$_LAST_COT_HOVER - 1][1], 0x666666)
				EndIf
				$_LAST_COT_HOVER = -1
			EndIf
			Sleep(1)
		Next
		If $_LAST_COT_HOVER <> -1 Then
			GUICtrlSetFont($_GAME_COT[$_LAST_COT_HOVER - 1][0], 14, 600, 0, "Segoe UI Semibold")
			GUICtrlSetBkColor($_GAME_COT[$_LAST_COT_HOVER - 1][0], 0x666666)
			GUICtrlSetBkColor($_GAME_COT[$_LAST_COT_HOVER - 1][1], 0x666666)
		EndIf
	EndIf
	$checkCollider = _Check_Collider($myControl[0])
	If $checkCollider = -1 Or $myControl[2] = $checkCollider Then
		GUICtrlSetPos($myControl[0], $myPos[0], $myPos[1])
	Else
		_ControlDrop($_GAME_DIA[$id], $checkCollider)
		$myControl[2] = $checkCollider
		$_GAME_DIA[$id] = $myControl
	EndIf
	If $flag = True Then Return SetError(1, 0, 0)
EndFunc   ;==>_Move_Dia
Func _CheckWin()
	Local $dia = $_GAME_COT[2][2]
	If IsArray($dia) Then
		If UBound($dia) = $_NUMBER Then Return True
	EndIf
	Return False
EndFunc   ;==>_CheckWin
#EndRegion Đệ quy giải tháp Hà Nội
Func _Choose_Level()
	$winpos = WinGetPos($GUIMAIN)
	Local $level, $_little_last_hover = -1
	$GUI_LEVEL = GUICreate("Level", 76, 44, $winpos[0] + 55, $winpos[1] + 44, $WS_POPUP, $WS_EX_TOOLWINDOW)
	GUISetBkColor(0x7e2b99, $GUI_LEVEL)
	Local $lv[4]
	$lv[1] = GUICtrlCreateLabel("Level 1", 0, 44, 76, 44, BitOR($SS_CENTER, $SS_CENTERIMAGE), -1)
	GUICtrlSetFont(-1, 11, 400, 0, "Segoe UI")
	GUICtrlSetColor(-1, "0xFFFFFF")
	GUICtrlSetBkColor(-1, "0x7e2b99")
	$lv[2] = GUICtrlCreateLabel("Level 6", 0, 88, 76, 44, BitOR($SS_CENTER, $SS_CENTERIMAGE), -1)
	GUICtrlSetFont(-1, 11, 400, 0, "Segoe UI")
	GUICtrlSetColor(-1, "0xFFFFFF")
	GUICtrlSetBkColor(-1, "0x7e2b99")
	$lv[3] = GUICtrlCreateLabel("Level 6", 0, 132, 76, 44, BitOR($SS_CENTER, $SS_CENTERIMAGE), -1)
	GUICtrlSetFont(-1, 11, 400, 0, "Segoe UI")
	GUICtrlSetColor(-1, "0xFFFFFF")
	GUICtrlSetBkColor(-1, "0x7e2b99")
	$lv[0] = GUICtrlCreateLabel("Level 6", 0, 0, 76, 44, BitOR($SS_CENTER, $SS_CENTERIMAGE), -1)
	GUICtrlSetFont(-1, 11, 400, 0, "Segoe UI")
	GUICtrlSetColor(-1, "0xFFFFFF")
	GUICtrlSetBkColor(-1, "0x7e2b99")
	For $i = 0 To 3
		If $_NUMBER <= 1 Then
			$lLevel = $i + 2
		ElseIf $_NUMBER <= 2 Then
			$lLevel = $_NUMBER + $i
			If $i = 0 Then $lLevel = 1
		Else
			If $i <= 1 Then
				$lLevel = $_NUMBER + ($i - 2)
			Else
				$lLevel = $_NUMBER + ($i - 1)
			EndIf
		EndIf
		GUICtrlSetData($lv[$i], 'Level ' & $lLevel)
	Next
	GUISetState(@SW_SHOW, $GUI_LEVEL)
	;0x712689
	For $i = 44 To 44 * 4 Step 2
		WinMove($GUI_LEVEL, '', Default, Default, Default, $i)
		Sleep(5)
	Next
	While 1
		If BitAND(WinGetState($GUI_LEVEL), 8) <> 8 Then Return -1
		$info = GUIGetCursorInfo($GUI_LEVEL)
		If $info[4] Then
			Switch $info[4]
				Case $lv[0], $lv[1], $lv[2], $lv[3]
					If $info[4] <> $_little_last_hover Then
						If $_little_last_hover <> -1 Then GUICtrlSetBkColor($_little_last_hover, "0x7e2b99")
						GUICtrlSetBkColor($info[4], "0x712689")
						$_little_last_hover = $info[4]
					EndIf
			EndSwitch
		Else
			Switch $_little_last_hover
				Case $lv[0], $lv[1], $lv[2], $lv[3]
					If $_little_last_hover <> -1 Then
						GUICtrlSetBkColor($info[4], "0x7e2b99")
						$_little_last_hover = -1
					EndIf
			EndSwitch
		EndIf
		$nMsg = GUIGetMsg($GUI_LEVEL)
		Switch $nMsg
			Case $lv[0], $lv[1], $lv[2], $lv[3]
				$level = Number(StringReplace(GUICtrlRead($nMsg), 'Level ', ''))
				GUIDelete($GUI_LEVEL)
				ExitLoop
		EndSwitch
	WEnd
	Return $level
EndFunc   ;==>_Choose_Level