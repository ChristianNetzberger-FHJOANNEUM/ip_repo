lappend ::auto_path "$::env(HDS_HOME)/resources/tcl/tcllib1.4"
set ::hdsDebug 0
proc ::hdsDebugPuts {msg} {
   if {$::hdsDebug} {
      puts $msg
   }
}

set normVars {HDS_PROJECT_DIR HDS_TEAM_HOME HDS_HOME XILINX_VIVADO}
foreach varName $normVars {
   if {[info exists ::env($varName)]} {
      set ::env($varName) [file normalize [subst -nobackslash {$::env($varName)}]]
   }
}

puts "## HDS #Running Vivado Project Creation/Update#"
set ::errorCount 0
if {[catch {source ./HDS_Scripts/circuit_ch1_1a_Create.tcl} errMsg]} {
   if {[regexp "(?q)$errMsg" $errorInfo]} {
      puts "Error: $errorInfo"
   } else {
      puts "Error: $errMsg"
   }
   return
}
if {$::errorCount == 0} {
   puts "Note: \"source ./HDS_Scripts/circuit_ch1_1a_Create.tcl\" completed successfully\n"
} else {
   puts "Error: \"source ./HDS_Scripts/circuit_ch1_1a_Create.tcl\" completed with errors\n"
}


