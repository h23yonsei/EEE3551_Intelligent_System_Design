# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "SRAM_CONV_WEIGHT_ADR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "SRAM_CONV_WEIGHT_AMAX" -parent ${Page_0}
  ipgui::add_param $IPINST -name "SRAM_CONV_WEIGHT_BW" -parent ${Page_0}
  ipgui::add_param $IPINST -name "SRAM_FCL_WEIGHT_ADR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "SRAM_FCL_WEIGHT_AMAX" -parent ${Page_0}
  ipgui::add_param $IPINST -name "SRAM_FCL_WEIGHT_BW" -parent ${Page_0}
  ipgui::add_param $IPINST -name "SRAM_INPUT_ADR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "SRAM_INPUT_AMAX" -parent ${Page_0}
  ipgui::add_param $IPINST -name "SRAM_INPUT_BW" -parent ${Page_0}


}

proc update_PARAM_VALUE.SRAM_CONV_WEIGHT_ADR { PARAM_VALUE.SRAM_CONV_WEIGHT_ADR } {
	# Procedure called to update SRAM_CONV_WEIGHT_ADR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SRAM_CONV_WEIGHT_ADR { PARAM_VALUE.SRAM_CONV_WEIGHT_ADR } {
	# Procedure called to validate SRAM_CONV_WEIGHT_ADR
	return true
}

proc update_PARAM_VALUE.SRAM_CONV_WEIGHT_AMAX { PARAM_VALUE.SRAM_CONV_WEIGHT_AMAX } {
	# Procedure called to update SRAM_CONV_WEIGHT_AMAX when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SRAM_CONV_WEIGHT_AMAX { PARAM_VALUE.SRAM_CONV_WEIGHT_AMAX } {
	# Procedure called to validate SRAM_CONV_WEIGHT_AMAX
	return true
}

proc update_PARAM_VALUE.SRAM_CONV_WEIGHT_BW { PARAM_VALUE.SRAM_CONV_WEIGHT_BW } {
	# Procedure called to update SRAM_CONV_WEIGHT_BW when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SRAM_CONV_WEIGHT_BW { PARAM_VALUE.SRAM_CONV_WEIGHT_BW } {
	# Procedure called to validate SRAM_CONV_WEIGHT_BW
	return true
}

proc update_PARAM_VALUE.SRAM_FCL_WEIGHT_ADR { PARAM_VALUE.SRAM_FCL_WEIGHT_ADR } {
	# Procedure called to update SRAM_FCL_WEIGHT_ADR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SRAM_FCL_WEIGHT_ADR { PARAM_VALUE.SRAM_FCL_WEIGHT_ADR } {
	# Procedure called to validate SRAM_FCL_WEIGHT_ADR
	return true
}

proc update_PARAM_VALUE.SRAM_FCL_WEIGHT_AMAX { PARAM_VALUE.SRAM_FCL_WEIGHT_AMAX } {
	# Procedure called to update SRAM_FCL_WEIGHT_AMAX when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SRAM_FCL_WEIGHT_AMAX { PARAM_VALUE.SRAM_FCL_WEIGHT_AMAX } {
	# Procedure called to validate SRAM_FCL_WEIGHT_AMAX
	return true
}

proc update_PARAM_VALUE.SRAM_FCL_WEIGHT_BW { PARAM_VALUE.SRAM_FCL_WEIGHT_BW } {
	# Procedure called to update SRAM_FCL_WEIGHT_BW when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SRAM_FCL_WEIGHT_BW { PARAM_VALUE.SRAM_FCL_WEIGHT_BW } {
	# Procedure called to validate SRAM_FCL_WEIGHT_BW
	return true
}

proc update_PARAM_VALUE.SRAM_INPUT_ADR { PARAM_VALUE.SRAM_INPUT_ADR } {
	# Procedure called to update SRAM_INPUT_ADR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SRAM_INPUT_ADR { PARAM_VALUE.SRAM_INPUT_ADR } {
	# Procedure called to validate SRAM_INPUT_ADR
	return true
}

