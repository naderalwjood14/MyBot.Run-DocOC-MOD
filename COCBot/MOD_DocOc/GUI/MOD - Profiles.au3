; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Design
; Description ...: This file creates the "Profiles" tab under the "Bot" tab
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........:
; Modified ......: CodeSlinger69 (2017)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
#include-once

Global $g_hGUI_MOD_SWITCH = 0, $g_hGUI_MOD_SWITCH_TAB = 0, $g_hGUI_MOD_SWITCH_TAB_ITEM1 = 0, $g_hGUI_MOD_SWITCH_TAB_ITEM2 = 0	; Adding SubTab - Switch Profiles and SwitchAccounts to DocOC_Mod_Tab

; Profiles & SwitchAcc_DocOc_Style
Global $g_hCmbProfile = 0, $g_hTxtVillageName = 0, $g_hBtnAddProfile = 0, $g_hBtnConfirmAddProfile = 0, $g_hBtnConfirmRenameProfile = 0, _
	   $g_hBtnDeleteProfile = 0, $g_hBtnCancelProfileChange = 0, $g_hBtnRenameProfile = 0, $g_hBtnRecycle = 0
Global $chkEnableSwitchAccount, $lblNB, $cmbAccountsQuantity

Global $chkCanUse[9] = [0, 0, 0, 0, 0, 0, 0, 0, 0]
Global $chkDonateAccount[9] = [0, 0, 0, 0, 0, 0, 0, 0, 0]
Global $cmbAccount[9] = [0, 0, 0, 0, 0, 0, 0, 0, 0]

; SwitchAcc_Demen_Style
Global $g_hRdoSwitchAcc_DocOc = 0, $g_hRdoSwitchAcc_Demen = 0, $g_StartHideSwitchAcc_DocOc = 0, $g_EndHideSwitchAcc_DocOc = 0

; Switch Profiles
Global $g_hChkGoldSwitchMax = 0, $g_hCmbGoldMaxProfile = 0, $g_hTxtMaxGoldAmount = 0, $g_hChkGoldSwitchMin = 0, $g_hCmbGoldMinProfile = 0, $g_hTxtMinGoldAmount = 0, _
	   $g_hChkElixirSwitchMax = 0, $g_hCmbElixirMaxProfile = 0, $g_hTxtMaxElixirAmount = 0, $g_hChkElixirSwitchMin = 0, $g_hCmbElixirMinProfile = 0, $g_hTxtMinElixirAmount = 0, _
	   $g_hChkDESwitchMax = 0, $g_hCmbDEMaxProfile = 0, $g_hTxtMaxDEAmount = 0, $g_hChkDESwitchMin = 0, $g_hCmbDEMinProfile = 0, $g_hTxtMinDEAmount = 0, _
	   $g_hChkTrophySwitchMax = 0, $g_hCmbTrophyMaxProfile = 0, $g_hTxtMaxTrophyAmount = 0, $g_hChkTrophySwitchMin = 0, $g_hCmbTrophyMinProfile = 0, $g_hTxtMinTrophyAmount = 0

#include "..\..\MOD_DocOc++\GUI\GUI Design SwitchAcc_Demen.au3"
#include "..\..\MOD_DocOc++\GUI\GUI Design ProfileStats_Demen.au3"

Func CreateModProfiles()

	$g_hGUI_MOD_SWITCH = GUICreate("", $_GUI_MAIN_WIDTH - 28, $_GUI_MAIN_HEIGHT - 255 - 28, 5, 25, BitOR($WS_CHILD, $WS_TABSTOP), -1, $g_hGUI_MOD)

	GUISwitch($g_hGUI_MOD_SWITCH)
	$g_hGUI_MOD_SWITCH_TAB = GUICtrlCreateTab(0, 0, $_GUI_MAIN_WIDTH - 30, $_GUI_MAIN_HEIGHT - 255 - 30, BitOR($TCS_MULTILINE, $TCS_RIGHTJUSTIFY))
	$g_hGUI_MOD_SWITCH_TAB_ITEM1 = GUICtrlCreateTabItem(GetTranslated(600, 62, "Switch Accounts"))
		CreateSwitchAcc_DocOc()
	$g_hGUI_MOD_SWITCH_TAB_ITEM2 = GUICtrlCreateTabItem(GetTranslated(600, 63, "Switch Profiles"))
		CreateModSwitchProfile()
	GUICtrlCreateTabItem("")

