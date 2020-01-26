# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "C_PWM_FREQ" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_SYS_FREQ" -parent ${Page_0}


}

proc update_PARAM_VALUE.C_PWM_FREQ { PARAM_VALUE.C_PWM_FREQ } {
	# Procedure called to update C_PWM_FREQ when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_PWM_FREQ { PARAM_VALUE.C_PWM_FREQ } {
	# Procedure called to validate C_PWM_FREQ
	return true
}

proc update_PARAM_VALUE.C_SYS_FREQ { PARAM_VALUE.C_SYS_FREQ } {
	# Procedure called to update C_SYS_FREQ when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_SYS_FREQ { PARAM_VALUE.C_SYS_FREQ } {
	# Procedure called to validate C_SYS_FREQ
	return true
}


proc update_MODELPARAM_VALUE.C_SYS_FREQ { MODELPARAM_VALUE.C_SYS_FREQ PARAM_VALUE.C_SYS_FREQ } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_SYS_FREQ}] ${MODELPARAM_VALUE.C_SYS_FREQ}
}

proc update_MODELPARAM_VALUE.C_PWM_FREQ { MODELPARAM_VALUE.C_PWM_FREQ PARAM_VALUE.C_PWM_FREQ } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_PWM_FREQ}] ${MODELPARAM_VALUE.C_PWM_FREQ}
}