proc update_PARAM_VALUE.SRAM_INPUT_AMAX { PARAM_VALUE.SRAM_INPUT_AMAX } {
	# Procedure called to update SRAM_INPUT_AMAX when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SRAM_INPUT_AMAX { PARAM_VALUE.SRAM_INPUT_AMAX } {
	# Procedure called to validate SRAM_INPUT_AMAX
	return true
}

proc update_PARAM_VALUE.SRAM_INPUT_BW { PARAM_VALUE.SRAM_INPUT_BW } {
	# Procedure called to update SRAM_INPUT_BW when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SRAM_INPUT_BW { PARAM_VALUE.SRAM_INPUT_BW } {
	# Procedure called to validate SRAM_INPUT_BW
	return true
}


proc update_MODELPARAM_VALUE.SRAM_INPUT_BW { MODELPARAM_VALUE.SRAM_INPUT_BW PARAM_VALUE.SRAM_INPUT_BW } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SRAM_INPUT_BW}] ${MODELPARAM_VALUE.SRAM_INPUT_BW}
}

proc update_MODELPARAM_VALUE.SRAM_INPUT_AMAX { MODELPARAM_VALUE.SRAM_INPUT_AMAX PARAM_VALUE.SRAM_INPUT_AMAX } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SRAM_INPUT_AMAX}] ${MODELPARAM_VALUE.SRAM_INPUT_AMAX}
}

proc update_MODELPARAM_VALUE.SRAM_INPUT_ADR { MODELPARAM_VALUE.SRAM_INPUT_ADR PARAM_VALUE.SRAM_INPUT_ADR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SRAM_INPUT_ADR}] ${MODELPARAM_VALUE.SRAM_INPUT_ADR}
}

proc update_MODELPARAM_VALUE.SRAM_CONV_WEIGHT_BW { MODELPARAM_VALUE.SRAM_CONV_WEIGHT_BW PARAM_VALUE.SRAM_CONV_WEIGHT_BW } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SRAM_CONV_WEIGHT_BW}] ${MODELPARAM_VALUE.SRAM_CONV_WEIGHT_BW}
}

proc update_MODELPARAM_VALUE.SRAM_CONV_WEIGHT_AMAX { MODELPARAM_VALUE.SRAM_CONV_WEIGHT_AMAX PARAM_VALUE.SRAM_CONV_WEIGHT_AMAX } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SRAM_CONV_WEIGHT_AMAX}] ${MODELPARAM_VALUE.SRAM_CONV_WEIGHT_AMAX}
}

proc update_MODELPARAM_VALUE.SRAM_CONV_WEIGHT_ADR { MODELPARAM_VALUE.SRAM_CONV_WEIGHT_ADR PARAM_VALUE.SRAM_CONV_WEIGHT_ADR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SRAM_CONV_WEIGHT_ADR}] ${MODELPARAM_VALUE.SRAM_CONV_WEIGHT_ADR}
}

proc update_MODELPARAM_VALUE.SRAM_FCL_WEIGHT_BW { MODELPARAM_VALUE.SRAM_FCL_WEIGHT_BW PARAM_VALUE.SRAM_FCL_WEIGHT_BW } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SRAM_FCL_WEIGHT_BW}] ${MODELPARAM_VALUE.SRAM_FCL_WEIGHT_BW}
}

proc update_MODELPARAM_VALUE.SRAM_FCL_WEIGHT_AMAX { MODELPARAM_VALUE.SRAM_FCL_WEIGHT_AMAX PARAM_VALUE.SRAM_FCL_WEIGHT_AMAX } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SRAM_FCL_WEIGHT_AMAX}] ${MODELPARAM_VALUE.SRAM_FCL_WEIGHT_AMAX}
}

proc update_MODELPARAM_VALUE.SRAM_FCL_WEIGHT_ADR { MODELPARAM_VALUE.SRAM_FCL_WEIGHT_ADR PARAM_VALUE.SRAM_FCL_WEIGHT_ADR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SRAM_FCL_WEIGHT_ADR}] ${MODELPARAM_VALUE.SRAM_FCL_WEIGHT_ADR}
}