EndFunc

#Region Profiles Subtab
Func CreateSwitchAcc_DocOc()

    Local $x = 25, $y = 45
	GUICtrlCreateGroup(GetTranslated(637,1, "Switch Profiles"), $x - 20, $y - 20, 430, 360)
		$x -= 5
		$g_hCmbProfile = GUICtrlCreateCombo("", $x - 3, $y + 1, 130, 18, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			_GUICtrlSetTip(-1, GetTranslated(637,2, "Use this to switch to a different profile")& @CRLF & _
							   GetTranslated(637,3, "Your profiles can be found in") & ": " & @CRLF & $g_sProfilePath)
			setupProfileComboBox()
			PopulatePresetComboBox()
			GUICtrlSetState(-1, $GUI_SHOW)
			GUICtrlSetOnEvent(-1, "cmbProfile")
		$g_hTxtVillageName = GUICtrlCreateInput(GetTranslated(637,4, "MyVillage"), $x - 3, $y, 130, 22, $ES_AUTOHSCROLL)
			GUICtrlSetLimit (-1, 100, 0)
			GUICtrlSetFont(-1, 9, 400, 1)
			_GUICtrlSetTip(-1, GetTranslated(637,5, "Your village/profile's name"))
			GUICtrlSetState(-1, $GUI_HIDE)

		Local $bIconAdd = _GUIImageList_Create(24, 24, 4)
			_GUIImageList_AddBitmap($bIconAdd, @ScriptDir & "\images\Button\iconAdd.bmp")
			_GUIImageList_AddBitmap($bIconAdd, @ScriptDir & "\images\Button\iconAdd_2.bmp")
			_GUIImageList_AddBitmap($bIconAdd, @ScriptDir & "\images\Button\iconAdd_2.bmp")
			_GUIImageList_AddBitmap($bIconAdd, @ScriptDir & "\images\Button\iconAdd_4.bmp")
			_GUIImageList_AddBitmap($bIconAdd, @ScriptDir & "\images\Button\iconAdd.bmp")
		Local $bIconConfirm = _GUIImageList_Create(24, 24, 4)
			_GUIImageList_AddBitmap($bIconConfirm, @ScriptDir & "\images\Button\iconConfirm.bmp")
			_GUIImageList_AddBitmap($bIconConfirm, @ScriptDir & "\images\Button\iconConfirm_2.bmp")
			_GUIImageList_AddBitmap($bIconConfirm, @ScriptDir & "\images\Button\iconConfirm_2.bmp")
			_GUIImageList_AddBitmap($bIconConfirm, @ScriptDir & "\images\Button\iconConfirm_4.bmp")
			_GUIImageList_AddBitmap($bIconConfirm, @ScriptDir & "\images\Button\iconConfirm.bmp")
		Local $bIconDelete = _GUIImageList_Create(24, 24, 4)
			_GUIImageList_AddBitmap($bIconDelete, @ScriptDir & "\images\Button\iconDelete.bmp")
			_GUIImageList_AddBitmap($bIconDelete, @ScriptDir & "\images\Button\iconDelete_2.bmp")
			_GUIImageList_AddBitmap($bIconDelete, @ScriptDir & "\images\Button\iconDelete_2.bmp")
			_GUIImageList_AddBitmap($bIconDelete, @ScriptDir & "\images\Button\iconDelete_4.bmp")
			_GUIImageList_AddBitmap($bIconDelete, @ScriptDir & "\images\Button\iconDelete.bmp")
		Local $bIconCancel = _GUIImageList_Create(24, 24, 4)
			_GUIImageList_AddBitmap($bIconCancel, @ScriptDir & "\images\Button\iconCancel.bmp")
			_GUIImageList_AddBitmap($bIconCancel, @ScriptDir & "\images\Button\iconCancel_2.bmp")
			_GUIImageList_AddBitmap($bIconCancel, @ScriptDir & "\images\Button\iconCancel_2.bmp")
			_GUIImageList_AddBitmap($bIconCancel, @ScriptDir & "\images\Button\iconCancel_4.bmp")
			_GUIImageList_AddBitmap($bIconCancel, @ScriptDir & "\images\Button\iconCancel.bmp")
		Local $bIconEdit = _GUIImageList_Create(24, 24, 4)
			_GUIImageList_AddBitmap($bIconEdit, @ScriptDir & "\images\Button\iconEdit.bmp")
			_GUIImageList_AddBitmap($bIconEdit, @ScriptDir & "\images\Button\iconEdit_2.bmp")
			_GUIImageList_AddBitmap($bIconEdit, @ScriptDir & "\images\Button\iconEdit_2.bmp")
			_GUIImageList_AddBitmap($bIconEdit, @ScriptDir & "\images\Button\iconEdit_4.bmp")
			_GUIImageList_AddBitmap($bIconEdit, @ScriptDir & "\images\Button\iconEdit.bmp")

		; IceCube (Misc v1.0)
		Local $bIconRecycle = _GUIImageList_Create(24, 24, 4)
			_GUIImageList_AddBitmap($bIconRecycle, @ScriptDir & "\images\Button\iconRecycle.bmp")
			_GUIImageList_AddBitmap($bIconRecycle, @ScriptDir & "\images\Button\iconRecycle_2.bmp")
			_GUIImageList_AddBitmap($bIconRecycle, @ScriptDir & "\images\Button\iconRecycle_2.bmp")
			_GUIImageList_AddBitmap($bIconRecycle, @ScriptDir & "\images\Button\iconRecycle_4.bmp")
			_GUIImageList_AddBitmap($bIconRecycle, @ScriptDir & "\images\Button\iconRecycle.bmp")
		; IceCube (Misc v1.0)

		$g_hBtnAddProfile = GUICtrlCreateButton("", $x + 135, $y, 24, 24)
			_GUICtrlButton_SetImageList($g_hBtnAddProfile, $bIconAdd, 4)
			GUICtrlSetOnEvent(-1, "btnAddConfirm")
			GUICtrlSetState(-1, $GUI_SHOW)
			_GUICtrlSetTip(-1, GetTranslated(637,6, "Add New Profile"))
		$g_hBtnConfirmAddProfile = GUICtrlCreateButton("", $x + 135, $y, 24, 24)
			_GUICtrlButton_SetImageList($g_hBtnConfirmAddProfile, $bIconConfirm, 4)
			GUICtrlSetOnEvent(-1, "btnAddConfirm")
			GUICtrlSetState(-1, $GUI_HIDE)
			_GUICtrlSetTip(-1, GetTranslated(637,7, "Confirm"))
		$g_hBtnConfirmRenameProfile = GUICtrlCreateButton("", $x + 135, $y, 24, 24)
			_GUICtrlButton_SetImageList($g_hBtnConfirmRenameProfile, $bIconConfirm, 4)
			GUICtrlSetOnEvent(-1, "btnRenameConfirm")
			GUICtrlSetState(-1, $GUI_HIDE)
			_GUICtrlSetTip(-1, GetTranslated(637,7, -1))
		$g_hBtnDeleteProfile = GUICtrlCreateButton("", $x + 164, $y, 24, 24)
			_GUICtrlButton_SetImageList($g_hBtnDeleteProfile, $bIconDelete, 4)
			GUICtrlSetOnEvent(-1, "btnDeleteCancel")
			GUICtrlSetState(-1, $GUI_SHOW)
			_GUICtrlSetTip(-1, GetTranslated(637,8, "Delete Profile"))
		$g_hBtnCancelProfileChange = GUICtrlCreateButton("", $x + 164, $y, 24, 24)
			_GUICtrlButton_SetImageList($g_hBtnCancelProfileChange, $bIconCancel, 4)
			GUICtrlSetOnEvent(-1, "btnDeleteCancel")
			GUICtrlSetState(-1, $GUI_HIDE)
			_GUICtrlSetTip(-1, GetTranslated(637,9, "Cancel"))
		$g_hBtnRenameProfile = GUICtrlCreateButton("", $x + 194, $y, 24, 24)
			_GUICtrlButton_SetImageList($g_hBtnRenameProfile, $bIconEdit, 4)
			GUICtrlSetOnEvent(-1, "btnRenameConfirm")
			_GUICtrlSetTip(-1, GetTranslated(637,10, "Rename Profile"))

		; IceCube (Misc v1.0)
		$g_hBtnRecycle = GUICtrlCreateButton("", $x + 223, $y + 2, 22, 22)
			_GUICtrlButton_SetImageList($g_hBtnRecycle, $bIconRecycle, 4)
			GUICtrlSetOnEvent(-1, "btnRecycle")
			GUICtrlSetState(-1, $GUI_SHOW)
			_GUICtrlSetTip(-1, GetTranslated(637,50, "Recycle Profile by removing all settings no longer suported that could lead to bad behaviour"))
			If GUICtrlRead($g_hCmbProfile) = "<No Profiles>" Then
				GUICtrlSetState(-1, $GUI_DISABLE)
			Else
				GUICtrlSetState(-1, $GUI_ENABLE)
			EndIf
		; IceCube (Misc v1.0)

	GUICtrlCreateGroup("", -99, -99, 1, 1)


	Local $x = 8, $z = 189, $w = 357, $y = 85
	$g_StartHideSwitchAcc_DocOc = GUICtrlCreateDummy()	; Hide DocOc SwitchAcc to make room for SwitchAcc_Demen_Style
	GUICtrlCreateGroup(GetTranslated(108,1, "Smart Switch Accounts"), $x, $y, 425, 295)
		$x += 10
		$y += 20
			$chkEnableSwitchAccount = GUICtrlCreateCheckbox(GetTranslated(108,2, "Use Smart Switch Accounts"), $x, $y, 152, 17)
				GUICtrlSetOnEvent(-1, "chkSwitchAccount")
			$lblNB = GUICtrlCreateLabel(GetTranslated(108,3, "Number of accounts on Emulator :"), $x + 195, $y + 2, 165, 17)
			$cmbAccountsQuantity = GUICtrlCreateCombo("", $x + 365, $y - 2, 45, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
				GUICtrlSetOnEvent(-1, "cmbAccountsQuantity")
				GUICtrlSetData(-1, "2|3|4|5|6|7|8", "2")
		$y += 35
			$chkCanUse[1] = GUICtrlCreateCheckbox(GetTranslated(108,4, "Use Account 1 with Profile :"), $x, $y, 150, 17)
				GUICtrlSetOnEvent(-1, "chkAccountsProperties")
			$cmbAccount[1] = GUICtrlCreateCombo("", $z, $y - 2, 145, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
			$chkDonateAccount[1] = GUICtrlCreateCheckbox(GetTranslated(108,5, "Donate only"), $w, $y, 75, 17)
				GUICtrlSetOnEvent(-1, "chkAccountsProperties")
		$y += 30
			$chkCanUse[2] = GUICtrlCreateCheckbox(GetTranslated(108,6, "Use Account 2 with Profile :"), $x, $y, 150, 17)
				GUICtrlSetOnEvent(-1, "chkAccountsProperties")
			$cmbAccount[2] = GUICtrlCreateCombo("", $z, $y - 2, 145, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
			$chkDonateAccount[2] = GUICtrlCreateCheckbox(GetTranslated(108,5, "Donate only"), $w, $y, 75, 17)
				GUICtrlSetOnEvent(-1, "chkAccountsProperties")
		$y += 30
			$chkCanUse[3] = GUICtrlCreateCheckbox(GetTranslated(108,7, "Use Account 3 with Profile :"), $x, $y, 150, 17)
				GUICtrlSetOnEvent(-1, "chkAccountsProperties")
			$cmbAccount[3] = GUICtrlCreateCombo("", $z, $y - 2, 145, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
			$chkDonateAccount[3] = GUICtrlCreateCheckbox(GetTranslated(108,5, "Donate only"), $w, $y, 75, 17)
				GUICtrlSetOnEvent(-1, "chkAccountsProperties")
		$y += 30
			$chkCanUse[4] = GUICtrlCreateCheckbox(GetTranslated(108,8, "Use Account 4 with Profile :"), $x, $y, 150, 17)
				GUICtrlSetOnEvent(-1, "chkAccountsProperties")
			$cmbAccount[4] = GUICtrlCreateCombo("", $z, $y - 2, 145, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
			$chkDonateAccount[4] = GUICtrlCreateCheckbox(GetTranslated(108,5, "Donate only"), $w, $y, 75, 17)
				GUICtrlSetOnEvent(-1, "chkAccountsProperties")
		$y += 30
			$chkCanUse[5] = GUICtrlCreateCheckbox(GetTranslated(108,9, "Use Account 5 with Profile :"), $x, $y, 150, 17)
				GUICtrlSetOnEvent(-1, "chkAccountsProperties")
			$cmbAccount[5] = GUICtrlCreateCombo("", $z, $y - 2, 145, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
			$chkDonateAccount[5] = GUICtrlCreateCheckbox(GetTranslated(108,5, "Donate only"), $w, $y, 75, 17)
				GUICtrlSetOnEvent(-1, "chkAccountsProperties")
		$y += 30
			$chkCanUse[6] = GUICtrlCreateCheckbox(GetTranslated(108,10, "Use Account 6 with Profile :"), $x, $y, 150, 17)
				GUICtrlSetOnEvent(-1, "chkAccountsProperties")
			$cmbAccount[6] = GUICtrlCreateCombo("", $z, $y - 2, 145, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
			$chkDonateAccount[6] = GUICtrlCreateCheckbox(GetTranslated(108,5, "Donate only"), $w, $y, 75, 17)
				GUICtrlSetOnEvent(-1, "chkAccountsProperties")
		$y += 30
			$chkCanUse[7] = GUICtrlCreateCheckbox(GetTranslated(108,11, "Use Account 7 with Profile :"), $x, $y, 150, 17)
				GUICtrlSetOnEvent(-1, "chkAccountsProperties")
			$cmbAccount[7] = GUICtrlCreateCombo("", $z, $y - 2, 145, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
			$chkDonateAccount[7] = GUICtrlCreateCheckbox(GetTranslated(108,5, "Donate only"), $w, $y, 75, 17)
				GUICtrlSetOnEvent(-1, "chkAccountsProperties")
		$y += 30
			$chkCanUse[8] = GUICtrlCreateCheckbox(GetTranslated(108,12, "Use Account 8 with Profile :"), $x, $y, 150, 17)
				GUICtrlSetOnEvent(-1, "chkAccountsProperties")
			$cmbAccount[8] = GUICtrlCreateCombo("", $z, $y - 2, 145, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
			$chkDonateAccount[8] = GUICtrlCreateCheckbox(GetTranslated(108,5, "Donate only"), $w, $y, 75, 17)
				GUICtrlSetOnEvent(-1, "chkAccountsProperties")
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$g_EndHideSwitchAcc_DocOc = GUICtrlCreateDummy()	; Hide DocOc SwitchAcc to make room for SwitchAcc-Demen-Style

	setupProfileComboBox()
	PopulatePresetComboBox()

	CreateSwitchAcc_Demen(); SwitchAcc_Demen_Style

EndFunc
#EndRegion

#Region Profiles Subtab
Func CreateModSwitchProfile()

	Local $sTxtTip = ""
	Local $x = 25, $y = 45

	GUICtrlCreateGroup(GetTranslated(655,1, "Gold Switch Profile Conditions"), $x - 20, $y - 20, 430, 75) ;Gold Switch
		$g_hChkGoldSwitchMax = GUICtrlCreateCheckbox(GetTranslated(655,2, "Switch To"), $x - 10, $y - 5, -1, -1)
			$sTxtTip = GetTranslated(655,3, "Enable this to switch profiles when gold is above amount.")
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_hCmbGoldMaxProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$sTxtTip = GetTranslated(655,5, "Select which profile to be switched to when conditions met")
			_GUICtrlSetTip(-1, $sTxtTip)
		GUICtrlCreateLabel(GetTranslated(655,7, "When Gold is Above"), $x + 145, $y, -1, -1)
		$g_hTxtMaxGoldAmount = GUICtrlCreateInput("6000000", $x + 275, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$sTxtTip = GetTranslated(655,6, "Set the amount of Gold to trigger switching Profile.")
			_GUICtrlSetTip(-1, $sTxtTip)
			GUICtrlSetLimit(-1, 7)

	$y += 30
		$g_hChkGoldSwitchMin = GUICtrlCreateCheckbox(GetTranslated(655,2, "Switch To"), $x - 10, $y - 5, -1, -1)
			$sTxtTip = GetTranslated(655,4, "Enable this to switch profiles when gold is below amount.")
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_hCmbGoldMinProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$sTxtTip = GetTranslated(655,5, "Select which profile to be switched to when conditions met")
			_GUICtrlSetTip(-1, $sTxtTip)
		GUICtrlCreateLabel(GetTranslated(655,8, "When Gold is Below"), $x + 145, $y, -1, -1)
		$g_hTxtMinGoldAmount = GUICtrlCreateInput("500000", $x + 275, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$sTxtTip = GetTranslated(655,6, "Set the amount of Gold to trigger switching Profile.")
			_GUICtrlSetTip(-1, $sTxtTip)
			GUICtrlSetLimit(-1, 7)
		GUICtrlCreatePic(@ScriptDir & "\Images\GoldStorage.jpg", $x + 340, $y - 40, 60, 60)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$y += 48
	GUICtrlCreateGroup(GetTranslated(655,9, "Elixir Switch Profile Conditions"), $x - 20, $y - 20, 430, 75) ; Elixir Switch
		$g_hChkElixirSwitchMax = GUICtrlCreateCheckbox(GetTranslated(655,2, "Switch To"), $x - 10, $y - 5, -1, -1)
			$sTxtTip = GetTranslated(655,10, "Enable this to switch profiles when Elixir is above amount.")
			_GUICtrlSetTip(-1, $sTxtTip)

		$g_hCmbElixirMaxProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$sTxtTip = GetTranslated(655,5, "Select which profile to be switched to when conditions met")
			_GUICtrlSetTip(-1, $sTxtTip)
		GUICtrlCreateLabel(GetTranslated(655,13, "When Elixir is Above"), $x + 145, $y, -1, -1)
		$g_hTxtMaxElixirAmount = GUICtrlCreateInput("6000000", $x + 275, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$sTxtTip = GetTranslated(655,12, "Set the amount of Elixir to trigger switching Profile.")
			_GUICtrlSetTip(-1, $sTxtTip)
			GUICtrlSetLimit(-1, 7)
	$y += 30
		$g_hChkElixirSwitchMin = GUICtrlCreateCheckbox(GetTranslated(655,2, "Switch To"), $x - 10, $y - 5, -1, -1)
			$sTxtTip = GetTranslated(655,11, "Enable this to switch profiles when Elixir is below amount.")
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_hCmbElixirMinProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$sTxtTip = GetTranslated(655,5, "Select which profile to be switched to when conditions met")
			_GUICtrlSetTip(-1, $sTxtTip)
		GUICtrlCreateLabel(GetTranslated(655,14, "When Elixir is Below"), $x + 145, $y, -1, -1)
		$g_hTxtMinElixirAmount = GUICtrlCreateInput("500000", $x + 275, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$sTxtTip = GetTranslated(655,12, "Set the amount of Elixir to trigger switching Profile.")
			_GUICtrlSetTip(-1, $sTxtTip)
			GUICtrlSetLimit(-1, 7)
		GUICtrlCreatePic(@ScriptDir & "\Images\ElixirStorage.jpg", $x + 340, $y - 40, 60, 60)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$y += 48
	GUICtrlCreateGroup(GetTranslated(655,15, "Dark Elixir Switch Profile Conditions"), $x - 20, $y - 20, 430, 75) ;DE Switch
		$g_hChkDESwitchMax = GUICtrlCreateCheckbox(GetTranslated(655,2, "Switch To"), $x - 10, $y - 5, -1, -1)
			$sTxtTip = GetTranslated(655,16, "Enable this to switch profiles when Dark Elixir is above amount.")
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_hCmbDEMaxProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$sTxtTip = GetTranslated(655,5, "Select which profile to be switched to when conditions met")
			_GUICtrlSetTip(-1, $sTxtTip)
		GUICtrlCreateLabel(GetTranslated(655,19, "When Dark Elixir is Above"), $x + 145, $y, -1, -1)
		$g_hTxtMaxDEAmount = GUICtrlCreateInput("200000", $x + 275, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$sTxtTip = GetTranslated(655,18, "Set the amount of Dark Elixir to trigger switching Profile.")
			_GUICtrlSetTip(-1, $sTxtTip)
			GUICtrlSetLimit(-1, 6)
	$y += 30
		$g_hChkDESwitchMin = GUICtrlCreateCheckbox(GetTranslated(655,2, "Switch To"), $x - 10, $y - 5, -1, -1)
			$sTxtTip = GetTranslated(655,17, "Enable this to switch profiles when Dark Elixir is below amount.")
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_hCmbDEMinProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$sTxtTip = GetTranslated(655,5, "Select which profile to be switched to when conditions met")
			_GUICtrlSetTip(-1, $sTxtTip)
		GUICtrlCreateLabel(GetTranslated(655,20, "When Dark Elixir is Below"), $x + 145, $y, -1, -1)
		$g_hTxtMinDEAmount = GUICtrlCreateInput("10000", $x + 275, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$sTxtTip = GetTranslated(655,18, "Set the amount of Dark Elixir to trigger switching Profile.")
			_GUICtrlSetTip(-1, $sTxtTip)
			GUICtrlSetLimit(-1, 6)
		GUICtrlCreatePic(@ScriptDir & "\Images\DEStorage.jpg", $x + 340, $y - 40, 60, 60)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$y += 48
	GUICtrlCreateGroup(GetTranslated(655,21, "Trophy Switch Profile Conditions"), $x - 20, $y - 20, 430, 75) ; Trophy Switch
		$g_hChkTrophySwitchMax = GUICtrlCreateCheckbox(GetTranslated(655,2, "Switch To"), $x - 10, $y - 5, -1, -1)
			$sTxtTip = GetTranslated(655,22, "Enable this to switch profiles when Trophies are above amount.")
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_hCmbTrophyMaxProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$sTxtTip = GetTranslated(655,5, "Select which profile to be switched to when conditions met")
			_GUICtrlSetTip(-1, $sTxtTip)
		GUICtrlCreateLabel(GetTranslated(655,25, "When Trophies are Above"), $x + 145, $y, -1, -1)
		$g_hTxtMaxTrophyAmount = GUICtrlCreateInput("3000", $x + 275, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$sTxtTip = GetTranslated(655,24, "Set the amount of Trophies to trigger switching Profile.")
			_GUICtrlSetTip(-1, $sTxtTip)
			GUICtrlSetLimit(-1, 4)
	$y += 30
		$g_hChkTrophySwitchMin = GUICtrlCreateCheckbox(GetTranslated(655,2, "Switch To"), $x - 10, $y - 5, -1, -1)
			$sTxtTip = GetTranslated(655,23, "Enable this to switch profiles when Trophies are below amount.")
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_hCmbTrophyMinProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$sTxtTip = GetTranslated(655,5, "Select which profile to be switched to when conditions met")
			_GUICtrlSetTip(-1, $sTxtTip)
		GUICtrlCreateLabel(GetTranslated(655,26, "When Trophies are Below"), $x + 145, $y, -1, -1)
		$g_hTxtMinTrophyAmount = GUICtrlCreateInput("1000", $x + 275, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$sTxtTip = GetTranslated(655,24, "Set the amount of Trophies to trigger switching Profile.")
			_GUICtrlSetTip(-1, $sTxtTip)
			GUICtrlSetLimit(-1, 4)
		GUICtrlCreatePic(@ScriptDir & "\Images\TrophyLeague.jpg", $x + 340, $y - 40, 60, 60)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
		setupProfileComboBoxswitch()
EndFunc
#EndRegion
