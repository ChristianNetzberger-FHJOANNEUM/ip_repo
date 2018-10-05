package require fileutil
set ::errorCount 0

proc ::hdsFindCommonRootDir {fileList} {
   if {[llength $fileList] <= 1} {
      return ""
   }
   set splits [file split [lindex $fileList 0]]
   for {set i 1} {$i < [llength $fileList]} {incr i} {
      set out {}
      foreach one $splits two [file split [lindex $fileList $i]] {
         if {$one != $two} break
         lappend out $one
      }
      set splits $out
    }
    if {[llength $splits] <= 1} {
       return ""
    }
    return [eval file join $splits]
}

catch {close_project}
set xilinxProject "./circuit_ch1_1a.xpr"
set library training_lib
set unit circuit_ch1_1a
set view rtl
set removeIP 0
set removeHDL 0
set forceRecreate 0
set cuAdd 1
set cuPoint 1
set cuUseIP 1
set cuCopyIP 0
set cuFileMapOption 0
set cuCopyIPDest 0
set cuCopyIPDestPath ""
set cuCopyIPDestPathForceRemoving 1
set metaDataList ".svn CVS"
set vivadoCoresExtList "xci xco dcp xmp mdl slx bd edk"
set VerilogIncludeSearchPath ""
set VerilogDefines ""

if {[file exists $xilinxProject]} {
   if {$forceRecreate} {
      puts "Warning: Creating project $xilinxProject using -force option"
      create_project -force -verbose $xilinxProject
   } else {
      puts "Opening project $xilinxProject"
      open_project -verbose $xilinxProject
   }
} else {
   puts "Creating project $xilinxProject"
   create_project -verbose $xilinxProject
}
::hdsDebugPuts "Current filesets : [get_filesets]"
set xilDefaultLibName [get_property DEFAULT_LIB [current_project]]
::hdsDebugPuts "Xilinx Default Library: $xilDefaultLibName"
if {[info exists ::env(HDS_VIVADO_IPDESTPATH_REMOVE_DISABLE)] && $::env(HDS_VIVADO_IPDESTPATH_REMOVE_DISABLE) == "1"} {
   set cuCopyIPDestPathForceRemoving 0
}
if {[info exists ::env(HDS_VIVADO_DESIGN_MODE)]} {
   ::hdsDebugPuts "set_property design_mode \"$::env(HDS_VIVADO_DESIGN_MODE)\" \[current_fileset\]"
   set_property design_mode $::env(HDS_VIVADO_DESIGN_MODE) [current_fileset]
}
::hdsDebugPuts "set_property part xc7z010clg400-1 [current_project]"
set_property part xc7z010clg400-1 [current_project]
::hdsDebugPuts "set_property target_language VHDL [current_project]"
set_property target_language VHDL [current_project]

if {$VerilogIncludeSearchPath != ""} {
   set vlogIncList [list]
   foreach one $VerilogIncludeSearchPath {
      lappend vlogIncList [eval file normalize $one]
   }
   ::hdsDebugPuts "\$vlogIncList = $vlogIncList"
   ::hdsDebugPuts "set_property include_dirs \$vlogIncList \[current_fileset\]"
   set_property include_dirs $vlogIncList [current_fileset]
}
if {$VerilogDefines != ""} {
   ::hdsDebugPuts "\$VerilogDefines = $VerilogDefines"
   ::hdsDebugPuts "set_property verilog_define \$VerilogDefines \[current_fileset\]"
   set_property verilog_define $VerilogDefines [current_fileset]
}

puts "Project HDL files to add stored in:"
puts "   ./HDS_Scripts/circuit_ch1_1a_fileList.tcl"
set hdlFileList ./HDS_Scripts/circuit_ch1_1a_fileList.tcl

