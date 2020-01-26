# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "C_IN_TYPE" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "C_HORISONTAL_RES" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_VERTICAL_RES" -parent ${Page_0}


}

proc update_PARAM_VALUE.C_HORISONTAL_RES { PARAM_VALUE.C_HORISONTAL_RES } {
	# Procedure called to update C_HORISONTAL_RES when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_HORISONTAL_RES { PARAM_VALUE.C_HORISONTAL_RES } {
	# Procedure called to validate C_HORISONTAL_RES
	return true
}

proc update_PARAM_VALUE.C_IN_TYPE { PARAM_VALUE.C_IN_TYPE } {
	# Procedure called to update C_IN_TYPE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_IN_TYPE { PARAM_VALUE.C_IN_TYPE } {
	# Procedure called to validate C_IN_TYPE
	return true
}

proc update_PARAM_VALUE.C_VERTICAL_RES { PARAM_VALUE.C_VERTICAL_RES } {
	# Procedure called to update C_VERTICAL_RES when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_VERTICAL_RES { PARAM_VALUE.C_VERTICAL_RES } {
	# Procedure called to validate C_VERTICAL_RES
	return true
}


proc update_MODELPARAM_VALUE.C_HORISONTAL_RES { MODELPARAM_VALUE.C_HORISONTAL_RES PARAM_VALUE.C_HORISONTAL_RES } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_HORISONTAL_RES}] ${MODELPARAM_VALUE.C_HORISONTAL_RES}
}

proc update_MODELPARAM_VALUE.C_VERTICAL_RES { MODELPARAM_VALUE.C_VERTICAL_RES PARAM_VALUE.C_VERTICAL_RES } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_VERTICAL_RES}] ${MODELPARAM_VALUE.C_VERTICAL_RES}
}

proc update_MODELPARAM_VALUE.C_IN_TYPE { MODELPARAM_VALUE.C_IN_TYPE PARAM_VALUE.C_IN_TYPE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_IN_TYPE}] ${MODELPARAM_VALUE.C_IN_TYPE}
}