set ipFiles [list]
set coreIpFiles [list]
set nonIpFiles [list]
set coresExtPatt [join $vivadoCoresExtList "|"]
foreach one [get_files -all -quiet] {
   if {[string length [get_property -quiet PARENT_COMPOSITE_FILE $one]]} {
      lappend ipFiles $one
   } elseif {[regexp "\.($coresExtPatt)$" $one]} {
      lappend coreIpFiles $one
   } else {
      lappend nonIpFiles $one
   }
}
::hdsDebugPuts "All non-IP HDL files \$nonIpFiles:\n[join $nonIpFiles \n]"
::hdsDebugPuts "All IP HDL files \$ipFiles:\n[join $ipFiles \n]"
::hdsDebugPuts "All IP Cores files \$coreIpFiles:\n[join $coreIpFiles \n]"
if {$removeHDL} {
   puts "Note: removing all non-IP HDL files..."
   if {[llength $nonIpFiles]} {
      ::hdsDebugPuts "remove_files $nonIpFiles"
      remove_files $nonIpFiles
   } else {
      puts "Note: The project doesn't have any non-IP HDL files to remove."
   }
}
if {$removeIP} {
   puts "Note: removing IP files..."
   if {[llength $coreIpFiles]} {
      ::hdsDebugPuts "remove_files $coreIpFiles"
      remove_files $coreIpFiles
      ::hdsDebugPuts "remove_files -quiet \$ipFiles"
      remove_files -quiet $ipFiles
   } else {
      puts "Note: The project doesn't have any IPs to remove."
   }
}
catch {unset hdsFileList}
catch {unset ipFileList}
catch {unset vlogGlobalFileList}
::hdsDebugPuts "source $hdlFileList"
source $hdlFileList
if {$cuAdd} {
   if {![info exists hdsFileList] || [llength $hdsFileList] == 0} {
      puts "Warning: No HDL files exists in $hdlFileList to add in project"
   } else {
      set paths [list]
      foreach {lib path} $hdsFileList {
         lappend paths $path
         ::hdsDebugPuts "remove_files -quiet \[get_files -all -quiet \[file tail $path\]\]"
         remove_files -quiet [get_files -all -quiet [file tail $path]]
      }
      set longestCommonDir ""
      if {!$cuPoint} {
         set longestCommonDir [::hdsFindCommonRootDir $paths]
      }
      set hdsNewFileList [list]
      foreach {lib path} $hdsFileList {
         if {$cuPoint} {
            ::hdsDebugPuts "add_files {$path}"
            add_files [list $path]
            lappend hdsNewFileList $lib
            lappend hdsNewFileList $path
         } else {
            if {[string length $longestCommonDir]} {
               ::hdsDebugPuts "import_files -force {$path} -relative_to {$longestCommonDir}"
               set newPath [import_files -force [list $path] -relative_to [list $longestCommonDir]]
            } else {
               ::hdsDebugPuts "import_files -force {$path}"
               set newPath [import_files -force [list $path]]
            }
            lappend hdsNewFileList $lib
            lappend hdsNewFileList $newPath
            set vlogGlobalFileIdx [lsearch $vlogGlobalFileList $path]
            if {$vlogGlobalFileIdx >= 0} {
               lset vlogGlobalFileList $vlogGlobalFileIdx $newPath
            }
         }
      }
      foreach {lib path} $hdsNewFileList {
         foreach one [get_files -all -quiet [list $path]] {
            ::hdsDebugPuts "set_property LIBRARY $lib \[lindex \[get_files -all -quiet {$one}\] 0\]"
            set_property LIBRARY $lib [lindex [get_files -all -quiet [list $one]] 0]
            if {[lsearch $vlogGlobalFileList $path] >= 0} {
               ::hdsDebugPuts "set_property is_global_include true \[lindex \[get_files -all -quiet {$one}\] 0\]"
               set_property is_global_include true [lindex [get_files -all -quiet [list $one]] 0]
            }
         }
      }
      ::hdsDebugPuts "set_property top $unit \[current_fileset\]"
      set_property top $unit [current_fileset]
      ::hdsDebugPuts "set_property top_lib $library \[current_fileset\]"
      set_property top_lib $library [current_fileset]
      if {$view != ""} {
         ::hdsDebugPuts "set_property top_arch $view \[current_fileset\]"
         set_property top_arch $view [current_fileset]
      }
      ::hdsDebugPuts "set_property top_file {$path} \[current_fileset\]"
      set_property top_file [list $path] [current_fileset]
      if {[info exists ::env(HDS_VIVADO_CREATE_HIERARCHY_OPTION)] && $::env(HDS_VIVADO_CREATE_HIERARCHY_OPTION) == "2"} {
         # Do Nothing
      } elseif {[info exists ::env(HDS_VIVADO_CREATE_HIERARCHY_OPTION)] && $::env(HDS_VIVADO_CREATE_HIERARCHY_OPTION) == "1"} {
         # Manual Source Management Mode
         set_property source_mgmt_mode None [current_project]
      } else {
         # Default
         ::hdsDebugPuts "update_compile_order -fileset \[current_fileset\]"
         update_compile_order -fileset [current_fileset]
      }
   }
}
if {!$cuUseIP} {
   if {![info exists ipFileList] || [llength $ipFileList] == 0} {
      puts "Warning: No IP files exists in $hdlFileList to add in project"
   } else {
      foreach {lib path ipFileScript} $ipFileList {
         set ipName [file tail $path]
         set coreName [file rootname $ipName]
         set path [file normalize $path]
         if {![file exists $path]} {
            puts "Error: IP File $path doesn't exists, skipping $coreName..."
            incr ::errorCount
            continue
         }
         ::hdsDebugPuts "catch {source $ipFileScript}"
         catch {source $ipFileScript}
         set ipDestDir ""
         if {$cuCopyIPDest} {
            if {[string length $cuCopyIPDestPath]} {
               set ipDestDir [file normalize $cuCopyIPDestPath]
            } else {
               puts "Warning: custom IP destination directory is not specified setting to [pwd]/../hds_ip"
               set ipDestDir [file normalize "[pwd]/../hds_ip"]
            }
            if {[catch {file mkdir $ipDestDir} errMsg]} {
               puts "Error: $errMsg"
               incr ::errorCount
               return
            }
         }
         if {$cuCopyIP} {
            if {[lsearch -regexp [array names cores] ",ipDir"] < 0 || [lsearch -regexp [array names cores] ",ipName"] < 0 || [lsearch -regexp [array names cores] ",fileList"] < 0 || [lsearch -regexp [array names cores] ",IP"] < 0} {
               set coreDir [file dirname $path]
               puts "Warning: IP file list is not used, processing $coreDir"
               set ipName [file tail $path]
               if {[string length $ipDestDir]} {
                  set origCoreDirName [file tail $coreDir]
                  set doCopy 1
                  if {$cuCopyIPDestPathForceRemoving} {
                     set ipDestDir [file join $ipDestDir $origCoreDirName]
                     if {$ipDestDir == $coreDir} {
                        # Special case need to import to the same location (Side Data)
                        set doCopy 0
                     } else {
                        catch {file delete -force $ipDestDir}
                     }
                  } else {
                     set i 0
                     set coreDirName $origCoreDirName
                     while {[file exists [file join $ipDestDir $coreDirName]]} {
                        set coreDirName ${origCoreDirName}_$i
                        incr i
                     }
                     set ipDestDir [file join $ipDestDir $coreDirName]
                  }
                  if {$doCopy} {
                     if {[catch {file mkdir [file dirname $ipDestDir]} errMsg]} {
                        puts "Error: $errMsg"
                        incr ::errorCount
                        continue
                     }
                     if {[catch {file copy -force $coreDir [file dirname $ipDestDir]} errMsg]} {
                        puts "Error: $errMsg"
                        incr ::errorCount
                        continue
                     }
                     set allCopiedFiles [::fileutil::findByPattern $ipDestDir *]
                     lappend allCopiedFiles $ipDestDir
                     if {[info exists ::env(HDS_VIVADO_IP_MAKE_WRITABLE_ON_CREATE_UPDATE)] && $::env(HDS_VIVADO_IP_MAKE_WRITABLE_ON_CREATE_UPDATE) == "1"} {
                        foreach copiedFile [lsort -unique $allCopiedFiles] {
                           if {[string equal $::tcl_platform(platform) windows]} {
                              catch {file attributes $copiedFile -readonly 0}
                           } else {
                              catch {file attributes $copiedFile -permissions 00774}
                           }
                        }
                     }
                     set metaDataFiles [lsort -unique [::fileutil::findByPattern $ipDestDir $metaDataList]]
                     foreach metaDataFile $metaDataFiles {
                        catch {file delete -force $metaDataFile}
                     }
                  }
                  set path [file join $ipDestDir $ipName]
                  foreach ext $vivadoCoresExtList {
                     ::hdsDebugPuts "remove_files -quiet \[get_files -all -quiet ${coreName}.${ext}\]"
                     remove_files -quiet [get_files -all -quiet ${coreName}.${ext}]
                  }
                  ::hdsDebugPuts "add_files $path"
                  add_files $path
               } else {                  
                  foreach ext $vivadoCoresExtList {
                     ::hdsDebugPuts "remove_files -quiet \[get_files -all -quiet ${coreName}.${ext}\]"
                     remove_files -quiet [get_files -all -quiet ${coreName}.${ext}]
                  }
                  if {[regexp {\.(xco|xci)$} [file extension $path]]} {
                     ::hdsDebugPuts "import_ip $path"
                     import_ip $path
                  } else {
                     ::hdsDebugPuts "import_files -flat -force $path"
                     import_files -flat -force $path
                  }
               }
               continue
            }
            # Else Add using IP file list
            puts "Note: Using IP file list file \"$ipFileScript\" to add the IP $coreName to project"
            set coreIp [lsearch -regexp -inline [array names cores] ",ipName"]
            # It doesn't matter .dcp or .xci use .xci to import the whole dir
            set ipName $cores($coreIp)
            set coreName [file rootname $ipName]
            set coreDir [file dirname $path]
            if {![file isdirectory $coreDir]} {
               puts "Error: Unable to add IP $ipName to project"
               puts "Error: The IP directory $coreDir doesn't exist"
               incr ::errorCount
               continue
            }
            puts "Note: processing the entire IP directory $coreDir"
            set doCopy 1
            set sepcifiedLocation 0
            if {[string length $ipDestDir]} {
               # Custom Directory
               set sepcifiedLocation 1
               set origCoreDirName [file tail $cores($ipName,ipDir)]
               if {$cuCopyIPDestPathForceRemoving} {
                  set ipDestDir [file join $ipDestDir $origCoreDirName]
                  if {$ipDestDir == $coreDir} {
                     # Special case need to import to the same location (Side Data)
                     set doCopy 0
                  } else {
                     catch {file delete -force $ipDestDir}
                  }
               } else {
                  set i 0
                  set coreDirName $origCoreDirName
                  while {[file exists [file join $ipDestDir $coreDirName]]} {
                     set coreDirName ${origCoreDirName}_$i
                     incr i
                  }
                  set ipDestDir [file join $ipDestDir $coreDirName]
               }
            } else {
               # Original Location
               set ipDestDir [file normalize $cores($ipName,ipDir)]
               if {[lsearch -regexp [array names cores] ",ipImportProject"] >= 0} {
                  set ipImportProject $cores($ipName,ipImportProject)
                  set currentProjectName [file rootname [file tail [current_project]]]
                  if {$ipImportProject != $currentProjectName} {
                     puts "Warning: The IP $ipName, was not originally created in current project \"$currentProjectName\", will modify the destination directory specified in the file list to conform with project \"$currentProjectName\" directory structure"
                     regsub -all "\/$ipImportProject\.srcs\/" $ipDestDir "/$currentProjectName.srcs/" ipDestDir
                  }
               }
               if {$ipDestDir == $coreDir} {
                  # Special case need to import to the same location (Side Data)
                  set doCopy 0
               } else {
                  # Delete this directory so we won't get mixed files
                  catch {file delete -force $ipDestDir}
               }
            }
            if {$doCopy} {
               set ipDir [file normalize $cores($ipName,ipDir)]
               set errorOccured 0
               set fileMapSourced 0
               set othersDir [file join [file dirname $coreDir] others]
               set fileMapFile [file join $othersDir ${coreName}_fileMap.tcl]
               set srcsList [list]
               set destsList [list]
               if {[file exists $fileMapFile]} {
                  ::hdsDebugPuts "catch {source $fileMapFile}"
                  if {![catch {source $fileMapFile}] && [info exists fileMapList]} {
                     ::hdsDebugPuts "$fileMapFile sourced"
                     set fileMapSourced 1
                     foreach {srcPath destPath} $fileMapList {
                        lappend srcsList $srcPath
                        lappend destsList [file normalize $destPath]
                     }
                  }
               }
               # By default copy the entire directory to the destination one unless the environmental vairable HDS_VIVADO_CREATE_COPY_FILELIST_ONLY=1
               set originalCopyDirectory 1
               if {[info exists ::env(HDS_VIVADO_CREATE_COPY_FILELIST_ONLY)] && $::env(HDS_VIVADO_CREATE_COPY_FILELIST_ONLY) == "1"} {
                  set originalCopyDirectory 0
               }
               if {$originalCopyDirectory} {
                  if {[catch {file mkdir [file dirname $ipDestDir]} errMsg]} {
                     puts "Error: $errMsg"
                     incr ::errorCount
                     continue
                  }
                  if {[catch {file copy -force $coreDir [file dirname $ipDestDir]} errMsg]} {
                     puts "Error: $errMsg"
                     incr ::errorCount
                     continue
                  }
                  set metaDataFiles [lsort -unique [::fileutil::findByPattern $ipDestDir $metaDataList]]
                  foreach metaDataFile $metaDataFiles {
                     catch {file delete -force $metaDataFile}
                  }
               }
               # core fileList doesn't have the configuration file add it here
               lappend cores($ipName,fileList) $xilDefaultLibName ;# this will be ignored set it to any value
               lappend cores($ipName,fileList) $cores($ipName,IP)
               set ipDestFileDirsDeleted [list]
               foreach {lib ipFile} $cores($ipName,fileList) {
                  set ipFile [file normalize $ipFile]
                  set isRelIpFile [expr [string first $ipDir $ipFile]==0]
                  set isRelToPrjDir [expr [string first [pwd] $ipFile]==0]
                  set isRelToPrjDirButNotPrjDir [expr {$isRelToPrjDir && [file dirname $ipFile] != [pwd]}]
                  set ipDestFileDir ""
                  set ipSourceFile ""
                  if {$isRelIpFile} {
                     if {!$originalCopyDirectory} {
                        set relIpFile [string range $ipFile [expr [string length $ipDir]+1] end]
                        set ipSourceFile [file join $coreDir $relIpFile]
                        if {![file exists $ipSourceFile]} {
                           puts "Warning: $ipSourceFile doesn't exist"
                           continue
                        }
                        set ipDestFile [file join $ipDestDir $relIpFile]
                        set ipDestFileDir [file dirname $ipDestFile]
                     }
                  } else {
                     # ipFile is not relative to ipDir
                     # It is relative to project dir or absolute path, find in fileMapList
                     ::hdsDebugPuts "Found file '$ipFile' not relative to core directory"
                     if {$fileMapSourced} {
                        if {$isRelToPrjDir && $sepcifiedLocation} {
                           puts "Warning: '$ipFile' is within the project directory but not relative to core directory, so it will not be copied to specified location '$ipDestDir'"
                           continue
                        }
                        set index [lsearch $destsList $ipFile]
                        if {$index >= 0} {
                           set ipSourceFile [file normalize [file join $othersDir [lindex $srcsList $index]]]
                           if {![file exists $ipSourceFile]} {
                              puts "Warning: $ipSourceFile doesn't exist"
                              continue
                           }
                           set ipDestFileDir [file dirname [lindex $destsList $index]]
                           set ipImportProject $cores($ipName,ipImportProject)
                           set currentProjectName [file rootname [file tail [current_project]]]
                           if {$ipImportProject != $currentProjectName} {
                              regsub -all "\/$ipImportProject\.srcs\/" $ipDestFileDir "/$currentProjectName.srcs/" ipDestFileDir
                           }
                           if {$cuCopyIPDestPathForceRemoving} {
                              if {[lsearch $ipDestFileDirsDeleted $ipDestFileDir] < 0} {
                                 # Only replace directories if HDS_VIVADO_CREATE_FILEMAP_OVERWRITE_MODE is set to "remove_dir" and files are within at least one directory in project dir
                                 if {$isRelToPrjDirButNotPrjDir && [info exists ::env(HDS_VIVADO_CREATE_FILEMAP_OVERWRITE_MODE)] && $::env(HDS_VIVADO_CREATE_FILEMAP_OVERWRITE_MODE) == "remove_dir"} {
                                    # Delete this directory so we won't get mixed files
                                    catch {file delete -force $ipDestFileDir}
                                 }
                                 lappend ipDestFileDirsDeleted $ipDestFileDir
                              }
                           }
                        } else {
                           # Corrupt file map file?
                           ::hdsDebugPuts "File '$ipFile' which is not relative to core directory is not found in file map file and will be ignored"
                           continue
                        }
                     } else {
                        # Ignore it show message in debug mode only
                        ::hdsDebugPuts "File '$ipFile' which is not relative to core directory will be ignored"
                        continue
                     }
                  }
                  if {$ipDestFileDir != "" && $ipSourceFile != ""} {
                     set ipDestFile [file join $ipDestFileDir [file tail $ipSourceFile]]
                     if {[file exists $ipDestFile]} {
                        # If identical files continue in silence
                        if {[catch {::fileutil::cat $ipSourceFile} res1]} {
                           puts "Error: $res1"
                           set errorOccured 1
                           continue
                        }
                        if {[catch {::fileutil::cat $ipDestFile} res2]} {
                           puts "Error: $res2"
                           set errorOccured 1
                           continue
                        }
                        if {$res1 == $res2} {
                           # Identical files just continue
                           continue
                        }
                        # If cuFileMapOption equals 2 and files are different do not overwrite and print warning
                        if {$cuFileMapOption == 2} {
                           puts "Warning: File '$ipSourceFile' which is not relative to core directory will not be copied to '$ipDestFileDir' a file with the same name already exists."
                           continue
                        } elseif {$cuFileMapOption == 0} {
                           # smart backup mechanism, default option
                           set i 0
                           set origIpDestFileName [file tail $ipSourceFile]
                           set ipDestFileName $origIpDestFileName
                           while {[file exists [file join $ipDestFileDir $ipDestFileName]]} {
                              set ipDestFileName ${origIpDestFileName}_$i
                              incr i
                           }
                           puts "Warning: File $ipDestFile will be renamed to [file join $ipDestFileDir $ipDestFileName]"
                           if {[catch {file rename $ipDestFile [file join $ipDestFileDir $ipDestFileName]} errMsg]} {
                              puts "Error: $errMsg"
                              set errorOccured 1
                              continue
                           }
                        }
                     }
                     if {[catch {file mkdir $ipDestFileDir} errMsg]} {
                        puts "Error: $errMsg"
                        set errorOccured 1
                        continue
                     }
                     if {[catch {file copy -force $ipSourceFile $ipDestFileDir} errMsg]} {
                        puts "Error: $errMsg"
                        set errorOccured 1
                        continue
                     }
                  }
               }
               if {$errorOccured} {
                  puts "Error: Skipping $coreName due to previous errors"
                  incr ::errorCount
                  continue
               }
               set allCopiedFiles [::fileutil::findByPattern $ipDestDir *]
               lappend allCopiedFiles $ipDestDir
               if {[info exists ::env(HDS_VIVADO_IP_MAKE_WRITABLE_ON_CREATE_UPDATE)] && $::env(HDS_VIVADO_IP_MAKE_WRITABLE_ON_CREATE_UPDATE) == "1"} {
                  foreach copiedFile [lsort -unique $allCopiedFiles] {
                     if {[string equal $::tcl_platform(platform) windows]} {
                        catch {file attributes $copiedFile -readonly 0}
                     } else {
                        catch {file attributes $copiedFile -permissions 00774}
                     }
                  }
               }
            }
            set path [file join $ipDestDir $ipName]
            foreach ext $vivadoCoresExtList {
               ::hdsDebugPuts "remove_files -quiet \[get_files -all -quiet ${coreName}.${ext}\]"
               remove_files -quiet [get_files -all -quiet ${coreName}.${ext}]
            }
            ::hdsDebugPuts "add_files $path"
            add_files $path
         } else {
            puts "Note: Adding IP file $path to project, IP directory is not used"
            if {[lsearch -regexp [array names cores] ",ipDir"] < 0 || [lsearch -regexp [array names cores] ",ipName"] < 0} {
               puts "Warning: IP file list is not used"
               if {[string length $ipDestDir]} {
                  # Custom Directory
                  set origCoreDirName $coreName
                  set ipParentDir [file dirname $path]
                  set doCopy 1
                  if {$cuCopyIPDestPathForceRemoving} {
                     set ipDestDir [file join $ipDestDir $origCoreDirName]
                     if {$ipDestDir == $ipParentDir} {
                        # Special case need to import to the same location (Side Data)
                        set doCopy 0
                     } else {
                        catch {file delete -force $ipDestDir}
                     }
                  } else {
                     set i 0
                     set coreDirName $origCoreDirName
                     while {[file exists [file join $ipDestDir $coreDirName]]} {
                        set coreDirName ${origCoreDirName}_$i
                        incr i
                     }
                     set ipDestDir [file join $ipDestDir $coreDirName]
                  }
                  if {$doCopy} {
                     if {[catch {file mkdir $ipDestDir} errMsg]} {
                        puts "Error: $errMsg"
                        incr ::errorCount
                        continue
                     }
                     if {[catch {file copy -force $path $ipDestDir} errMsg]} {
                        puts "Error: $errMsg"
                        incr ::errorCount
                        continue
                     }
                     set copiedFile [file normalize $ipDestDir/[file tail $path]]
                     if {[info exists ::env(HDS_VIVADO_IP_MAKE_WRITABLE_ON_CREATE_UPDATE)] && $::env(HDS_VIVADO_IP_MAKE_WRITABLE_ON_CREATE_UPDATE) == "1"} {
                        if {[string equal $::tcl_platform(platform) windows]} {
                           catch {file attributes $copiedFile -readonly 0}
                        } else {
                           catch {file attributes $copiedFile -permissions 00774}
                        }
                     }
                  }
                  set path [file join $ipDestDir $ipName]
                  foreach ext $vivadoCoresExtList {
                     ::hdsDebugPuts "remove_files -quiet \[get_files -all -quiet ${coreName}.${ext}\]"
                     remove_files -quiet [get_files -all -quiet ${coreName}.${ext}]
                  }
                  ::hdsDebugPuts "add_files $path"
                  add_files $path
               } else {
                  # No Core fileList No custom directory, Just import it
                  foreach ext $vivadoCoresExtList {
                     ::hdsDebugPuts "remove_files -quiet \[get_files -all -quiet ${coreName}.${ext}\]"
                     remove_files -quiet [get_files -all -quiet ${coreName}.${ext}]
                  }
                  if {[regexp {\.(xco|xci)$} [file extension $path]]} {
                     ::hdsDebugPuts "import_ip $path"
                     import_ip $path
                  } else {
                     # Need to create a parent dir for vivado import to work correctly
                     set tempLocation [file normalize "../tmp[clock seconds]"]
                     set newSrcPath [file join $tempLocation $coreName]
                     puts "Creating temporary directory $newSrcPath"
                     catch {file delete -force $tempLocation}
                     if {[catch {file mkdir $newSrcPath} errMsg]} {
                        puts "Error: $errMsg"
                        incr ::errorCount
                        continue
                     }
                     puts "Copying $path to $newSrcPath"
                     if {[catch {file copy -force $path $newSrcPath} errMsg]} {
                        puts "Error: $errMsg"
                        incr ::errorCount
                        continue
                     }
                     set path "$newSrcPath/[file tail $path]"
                     puts "Will import file $path"
                     ::hdsDebugPuts "import_files -flat -force $path"
                     import_files -flat -force $path
                     catch {file delete -force $tempLocation}
                  }
               }
               continue
            }
            # Else Core fileList exists copy files to core directory then add them to project
            puts "Note: Using IP file list file \"$ipFileScript\" to add the IP file $path to project"
            set coreIp [lsearch -regexp -inline [array names cores] ",ipName"]
            set coreIpName $cores($coreIp)
            set coreName [file rootname $coreIpName]
            set ipParentDir [file dirname $path]
            set doCopy 1
            if {[string length $ipDestDir]} {
               # Custom Directory
               set origCoreDirName [file tail $cores($coreIpName,ipDir)]
               if {$cuCopyIPDestPathForceRemoving} {
                  set ipDestDir [file join $ipDestDir $origCoreDirName]
                  if {$ipDestDir == $ipParentDir} {
                     # Special case need to import to the same location (Side Data)
                     set doCopy 0
                  } else {
                     catch {file delete -force $ipDestDir}
                  }
               } else {
                  set i 0
                  set coreDirName $origCoreDirName
                  while {[file exists [file join $ipDestDir $coreDirName]]} {
                     set coreDirName ${origCoreDirName}_$i
                     incr i
                  }
                  set ipDestDir [file join $ipDestDir $coreDirName]
               }
            } else {
               # Original location
               set ipDestDir [file normalize $cores($coreIpName,ipDir)]
               if {[lsearch -regexp [array names cores] ",ipImportProject"] >= 0} {
                  set ipImportProject $cores($coreIpName,ipImportProject)
                  set currentProjectName [file rootname [file tail [current_project]]]
                  if {$ipImportProject != $currentProjectName} {
                     puts "Warning: The IP $ipName, was not originally created in current project \"$currentProjectName\", will modify the destination directory specified in the file list to conform with project \"$currentProjectName\" directory structure"
                     regsub -all "\/$ipImportProject\.srcs\/" $ipDestDir "/$currentProjectName.srcs/" ipDestDir
                  }
               }
               if {$ipDestDir == $ipParentDir} {
                  # Special case need to import to the same location (Side Data)
                  set doCopy 0
               } else {
                  # Delete this directory so we won't get mixed files
                  catch {file delete -force $ipDestDir}
               }
            }
            if {$doCopy} {
               if {[catch {file mkdir $ipDestDir} errMsg]} {
                  puts "Error: $errMsg"
                  incr ::errorCount
                  continue
               }
               if {[catch {file copy -force $path $ipDestDir} errMsg]} {
                  puts "Error: $errMsg"
                  incr ::errorCount
                  continue
               }
               set copiedFile [file normalize $ipDestDir/[file tail $path]]
               if {[info exists ::env(HDS_VIVADO_IP_MAKE_WRITABLE_ON_CREATE_UPDATE)] && $::env(HDS_VIVADO_IP_MAKE_WRITABLE_ON_CREATE_UPDATE) == "1"} {
                  if {[string equal $::tcl_platform(platform) windows]} {
                     catch {file attributes $copiedFile -readonly 0}
                  } else {
                     catch {file attributes $copiedFile -permissions 00774}
                  }
               }
            }
            set path [file join $ipDestDir $ipName]
            foreach ext $vivadoCoresExtList {
               ::hdsDebugPuts "remove_files -quiet \[get_files -all -quiet ${coreName}.${ext}\]"
               remove_files -quiet [get_files -all -quiet ${coreName}.${ext}]
            }
            ::hdsDebugPuts "add_files $path"
            add_files $path
         }
         ::hdsDebugPuts "delete_fileset -quiet -merge \[current_fileset\] \[get_filesets -quiet $coreName\]"
         delete_fileset -quiet -merge [current_fileset] [get_filesets -quiet $coreName]
      }
   }
}

