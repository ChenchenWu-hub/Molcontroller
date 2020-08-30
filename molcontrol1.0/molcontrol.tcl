package provide molcontrol 1.0
namespace eval ::Molcontrl:: {
	namespace export textview
	variable w
	variable filelist {}
	variable molid {}
	variable update_molid {}
	variable chain {}
	variable resid {}
	variable residue {}
	variable residueonly {}
	variable res_num {}
	variable serial {}
	variable element {}
	variable elementonly {}
	variable element_mass {}
	variable mass {}
	variable atom {}
	variable atom_charge {}
	variable atomonly {}
	variable charge {}
	variable residue_id {}
	variable all_mol
	variable center
	variable weight
	variable cmd
	set cmd "all"
	variable position {}
	variable pbc_list {}

	variable trans_x
	variable trans_y
	variable trans_z
	set trans_x 0
	set trans_y 0
	set trans_z 0
	variable trans_reference_x
	variable trans_reference_y
	variable trans_reference_z
	set trans_reference_x 0
	set trans_reference_y 0
	set trans_reference_z 0

	variable rota_x
	variable rota_y
	variable rota_z
	variable is_center
	set is_center "center"
	variable rota_reference_x
	variable rota_reference_y
	variable rota_reference_z
	set rota_reference_x 0
	set rota_reference_y 0
	set rota_reference_z 0
	variable from
	variable to
	set from -10
	set to 10

	variable crystal_size_a
        variable crystal_size_b
        variable crystal_size_c
        variable crystal_size_alpha
        variable crystal_size_beta
        variable crystal_size_gamma

	variable filename {}
	
	variable select_id
	set select_id 0
	variable thesefile {}

	variable turn
	set turn 0

	variable allvalue

	variable chainvalue
	variable residvalue
	variable residuevalue
	variable elementvalue
	variable atomvalue
	variable chargevalue
	set chainvalue 0
        set residvalue 0
        set residuevalue 0
        set elementvalue 0
        set atomvalue 0
        set chargevalue 0
	variable chain_select
	variable resid_select
	variable residue_select
	variable element_select
	variable atom_select
	variable charge_select

	variable selection
	variable choose_center

	variable resid_residue_list {}
	variable chain_id
	set chain_id 0
	variable residue_atom {}
	variable residue_count {}

	variable color_type
	variable draw_type
	variable color_ID
	variable material_type

	variable rep_sel
	set rep_sel 0

	variable style_color_sel {}
	variable info_style_list {}
	variable info_color_list {}
	variable info_sel_list {}
	variable info_material_list {}
	variable color_ID_list {}

	variable this_sel_global
	variable style_color_sel_id
	set style_color_sel_id 0

	variable is_cmd
	set is_cmd 0
	variable is_select
	set is_select 0

	variable style_mode
	set style_mode "haha"

	variable label_type
	variable is_residue
	set is_residue 0
	variable is_atom
	set is_atom 0
	variable is_charge
	set is_charge 0

	variable chain_list_select
	variable residue_list_select

	variable user_choice_x
	variable user_choice_y
	variable user_choice_z

	set user_choice_x 0
	set user_choice_y 0
	set user_choice_z 0

	variable select_files {}
	variable is_top
	set is_top 1

	variable index_out
	set index_out 0

	variable x_min
	variable y_min
	variable z_min
	variable x_max
	variable y_max
	variable z_max

	variable all_atom_number

	variable size_x
	variable size_y
	variable size_z
	set size_x 0
	set size_y 0
	set size_z 0
	
	variable turnon_logfile
	set turnon_logfile 0

	global vmd_logfile_channel
}
proc ::Molcontrl::textview {} {
	variable w
	variable filelist
	variable from
	variable to
	variable file_names
	variable chainvalue
        variable residvalue
        variable residuevalue
        variable elementvalue
        variable atomvalue
        variable chargevalue

	variable chain_select
        variable resid_select
        variable residue_select
        variable element_select
        variable atom_select
        variable charge_select
	
	set w .textview
	catch {destroy $w}
	toplevel $w
	wm title .textview "Molecontroller"
	wm resizable $w 1 1
        wm protocol $w WM_DELETE_WINDOW "menu textview off"

	#set column
	grid columnconfigure $w 0 -weight 1
        grid columnconfigure $w 1 -weight 0
        grid rowconfigure $w 0 -weight 0
        grid rowconfigure $w 1 -weight 1

        grid [ttk::notebook $w.all] -row 1 -column 0 -sticky news -padx 0
        grid columnconfigure $w.all 0 -weight 1
        grid rowconfigure $w.all 1 -weight 1

        ttk::frame $w.all.first
        grid columnconfigure $w.all.first 0 -weight 1
        grid rowconfigure $w.all.first 1 -weight 0
        grid rowconfigure $w.all.first 2 -weight 2

        ttk::frame $w.all.second
        grid columnconfigure $w.all.second 0 -weight 1
        grid rowconfigure $w.all.second 1 -weight 0
        grid rowconfigure $w.all.second 2 -weight 2
        grid rowconfigure $w.all.second 3 -weight 0
        grid rowconfigure $w.all.second 4 -weight 2
	
	$w.all add $w.all.first -text "Information" -sticky news

        ::Molcontrl::molinformation
        #listbox
	labelframe $w.all.first.fra -relief ridge -bd 2
	frame $w.all.first.fra.add_ref_pbc

	frame $w.all.first.fra.add_ref_pbc.file_ref

        labelframe $w.all.first.fra.add_ref_pbc.file_ref.add -relief ridge -text "File List" -bd 2
        
	frame $w.all.first.fra.add_ref_pbc.file_ref.add.file -relief ridge -bd 2
        pack $w.all.first.fra.add_ref_pbc.file_ref.add.file

        scrollbar $w.all.first.fra.add_ref_pbc.file_ref.add.file.scrolly -command ".textview.all.first.fra.add_ref_pbc.file_ref.add.file.box yview"
        scrollbar $w.all.first.fra.add_ref_pbc.file_ref.add.file.scrollx -command ".textview.all.first.fra.add_ref_pbc.file_ref.add.file.box xview" -orient horizontal
	tablelist::tablelist $w.all.first.fra.add_ref_pbc.file_ref.add.file.box -columns {0 "ID" center 0 "File Name" center 0 "Atom Number" center} -selectmode single -width 40 -height 6 -showseparators 0 -state normal -stretch "all" -labelrelief groove  -labelbd 1 -forceeditendcommand true -yscrollcommand [list $w.all.first.fra.add_ref_pbc.file_ref.add.file.scrolly set] -xscrollcommand [list $w.all.first.fra.add_ref_pbc.file_ref.add.file.scrollx set] -listvariable ::Molcontrl::filelist -selectmode extended
#        listbox $w.all.first.fra.add_ref_pbc.file_ref.add.file.box -listvariable ::Molcontrl::filelist -yscroll "$w.all.first.fra.add_ref_pbc.file_ref.add.file.scroll set" -activestyle dotbox -width 40 -height 8 -setgrid 1 -selectmode browse

#        pack $w.all.first.fra.add_ref_pbc.file_ref.add.file.box $w.all.first.fra.add_ref_pbc.file_ref.add.file.scroll -side left -fill y -expand 1
	grid $w.all.first.fra.add_ref_pbc.file_ref.add.file.box -row 0 -column 0 -sticky news
	grid $w.all.first.fra.add_ref_pbc.file_ref.add.file.scrolly -row 0 -column 1 -sticky ns
	grid $w.all.first.fra.add_ref_pbc.file_ref.add.file.scrollx -row 1 -sticky news

	#listbox bind
        bind $w.all.first.fra.add_ref_pbc.file_ref.add.file.box <<ListboxSelect>> {
                #only %W
                ::Molcontrl::geometry %W
        }

	#refresh
	frame $w.all.first.fra.add_ref_pbc.file_ref.refresh
	label $w.all.first.fra.add_ref_pbc.file_ref.refresh.empty_upper -height 0
	button $w.all.first.fra.add_ref_pbc.file_ref.refresh.ref -text "Refresh" -height 1 -command {::Molcontrl::molinformation}
	label $w.all.first.fra.add_ref_pbc.file_ref.refresh.empty_lower -height 6
	pack $w.all.first.fra.add_ref_pbc.file_ref.refresh.empty_upper $w.all.first.fra.add_ref_pbc.file_ref.refresh.ref  $w.all.first.fra.add_ref_pbc.file_ref.refresh.empty_lower -fill y
	grid $w.all.first.fra.add_ref_pbc.file_ref.add $w.all.first.fra.add_ref_pbc.file_ref.refresh -sticky news

	#PBC
	frame $w.all.first.fra.add_ref_pbc.pbc_cry -relief ridge
	frame $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile
	labelframe $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell
        labelframe $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.pbc -text "Unit cell" -relief ridge -bd 2
        label $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.pbc.turn -text "box"
        radiobutton $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.pbc.turnon -text on -variable ::Molcontrl::turn -value 1
        radiobutton $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.pbc.turnoff -text off -variable ::Molcontrl::turn -value 0
	grid $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.pbc.turn $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.pbc.turnon  $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.pbc.turnoff -padx 1m -pady 2m -sticky w

	bind $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.pbc.turnon <Button-1> {
                ::Molcontrl::turnon
        }
        bind $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.pbc.turnoff <Button-1> {
                ::Molcontrl::turnoff
        }

	#cryst1
	labelframe $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1 -text "Cryst1" -relief ridge -bd 2
	frame $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.a_alpha

	frame $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.a_alpha.a_spin
	label $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.a_alpha.a_spin.a  -text "a:"
	spinbox $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.a_alpha.a_spin.spin -width 6 -relief sunken -bd 2 -textvariable ::Molcontrl::crystal_size_a -from 0 -to 100000 -increment 1 -state normal -command {::Molcontrl::pbcset}
	grid $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.a_alpha.a_spin.a $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.a_alpha.a_spin.spin

	frame $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.a_alpha.alpha_spin
	label $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.a_alpha.alpha_spin.alpha  -text "alpha:"
        spinbox $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.a_alpha.alpha_spin.spin -width 6 -relief sunken -bd 2 -textvariable ::Molcontrl::crystal_size_alpha -from 0 -to 180 -increment 1 -state normal -command {::Molcontrl::pbcset}

	grid $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.a_alpha.alpha_spin.alpha $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.a_alpha.alpha_spin.spin 
	grid $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.a_alpha.a_spin -sticky e
	grid $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.a_alpha.alpha_spin -sticky e
	
	frame $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.b_beta

	frame $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.b_beta.b_spin
	label $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.b_beta.b_spin.b  -text "b:"
        spinbox $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.b_beta.b_spin.spin -width 6 -relief sunken -bd 2 -textvariable ::Molcontrl::crystal_size_b -from 0 -to 100000 -increment 1 -state normal -command {::Molcontrl::pbcset}
	grid $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.b_beta.b_spin.b $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.b_beta.b_spin.spin

	frame $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.b_beta.beta_spin
	label $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.b_beta.beta_spin.beta  -text " beta:"
        spinbox $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.b_beta.beta_spin.spin -width 6 -relief sunken -bd 2 -textvariable ::Molcontrl::crystal_size_beta -from 0 -to 180 -increment 1 -state normal -command {::Molcontrl::pbcset}
	grid $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.b_beta.beta_spin.beta $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.b_beta.beta_spin.spin
	grid $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.b_beta.b_spin -sticky e
	grid $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.b_beta.beta_spin -sticky e
	
	frame $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.c_gamma
	
	frame $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.c_gamma.c_spin
	label $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.c_gamma.c_spin.c  -text "c:"
        spinbox $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.c_gamma.c_spin.spin -width 6 -relief sunken -bd 2 -textvariable ::Molcontrl::crystal_size_c -from 0 -to 100000 -increment 1 -state normal -command {::Molcontrl::pbcset}
	grid $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.c_gamma.c_spin.c $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.c_gamma.c_spin.spin
	
	frame $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.c_gamma.gamma_spin
	label $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.c_gamma.gamma_spin.gamma  -text "gamma:"
        spinbox $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.c_gamma.gamma_spin.spin -width 6 -relief sunken -bd 2 -textvariable ::Molcontrl::crystal_size_gamma -from 0 -to 180 -increment 1 -state normal -command {::Molcontrl::pbcset}
	grid $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.c_gamma.gamma_spin.gamma $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.c_gamma.gamma_spin.spin
	grid $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.c_gamma.c_spin -sticky e
	grid $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.c_gamma.gamma_spin -sticky e

	pack $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.a_alpha $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.b_beta $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.c_gamma -fill x -side left

	bind $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.a_alpha.a_spin.spin <Return> {
		::Molcontrl::pbcset
	}

	bind $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.a_alpha.alpha_spin.spin <Return> {
                ::Molcontrl::pbcset
        }
	
	bind $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.b_beta.b_spin.spin  <Return> {
                ::Molcontrl::pbcset
        }

	bind $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.b_beta.beta_spin.spin <Return> {
                ::Molcontrl::pbcset
        }

        bind $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.c_gamma.c_spin.spin <Return> {
                ::Molcontrl::pbcset
        }

        bind $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1.c_gamma.gamma_spin.spin <Return> {
                ::Molcontrl::pbcset
        }	

	pack $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.pbc -side top -fill x
	pack $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell.cryst1 -fill x
	grid $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile.cell

#	pack $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile

	frame $w.all.first.fra.add_ref_pbc.pbc_cry.logfile
	label $w.all.first.fra.add_ref_pbc.pbc_cry.logfile.empty_top -height 0
	labelframe $w.all.first.fra.add_ref_pbc.pbc_cry.logfile.name -text "Logging" -relief ridge -bd 2
	radiobutton $w.all.first.fra.add_ref_pbc.pbc_cry.logfile.name.file_on -text on -variable ::Molcontrl::turnon_logfile -value 1 -command {::Molcontrl::logfile_turnon}
	radiobutton $w.all.first.fra.add_ref_pbc.pbc_cry.logfile.name.file_off -text off -variable ::Molcontrl::turnon_logfile -value 0 -command {::Molcontrl::logfile_turnoff}

	grid $w.all.first.fra.add_ref_pbc.pbc_cry.logfile.name.file_on $w.all.first.fra.add_ref_pbc.pbc_cry.logfile.name.file_off -padx 1m -pady 2m -sticky w

	label $w.all.first.fra.add_ref_pbc.pbc_cry.logfile.empty_bottom -height 6
	pack $w.all.first.fra.add_ref_pbc.pbc_cry.logfile.empty_top $w.all.first.fra.add_ref_pbc.pbc_cry.logfile.name $w.all.first.fra.add_ref_pbc.pbc_cry.logfile.empty_bottom -side top -fill y

	pack  $w.all.first.fra.add_ref_pbc.pbc_cry.cell_logfile $w.all.first.fra.add_ref_pbc.pbc_cry.logfile -fill x -side left -padx 6m

#	grid $w.all.first.fra.add_ref_pbc.file_ref $w.all.first.fra.add_ref_pbc.pbc_cry -padx 15m -sticky news
	pack $w.all.first.fra.add_ref_pbc.file_ref $w.all.first.fra.add_ref_pbc.pbc_cry -padx 6m -fill both -side left

	pack $w.all.first.fra -fill x

	frame $w.all.first.fra.geometry
	pack $w.all.first.fra.add_ref_pbc $w.all.first.fra.geometry -fill y

#	geometry	
#	frame $w.all.first.fra.geometry.command

#	label $w.all.first.fra.geometry.command.label -text "command:" 
#	entry $w.all.first.fra.geometry.command.entry -width 25 -relief sunken -bd 2 -textvariable ::Molcontrl::cmd
	
#	grid $w.all.first.fra.geometry.command.label $w.all.first.fra.geometry.command.entry -padx 1m -pady 2m -sticky news
	#command
#	bind $w.all.first.fra.geometry.command.entry <Return> {
#		::Molcontrl::command
#	}

#	frame $w.all.first.fra.geometry.show_center

#	ttk::combobox $w.all.first.fra.geometry.show_center.combo -state readonly -values [list "geometry center:" "weight of mass:"] -width 13 -textvariable ::Molcontrl::choose_center
#	ttk::style configure $w.all.first.fra.geometry.show_center.combo -background white -foreground white

#	$w.all.first.fra.geometry.show_center.combo current 0

#	bind $w.all.first.fra.geometry.show_center.combo <<ComboboxSelected>> {
#		::Molcontrl::show_center
#	}

#	label $w.all.first.fra.geometry.show_center.center_content -textvariable ::Molcontrl::center -width 30
#	grid $w.all.first.fra.geometry.show_center.combo $w.all.first.fra.geometry.show_center.center_content -padx 1m -sticky news

#	frame $w.all.first.fra.geometry.show_weight

#	label $w.all.first.fra.geometry.show_weight.weight -text "relative molecular mass:"
#	label $w.all.first.fra.geometry.show_weight.weight_content -textvariable ::Molcontrl::weight -width 30

#	grid $w.all.first.fra.geometry.show_weight.weight $w.all.first.fra.geometry.show_weight.weight_content -padx 1m -pady 2m -sticky news

#	pack $w.all.first.fra.geometry.command $w.all.first.fra.geometry.show_center $w.all.first.fra.geometry.show_weight -expand 1 -side left

	#Structure
	labelframe $w.all.first.structure -text "Property" -relief ridge -bd 2 -padx 5 -pady 4
	frame $w.all.first.structure.all
	#chain
	labelframe $w.all.first.structure.all.chain_residue_atom -borderwidth 5
	frame $w.all.first.structure.all.chain_residue_atom.chain
	pack $w.all.first.structure.all.chain_residue_atom.chain

	label $w.all.first.structure.all.chain_residue_atom.chain.chain -text "Chain"
#	bind $w.all.first.structure.all.chain.chain <Button-1> {
#		incr ::Molcontrl::chain_select
#		::Molcontrl::selectall
#	}
	
	frame $w.all.first.structure.all.chain_residue_atom.chain.chain_list
	scrollbar $w.all.first.structure.all.chain_residue_atom.chain.chain_list.scrolly -command ".textview.all.first.structure.all.chain_residue_atom.chain.chain_list.box yview"
	scrollbar $w.all.first.structure.all.chain_residue_atom.chain.chain_list.scrollx -command ".textview.all.first.structure.all.chain_residue_atom.chain.chain_list.box xview" -orient horizontal
        listbox $w.all.first.structure.all.chain_residue_atom.chain.chain_list.box -listvariable ::Molcontrl::chain -xscroll "$w.all.first.structure.all.chain_residue_atom.chain.chain_list.scrollx set" -yscroll "$w.all.first.structure.all.chain_residue_atom.chain.chain_list.scrolly set" -activestyle dotbox -width 12 -height 9 -setgrid 1 -selectmode browse
        grid $w.all.first.structure.all.chain_residue_atom.chain.chain_list.box -column 0 -row 0 -sticky news
        grid $w.all.first.structure.all.chain_residue_atom.chain.chain_list.scrolly -column 1 -row 0 -sticky ns
        grid $w.all.first.structure.all.chain_residue_atom.chain.chain_list.scrollx -row 1 -sticky news

	bind $w.all.first.structure.all.chain_residue_atom.chain.chain_list.box <<ListboxSelect>> {
                #only %w
                ::Molcontrl::resid_residue %W
		::Molcontrl::show_select_chain %W
        }

	grid $w.all.first.structure.all.chain_residue_atom.chain.chain -sticky news
	grid $w.all.first.structure.all.chain_residue_atom.chain.chain_list -sticky news
	
	#resid_residue
	frame $w.all.first.structure.all.chain_residue_atom.resid
	label $w.all.first.structure.all.chain_residue_atom.resid.resid -text "Residue"
#	bind $w.all.first.structure.all.resid.resid <Button-1> {
#		incr ::Molcontrl::resid_select
#                ::Molcontrl::selectall
#        }
	frame $w.all.first.structure.all.chain_residue_atom.resid.resid_list
	scrollbar $w.all.first.structure.all.chain_residue_atom.resid.resid_list.scrolly -command ".textview.all.first.structure.all.chain_residue_atom.resid.resid_list.box yview"
	scrollbar $w.all.first.structure.all.chain_residue_atom.resid.resid_list.scrollx -command ".textview.all.first.structure.all.chain_residue_atom.resid.resid_list.box xview" -orient horizontal
        listbox $w.all.first.structure.all.chain_residue_atom.resid.resid_list.box -listvariable ::Molcontrl::resid_residue_list -xscroll "$w.all.first.structure.all.chain_residue_atom.resid.resid_list.scrollx set" -yscroll "$w.all.first.structure.all.chain_residue_atom.resid.resid_list.scrolly set" -activestyle dotbox -width 12 -height 9 -setgrid 1 -selectmode browse
        grid $w.all.first.structure.all.chain_residue_atom.resid.resid_list.box -column 0 -row 0 -sticky news
        grid $w.all.first.structure.all.chain_residue_atom.resid.resid_list.scrolly -column 1 -row 0 -sticky ns
        grid $w.all.first.structure.all.chain_residue_atom.resid.resid_list.scrollx -row 1 -sticky news
	
	bind $w.all.first.structure.all.chain_residue_atom.resid.resid_list.box <<ListboxSelect>> {
                ::Molcontrl::get_atom %W
		::Molcontrl::show_select_residue %W
        }

	grid $w.all.first.structure.all.chain_residue_atom.resid.resid -sticky news
	grid $w.all.first.structure.all.chain_residue_atom.resid.resid_list -sticky news
	
	#residue_atom
	frame $w.all.first.structure.all.chain_residue_atom.residue
	label $w.all.first.structure.all.chain_residue_atom.residue.residue -text "Atom"
#	bind $w.all.first.structure.all.residue.residue <Button-1> {
#		incr ::Molcontrl::residue_select
#		::Molcontrl::selectall
#        }

	frame $w.all.first.structure.all.chain_residue_atom.residue.residue_list
	scrollbar $w.all.first.structure.all.chain_residue_atom.residue.residue_list.scrolly -command ".textview.all.first.structure.all.chain_residue_atom.residue.residue_list.box yview"
	scrollbar $w.all.first.structure.all.chain_residue_atom.residue.residue_list.scrollx -command ".textview.all.first.structure.all.chain_residue_atom.residue.residue_list.box xview" -orient horizontal
        listbox $w.all.first.structure.all.chain_residue_atom.residue.residue_list.box -listvariable ::Molcontrl::residue_atom -xscroll "$w.all.first.structure.all.chain_residue_atom.residue.residue_list.scrollx set" -yscroll "$w.all.first.structure.all.chain_residue_atom.residue.residue_list.scrolly set" -activestyle dotbox -width 12 -height 9 -setgrid 1 -selectmode browse
        grid $w.all.first.structure.all.chain_residue_atom.residue.residue_list.box -column 0 -row 0 -sticky news
        grid $w.all.first.structure.all.chain_residue_atom.residue.residue_list.scrolly -column 1 -row 0 -sticky ns
        grid $w.all.first.structure.all.chain_residue_atom.residue.residue_list.scrollx -row 1 -sticky news

	bind $w.all.first.structure.all.chain_residue_atom.residue.residue_list.box <<ListboxSelect>> {
                #only %W
                ::Molcontrl::show_select_residueatom %W
        }

	grid $w.all.first.structure.all.chain_residue_atom.residue.residue -sticky news
	grid $w.all.first.structure.all.chain_residue_atom.residue.residue_list -sticky news

	pack $w.all.first.structure.all.chain_residue_atom.chain $w.all.first.structure.all.chain_residue_atom.resid $w.all.first.structure.all.chain_residue_atom.residue -side left -fill x -padx 1 -expand 1

	labelframe $w.all.first.structure.all.count_location -borderwidth 5

	#res_num
	frame $w.all.first.structure.all.count_location.residuenum
	label $w.all.first.structure.all.count_location.residuenum.residuenum -text "Res_Count" 
	
	frame $w.all.first.structure.all.count_location.residuenum.res_num_list
	scrollbar $w.all.first.structure.all.count_location.residuenum.res_num_list.scrolly -command ".textview.all.first.structure.all.count_location.residuenum.res_num_list.box yview"
	scrollbar $w.all.first.structure.all.count_location.residuenum.res_num_list.scrollx -command ".textview.all.first.structure.all.count_location.residuenum.res_num_list.box xview" -orient horizontal
        listbox $w.all.first.structure.all.count_location.residuenum.res_num_list.box -listvariable ::Molcontrl::residue_count -xscroll "$w.all.first.structure.all.count_location.residuenum.res_num_list.scrollx set" -yscroll "$w.all.first.structure.all.count_location.residuenum.res_num_list.scrolly set" -activestyle dotbox -width 12 -height 9 -setgrid 1 -selectmode browse
        grid $w.all.first.structure.all.count_location.residuenum.res_num_list.box -row 0 -column 0 -sticky news
        grid $w.all.first.structure.all.count_location.residuenum.res_num_list.scrolly -row 0 -column 1 -sticky ns
        grid $w.all.first.structure.all.count_location.residuenum.res_num_list.scrollx -row 1 -sticky news

	bind $w.all.first.structure.all.count_location.residuenum.res_num_list.box <<ListboxSelect>> {
		::Molcontrl::get_id %W
		::Molcontrl::show_select_residueall %W
	}
	
	grid $w.all.first.structure.all.count_location.residuenum.residuenum -sticky news
	grid $w.all.first.structure.all.count_location.residuenum.res_num_list -sticky news

	#residueid
	frame $w.all.first.structure.all.count_location.residueid
	label $w.all.first.structure.all.count_location.residueid.residueid -text "Res_Location"

	frame $w.all.first.structure.all.count_location.residueid.res_id_list
	scrollbar $w.all.first.structure.all.count_location.residueid.res_id_list.scrolly -command ".textview.all.first.structure.all.count_location.residueid.res_id_list.box yview"
	scrollbar $w.all.first.structure.all.count_location.residueid.res_id_list.scrollx -command ".textview.all.first.structure.all.count_location.residueid.res_id_list.box xview" -orient horizontal
	listbox $w.all.first.structure.all.count_location.residueid.res_id_list.box -listvariable ::Molcontrl::residue_id -xscroll "$w.all.first.structure.all.count_location.residueid.res_id_list.scrollx set" -yscroll "$w.all.first.structure.all.count_location.residueid.res_id_list.scrolly set" -activestyle dotbox -width 12 -height 9 -setgrid 1 -selectmode browse
	grid $w.all.first.structure.all.count_location.residueid.res_id_list.box -row 0 -column 0 -sticky news
	grid $w.all.first.structure.all.count_location.residueid.res_id_list.scrolly -row 0 -column 1 -sticky ns
	grid $w.all.first.structure.all.count_location.residueid.res_id_list.scrollx -row 1 -sticky news

	bind $w.all.first.structure.all.count_location.residueid.res_id_list.box <<ListboxSelect>> {
		::Molcontrl::show_select_residueid %W
	}

	grid $w.all.first.structure.all.count_location.residueid.residueid -sticky news
	grid $w.all.first.structure.all.count_location.residueid.res_id_list -sticky news

	pack $w.all.first.structure.all.count_location.residuenum $w.all.first.structure.all.count_location.residueid -side left -fill x -padx 1 -expand 1

	#element
#	frame  $w.all.first.structure.all.element
#	label $w.all.first.structure.all.element.element -text "Element_num"
#	bind $w.all.first.structure.all.element.element <Button-1> {
#		incr ::Molcontrl::element_select
#		::Molcontrl::selectall
#        }

#	frame $w.all.first.structure.all.element.element_list
#	scrollbar $w.all.first.structure.all.element.element_list.scrolly -command ".textview.all.first.structure.all.element.element_list.box yview"
#	scrollbar $w.all.first.structure.all.element.element_list.scrollx -command ".textview.all.first.structure.all.element.element_list.box xview" -orient horizontal
#       listbox $w.all.first.structure.all.element.element_list.box -listvariable ::Molcontrl::element -xscroll "$w.all.first.structure.all.element.element_list.scrollx set" -yscroll "$w.all.first.structure.all.element.element_list.scrolly set" -activestyle dotbox -width 9 -height 9 -setgrid 1 -selectmode browse
#        grid $w.all.first.structure.all.element.element_list.box -row 0 -column 0 -sticky news
#        grid $w.all.first.structure.all.element.element_list.scrolly -row 0 -column 1 -sticky ns
#        grid $w.all.first.structure.all.element.element_list.scrollx -row 1 -sticky news
#	
#	bind $w.all.first.structure.all.element.element_list.box <<ListboxSelect>> {
                #only %W
#		::Molcontrl::show_select_element %W
#	}
	
#	grid $w.all.first.structure.all.element.element -sticky news
#	grid $w.all.first.structure.all.element.element_list -sticky news

	#mass
#	frame $w.all.first.structure.mass
#	label $w.all.first.structure.mass.mass -text "Atom_mass"

#	frame $w.all.first.structure.mass.mass_list
#	scrollbar $w.all.first.structure.mass.mass_list.scrolly -command ".textview.all.first.structure.mass.mass_list.box yview"
#	scrollbar $w.all.first.structure.mass.mass_list.scrollx -command ".textview.all.first.structure.mass.mass_list.box xview" -orient horizontal
#        listbox $w.all.first.structure.mass.mass_list.box -listvariable ::Molcontrl::mass -xscroll "$w.all.first.structure.mass.mass_list.scrollx set" -yscroll "$w.all.first.structure.mass.mass_list.scrolly set" -activestyle dotbox -width 13 -height 8 -setgrid 1 -selectmode browse
#        grid $w.all.first.structure.mass.mass_list.box -row 0 -column 0 -sticky news
#        grid $w.all.first.structure.mass.mass_list.scrolly -row 0 -column 1 -sticky ns
#        grid $w.all.first.structure.mass.mass_list.scrollx -row 1 -sticky news

#	grid $w.all.first.structure.mass.mass -sticky news
#	grid $w.all.first.structure.mass.mass_list -sticky news

	#atom
#	frame $w.all.first.structure.all.atom
#	label $w.all.first.structure.all.atom.atom -text "Atom_num"
#	bind $w.all.first.structure.all.atom.atom <Button-1> {
#		incr ::Molcontrl::atom_select
#		::Molcontrl::selectall
#        }

#	frame $w.all.first.structure.all.atom.atom_list
#	scrollbar $w.all.first.structure.all.atom.atom_list.scrolly -command ".textview.all.first.structure.all.atom.atom_list.box yview"
#	scrollbar $w.all.first.structure.all.atom.atom_list.scrollx -command ".textview.all.first.structure.all.atom.atom_list.box xview" -orient horizontal
#        listbox $w.all.first.structure.all.atom.atom_list.box -listvariable ::Molcontrl::atom -xscroll "$w.all.first.structure.all.atom.atom_list.scrollx set" -yscroll "$w.all.first.structure.all.atom.atom_list.scrolly set" -activestyle dotbox -width 9 -height 9 -setgrid 1 -selectmode browse
#        grid $w.all.first.structure.all.atom.atom_list.box -row 0 -column 0 -sticky news
#        grid $w.all.first.structure.all.atom.atom_list.scrolly -row 0 -column 1 -sticky ns
#        grid $w.all.first.structure.all.atom.atom_list.scrollx -row 1 -sticky news

#	bind $w.all.first.structure.all.atom.atom_list.box <<ListboxSelect>> {
                #only %W
#		::Molcontrl::show_select_atom %W
#	}

#	grid $w.all.first.structure.all.atom.atom -sticky news
#	grid $w.all.first.structure.all.atom.atom_list -sticky news

	#charge
#	frame $w.all.first.structure.charge
#	checkbutton $w.all.first.structure.charge.charge -text "Charge" -variable ::Molcontrl::chargevalue
#	bind $w.all.first.structure.charge.charge <Button-1> {
#		incr ::Molcontrl::charge_select
#		::Molcontrl::selectall
#       }
	
#	frame $w.all.first.structure.charge.charge_list
#	scrollbar $w.all.first.structure.charge.charge_list.scrolly -command ".textview.all.first.structure.charge.charge_list.box yview"
#	scrollbar $w.all.first.structure.charge.charge_list.scrollx -command ".textview.all.first.structure.charge.charge_list.box xview" -orient horizontal
 #       listbox $w.all.first.structure.charge.charge_list.box -listvariable ::Molcontrl::charge -xscroll "$w.all.first.structure.charge.charge_list.scrollx set" -yscroll "$w.all.first.structure.charge.charge_list.scrolly set" -activestyle dotbox -width 11 -height 8 -setgrid 1 -selectmode browse
#	grid $w.all.first.structure.charge.charge_list.box -row 0 -column 0 -sticky news
#	grid $w.all.first.structure.charge.charge_list.scrolly -row 0 -column 1 -sticky ns
#	grid $w.all.first.structure.charge.charge_list.scrollx -row 1 -sticky news

#	grid $w.all.first.structure.charge.charge -sticky news
#	grid $w.all.first.structure.charge.charge_list -sticky news


	#Highlight method
	labelframe $w.all.first.structure.all.highlight -text "Highlight" -relief ridge -bd 2 -padx 5 -pady 4
#	label $w.all.first.structure.highlight.drawstyle -text "Draw Style"
	frame $w.all.first.structure.all.highlight.draw
	frame $w.all.first.structure.all.highlight.draw.create_delete
        label $w.all.first.structure.all.highlight.draw.create_delete.drawstyle -text "Draw Style:"
        button $w.all.first.structure.all.highlight.draw.create_delete.create -text "Create Rep" -height 1 -command {::Molcontrl::create_rep}
        button $w.all.first.structure.all.highlight.draw.create_delete.delete -text "Delete Rep" -height 1 -command {::Molcontrl::delete_rep}
	checkbutton $w.all.first.structure.all.highlight.draw.create_delete.mode -text "highlight at the top rep" -variable ::Molcontrl::is_top
        grid $w.all.first.structure.all.highlight.draw.create_delete.drawstyle -sticky w -row 0 -column 0
        grid $w.all.first.structure.all.highlight.draw.create_delete.create -sticky w -row 0 -column 1
        grid $w.all.first.structure.all.highlight.draw.create_delete.delete -sticky w -row 0 -column 2
	grid $w.all.first.structure.all.highlight.draw.create_delete.mode -sticky w -row 0 -column 3
        grid $w.all.first.structure.all.highlight.draw.create_delete -sticky w

	labelframe $w.all.first.structure.all.highlight.draw.rep
	frame $w.all.first.structure.all.highlight.draw.rep.scrollbar

	scrollbar $w.all.first.structure.all.highlight.draw.rep.scrollbar.scrolly -command ".textview.all.first.structure.all.highlight.draw.rep.scrollbar.box yview"
	scrollbar $w.all.first.structure.all.highlight.draw.rep.scrollbar.scrollx -command ".textview.all.first.structure.all.highlight.draw.rep.scrollbar.box xview" -orient horizontal
#	listbox $w.all.first.structure.highlight.draw.rep.scrollbar.box -listvariable ::Molcontrl::style_color_sel -xscroll "$w.all.first.structure.highlight.draw.rep.scrollbar.scrollx set" -yscroll "$w.all.first.structure.highlight.draw.rep.scrollbar.scrolly set" -activestyle dotbox -width 40 -height 3 -setgrid 1 -selectmode browse
	tablelist::tablelist $w.all.first.structure.all.highlight.draw.rep.scrollbar.box -columns {0 "Style" center 0 "Color" center 0 "Selection" center} -selectmode single -width 50 -height 3 -showseparators 0 -state normal -stretch "all" -labelrelief groove  -labelbd 1 -forceeditendcommand true -yscrollcommand [list $w.all.first.structure.all.highlight.draw.rep.scrollbar.scrolly set] -xscrollcommand [list $w.all.first.structure.all.highlight.draw.rep.scrollbar.scrollx set] -listvariable ::Molcontrl::style_color_sel

	$w.all.first.structure.all.highlight.draw.rep.scrollbar.box columnconfigure 0 -width 0 -name ::Molcontrl::style_mode
	$w.all.first.structure.all.highlight.draw.rep.scrollbar.box columnconfigure 1 -width 0 
	$w.all.first.structure.all.highlight.draw.rep.scrollbar.box columnconfigure 2 -width 0 

	grid $w.all.first.structure.all.highlight.draw.rep.scrollbar.box -row 0 -column 0 -sticky news
	grid $w.all.first.structure.all.highlight.draw.rep.scrollbar.scrolly -row 0 -column 1 -sticky ns
	grid $w.all.first.structure.all.highlight.draw.rep.scrollbar.scrollx -row 1 -sticky news

#	bind $w.all.first.structure.highlight.draw.rep.scrollbar.box <Shift-Button-1> {
#		puts "haha"
#		::Molcontrl::mol_show_off
#	}

	bind $w.all.first.structure.all.highlight.draw.rep.scrollbar.box <<TablelistSelect>> {
#		::Molcontrl::ref_sty_col_sel_list
		::Molcontrl::get_highlight_info %W
		::Molcontrl::minmax
	}

	bind $w.all.first.structure.all.highlight.draw.rep.scrollbar.box <Button-1> {
		::Molcontrl::mol_show_off
	}

	bind $w.all.first.structure.all.highlight.draw.rep.scrollbar.box <Double-Button-3> {
		::Molcontrl::mol_show_on
	}

	grid $w.all.first.structure.all.highlight.draw.rep.scrollbar
	grid $w.all.first.structure.all.highlight.draw.rep 

	frame $w.all.first.structure.all.highlight.draw.color
	label $w.all.first.structure.all.highlight.draw.color.color_method -text "Coloring Method:"
	ttk::combobox $w.all.first.structure.all.highlight.draw.color.coloring -state readonly -values [list "Name" "Type" "Element" "ResName" "ResType" "ResID" "Chain" "SegName" "Conformation" "Molecule" "Secondary Structure" "ColorID" "Beta" "Occupancy" "Mass" "Charge" "Radial" "X" "Y" "Z" "User" "User2" "User3" "User4" "Physical Time" "Timestep" "Velocity" "Fragment" "Index" "Backbone" "Throb" "Volume"] -width 13 -textvariable ::Molcontrl::color_type -background white
	bind $w.all.first.structure.all.highlight.draw.color.coloring <<ComboboxSelected>> {
		::Molcontrl::ref_sty_col_sel_list
		::Molcontrl::color
	}

	ttk::combobox $w.all.first.structure.all.highlight.draw.color.colorid -state disabled -values [list "0 blue" "1 red" "2 gray" "3 orange" "4 yellow" "5 tan" "6 silver" "7 green" "8 white" "9 pink" "10 cyan" "11 purple" "12 lime" "13 mauve" "14 ochre" "15 iceblue" "16 black" "17 yellow2" "18 yellow3" "19 green2" "20 green3" "21 cyan2" "22 cyan3" "23 blue2" "24 blue3" "25 violet" "26 violet2" "27 magenta" "28 magenta2" "29 red2" "30 red3" "31 orange2" "32 orange3"] -width 11 -textvariable ::Molcontrl::color_ID -background white
	bind $w.all.first.structure.all.highlight.draw.color.colorid <<ComboboxSelected>> {
		::Molcontrl::ref_sty_col_sel_list
		::Molcontrl::color
	}

	$w.all.first.structure.all.highlight.draw.color.coloring current 0
	$w.all.first.structure.all.highlight.draw.color.colorid current 0
	grid $w.all.first.structure.all.highlight.draw.color.color_method -row 0 -column 0 -sticky w
	grid $w.all.first.structure.all.highlight.draw.color.coloring -sticky w -row 0 -column 1
	grid $w.all.first.structure.all.highlight.draw.color.colorid -sticky w -row 0 -column 2
#	pack $w.all.first.structure.highlight.draw.color.colorID

#	frame $w.all.first.structure.highlight.draw.draw
	label $w.all.first.structure.all.highlight.draw.color.draw_method -text "Drawing Method:"
	ttk::combobox $w.all.first.structure.all.highlight.draw.color.drawing -state readonly -values [list "Lines" "Bonds" "DynamicBonds" "HBonds" "Points" "VDW" "CPK" "Licorice" "Polyhedra" "Trace" "Tube" "Ribbons" "NewRibbons" "Cartoon" "NewCartoon" "PaperChain" "Twister" "QuickSurf" "MSMS" "NanoShaper" "Surf" "VolumeSlice" "Isosurface" "FieldLines" "Orbital" "Beads" "Dotted" "Solvent"] -width 13 -textvariable ::Molcontrl::draw_type -background white
	bind $w.all.first.structure.all.highlight.draw.color.drawing <<ComboboxSelected>> {
		::Molcontrl::ref_sty_col_sel_list
		::Molcontrl::color
	}

	$w.all.first.structure.all.highlight.draw.color.drawing current 0
	grid $w.all.first.structure.all.highlight.draw.color.draw_method -sticky e -row 1 -column 0
	grid $w.all.first.structure.all.highlight.draw.color.drawing -sticky w -row 1 -column 1
#	grid $w.all.first.structure.highlight.draw.color -row 0 -column 1
#	grid $w.all.first.structure.highlight.draw.draw -row 1 -column 1

#	frame $w.all.first.structure.highlight.draw.material
	label $w.all.first.structure.all.highlight.draw.color.material_method -text "Material:"
	ttk::combobox $w.all.first.structure.all.highlight.draw.color.materials -state readonly -values [list "Opaque" "Transparent" "BrushedMetal" "Diffuse" "Ghost" "Glass1" "Glass2" "Glass3" "Glossy" "HardPlastic" "MetallicPastel" "Steel" "Translucent" "Edgy" "EdgyShiny" "EdgyGlass" "Goodsell" "AOShiny" "AOChalky" "AOEdgy" "BlownGlass" "GlassBubble" "RTChrome"] -width 13 -textvariable ::Molcontrl::material_type -background white
	bind $w.all.first.structure.all.highlight.draw.color.materials <<ComboboxSelected>> {
		::Molcontrl::ref_sty_col_sel_list
		::Molcontrl::color
	}

	$w.all.first.structure.all.highlight.draw.color.materials current 0
	grid $w.all.first.structure.all.highlight.draw.color.material_method -sticky e -row 2 -column 0
	grid $w.all.first.structure.all.highlight.draw.color.materials -sticky w -row 2 -column 1
#	grid $w.all.first.structure.highlight.draw.material -row 2 -column 1

	grid $w.all.first.structure.all.highlight.draw.color
#	grid $w.all.first.structure.highlight.draw.draw  -row 3 -column 0 -sticky w
#	grid $w.all.first.structure.highlight.draw.material -row 4 -column 0 -sticky w
	grid $w.all.first.structure.all.highlight.draw -sticky w


#	frame $w.all.first.structure.highlight.label
#	label $w.all.first.structure.highlight.label.label -text "Label:"
#	grid $w.all.first.structure.highlight.label.label -sticky w

#	frame $w.all.first.structure.highlight.label.choose
#	label $w.all.first.structure.highlight.label.choose.title -text "Selection:"
#	ttk::combobox $w.all.first.structure.highlight.label.choose.combobox -state readonly -values [list "residue" "atom" "charge"] -width 13 -textvariable ::Molcontrl::label_type -background white
#	bind $w.all.first.structure.highlight.label.choose.combobox <<ComboboxSelected>> {
#		::Molcontrl::is_res_ato_cha
#	}

#	$w.all.first.structure.highlight.label.choose.combobox current 0

#	button $w.all.first.structure.highlight.label.choose.show -text "Show"
#	bind $w.all.first.structure.highlight.label.choose.show <Button-1> {
#		::Molcontrl::show_sel_label
#	}

#	button $w.all.first.structure.highlight.label.choose.delete -text "Delete"
#	bind $w.all.first.structure.highlight.label.choose.delete <Button-1> {
#		::Molcontrl::show_delete_label
#	}

#	grid $w.all.first.structure.highlight.label.choose.title -row 0 -column 0 -sticky w
#	grid $w.all.first.structure.highlight.label.choose.combobox -row 0 -column 1 -sticky w
#	grid $w.all.first.structure.highlight.label.choose.show -row 0 -column 2 -sticky w
#	grid $w.all.first.structure.highlight.label.choose.delete -row 0 -column 3 -sticky w
#	grid $w.all.first.structure.highlight.label.choose -sticky w

#	grid $w.all.first.structure.highlight.label -sticky w
	

	pack $w.all.first.structure.all.chain_residue_atom $w.all.first.structure.all.count_location $w.all.first.structure.all.highlight -side left -fill x -padx 5 -expand 1
#	pack $w.all.first.structure.all.chain $w.all.first.structure.all.resid $w.all.first.structure.all.residue $w.all.first.structure.all.residuenum $w.all.first.structure.all.residueid $w.all.first.structure.all.highlight -side left -fill x -padx 3 -expand 1

	#       geometry        
        frame $w.all.first.structure.geometry
#	frame $w.all.first.structure.geometry.def
#        button $w.all.first.structure.geometry.def.default -text "Default" -width 5 -command {::Molcontrl::def}
#        grid $w.all.first.structure.geometry.def.default

        frame $w.all.first.structure.geometry.command

        label $w.all.first.structure.geometry.command.label -text "Selected Atoms:"
        entry $w.all.first.structure.geometry.command.entry -width 22 -relief sunken -bd 2 -textvariable ::Molcontrl::cmd

        grid $w.all.first.structure.geometry.command.label $w.all.first.structure.geometry.command.entry -padx 1m -pady 2m -sticky news
        #command
        bind $w.all.first.structure.geometry.command.entry <Return> {
                ::Molcontrl::command
        }

#	frame $w.all.first.structure.geometry.reset
#        button $w.all.first.structure.geometry.reset.scrollbar -text "scroll-bar reset" -width 12 -command {::Molcontrl::reset}
#        grid $w.all.first.structure.geometry.reset.scrollbar

        frame $w.all.first.structure.geometry.show_center

        ttk::combobox $w.all.first.structure.geometry.show_center.combo -state readonly -values [list "geometry center:" "center of mass:"] -width 13 -textvariable ::Molcontrl::choose_center
#       ttk::style configure $w.all.first.fra.geometry.show_center.combo -background white -foreground white

        $w.all.first.structure.geometry.show_center.combo current 0

        bind $w.all.first.structure.geometry.show_center.combo <<ComboboxSelected>> {
                ::Molcontrl::show_center
        }

        label $w.all.first.structure.geometry.show_center.center_content -textvariable ::Molcontrl::center -width 30
        grid $w.all.first.structure.geometry.show_center.combo $w.all.first.structure.geometry.show_center.center_content -padx 1m -sticky news

        frame $w.all.first.structure.geometry.show_weight

        label $w.all.first.structure.geometry.show_weight.weight -text "relative molecular mass:"
        label $w.all.first.structure.geometry.show_weight.weight_content -textvariable ::Molcontrl::weight -width 30

        grid $w.all.first.structure.geometry.show_weight.weight $w.all.first.structure.geometry.show_weight.weight_content -padx 1m -pady 2m -sticky news

        pack $w.all.first.structure.geometry.command $w.all.first.structure.geometry.show_center $w.all.first.structure.geometry.show_weight -expand 1 -side left

	frame $w.all.first.structure.minmax

	labelframe $w.all.first.structure.minmax.x
	frame $w.all.first.structure.minmax.x.minx
	label $w.all.first.structure.minmax.x.minx.x_min_info -text "min x:" -width 7
	label $w.all.first.structure.minmax.x.minx.x_min -textvariable ::Molcontrl::x_min -width 7
	grid $w.all.first.structure.minmax.x.minx.x_min_info $w.all.first.structure.minmax.x.minx.x_min

	frame $w.all.first.structure.minmax.x.maxx
        label $w.all.first.structure.minmax.x.maxx.x_max_info -text "max x:" -width 7
        label $w.all.first.structure.minmax.x.maxx.x_max -textvariable ::Molcontrl::x_max -width 7
        grid $w.all.first.structure.minmax.x.maxx.x_max_info $w.all.first.structure.minmax.x.maxx.x_max

	frame $w.all.first.structure.minmax.x.sizex
	label $w.all.first.structure.minmax.x.sizex.size_x_info -text "size x:" -width 7
	label $w.all.first.structure.minmax.x.sizex.size_x -textvariable ::Molcontrl::size_x -width 7
	grid $w.all.first.structure.minmax.x.sizex.size_x_info $w.all.first.structure.minmax.x.sizex.size_x
	
	grid $w.all.first.structure.minmax.x.minx $w.all.first.structure.minmax.x.maxx $w.all.first.structure.minmax.x.sizex

	labelframe $w.all.first.structure.minmax.y
	frame $w.all.first.structure.minmax.y.miny
	label $w.all.first.structure.minmax.y.miny.y_min_info -text "min y:" -width 7
	label $w.all.first.structure.minmax.y.miny.y_min -textvariable ::Molcontrl::y_min -width 7
	grid $w.all.first.structure.minmax.y.miny.y_min_info $w.all.first.structure.minmax.y.miny.y_min

	frame $w.all.first.structure.minmax.y.maxy
        label $w.all.first.structure.minmax.y.maxy.y_max_info -text "max y:" -width 7
        label $w.all.first.structure.minmax.y.maxy.y_max -textvariable ::Molcontrl::y_max -width 7
        grid $w.all.first.structure.minmax.y.maxy.y_max_info $w.all.first.structure.minmax.y.maxy.y_max

	frame $w.all.first.structure.minmax.y.sizey
        label $w.all.first.structure.minmax.y.sizey.size_y_info -text "size y:" -width 7
        label $w.all.first.structure.minmax.y.sizey.size_y -textvariable ::Molcontrl::size_y -width 7
        grid $w.all.first.structure.minmax.y.sizey.size_y_info $w.all.first.structure.minmax.y.sizey.size_y

	grid $w.all.first.structure.minmax.y.miny $w.all.first.structure.minmax.y.maxy $w.all.first.structure.minmax.y.sizey

	labelframe $w.all.first.structure.minmax.z
	frame $w.all.first.structure.minmax.z.minz
	label $w.all.first.structure.minmax.z.minz.z_min_info -text "min z:" -width 7
	label $w.all.first.structure.minmax.z.minz.z_min -textvariable ::Molcontrl::z_min -width 7
	grid $w.all.first.structure.minmax.z.minz.z_min_info $w.all.first.structure.minmax.z.minz.z_min

	frame $w.all.first.structure.minmax.z.maxz
	label $w.all.first.structure.minmax.z.maxz.z_max_info -text "max z:" -width 7
	label $w.all.first.structure.minmax.z.maxz.z_max -textvariable ::Molcontrl::z_max -width 7
	grid $w.all.first.structure.minmax.z.maxz.z_max_info $w.all.first.structure.minmax.z.maxz.z_max

	frame $w.all.first.structure.minmax.z.sizez
        label $w.all.first.structure.minmax.z.sizez.size_z_info -text "size z:" -width 7
        label $w.all.first.structure.minmax.z.sizez.size_z -textvariable ::Molcontrl::size_z -width 7
        grid $w.all.first.structure.minmax.z.sizez.size_z_info $w.all.first.structure.minmax.z.sizez.size_z

	grid $w.all.first.structure.minmax.z.minz $w.all.first.structure.minmax.z.maxz $w.all.first.structure.minmax.z.sizez
	pack $w.all.first.structure.minmax.x $w.all.first.structure.minmax.y $w.all.first.structure.minmax.z -fill x -side left -padx 3

	pack $w.all.first.structure.all $w.all.first.structure.geometry $w.all.first.structure.minmax -fill y
	pack $w.all.first.structure -fill x

        #moving
        labelframe $w.all.first.moving -text "Manipulation" -relief ridge -bd 2 -padx 5 -pady 4
	# default scrollbar
	frame $w.all.first.moving.default_and_reset

	frame $w.all.first.moving.default_and_reset.default
        button $w.all.first.moving.default_and_reset.default.def -text "Default" -width 12 -command {::Molcontrl::def}
        grid $w.all.first.moving.default_and_reset.default.def

	frame $w.all.first.moving.default_and_reset.reset
        button $w.all.first.moving.default_and_reset.reset.scrollbar -text "scroll-bar reset" -width 12 -command {::Molcontrl::reset}
        grid $w.all.first.moving.default_and_reset.reset.scrollbar
	grid $w.all.first.moving.default_and_reset.default $w.all.first.moving.default_and_reset.reset -sticky w -padx 1m

	#       geometry        
#        frame $w.all.first.moving.geometry
#        frame $w.all.first.moving.geometry.command

#        label $w.all.first.moving.geometry.command.label -text "Selected Atoms:"
#        entry $w.all.first.moving.geometry.command.entry -width 22 -relief sunken -bd 2 -textvariable ::Molcontrl::cmd

#        grid $w.all.first.moving.geometry.command.label $w.all.first.moving.geometry.command.entry -padx 1m -pady 2m -sticky news
        #command
#        bind $w.all.first.moving.geometry.command.entry <Return> {
#                ::Molcontrl::command
#        }

#        frame $w.all.first.moving.geometry.show_center

#        ttk::combobox $w.all.first.moving.geometry.show_center.combo -state readonly -values [list "geometry center:" "center of mass:"] -width 13 -textvariable ::Molcontrl::choose_center
#       ttk::style configure $w.all.first.fra.geometry.show_center.combo -background white -foreground white

#        $w.all.first.moving.geometry.show_center.combo current 0

#        bind $w.all.first.moving.geometry.show_center.combo <<ComboboxSelected>> {
#                ::Molcontrl::show_center
#        }

#        label $w.all.first.moving.geometry.show_center.center_content -textvariable ::Molcontrl::center -width 22
#        grid $w.all.first.moving.geometry.show_center.combo $w.all.first.moving.geometry.show_center.center_content -padx 1m -sticky news

#        frame $w.all.first.moving.geometry.show_weight

#        label $w.all.first.moving.geometry.show_weight.weight -text "relative molecular mass:"
#        label $w.all.first.moving.geometry.show_weight.weight_content -textvariable ::Molcontrl::weight -width 22

#        grid $w.all.first.moving.geometry.show_weight.weight $w.all.first.moving.geometry.show_weight.weight_content -padx 1m -pady 2m -sticky news

#	frame $w.all.first.moving.geometry.def
#        button $w.all.first.moving.geometry.def.default -text "Default" -width 5 -command {::Molcontrl::def}
#        grid $w.all.first.moving.geometry.def.default

#        pack $w.all.first.moving.geometry.command $w.all.first.moving.geometry.show_center $w.all.first.moving.geometry.show_weight $w.all.first.moving.geometry.def -expand 1 -side left
#	pack $w.all.first.moving.geometry -fill x -side left

	# move rotate
	frame $w.all.first.moving.shift
        labelframe $w.all.first.moving.shift.translate -text "Moving" -relief ridge -bd 2 -padx 5 -pady 4
        labelframe $w.all.first.moving.shift.rotate -text "Rotating" -relief ridge -bd 2 -padx 5 -pady 4
        pack $w.all.first.moving.shift.translate $w.all.first.moving.shift.rotate -expand 1 -fill both -side left
#	grid $w.all.first.moving.translate -sticky nws -row 0 -column 0
#	grid $w.all.first.moving.rotate -sticky nes -row 0 -column 1

        #translate
        #from to
	frame $w.all.first.moving.shift.translate.up
        frame $w.all.first.moving.shift.translate.up.fr_to
        label $w.all.first.moving.shift.translate.up.fr_to.from -text "From:"
        entry $w.all.first.moving.shift.translate.up.fr_to.fro_con -width 8 -bd 2 -textvariable ::Molcontrl::from
        label $w.all.first.moving.shift.translate.up.fr_to.to -text "To:"
        entry $w.all.first.moving.shift.translate.up.fr_to.to_con -width 8 -bd 2 -textvariable ::Molcontrl::to
        bind $w.all.first.moving.shift.translate.up.fr_to.fro_con <Return> {
                ::Molcontrl::change
        }
        bind $w.all.first.moving.shift.translate.up.fr_to.to_con <Return> {
                ::Molcontrl::change
        }

        pack $w.all.first.moving.shift.translate.up.fr_to.from $w.all.first.moving.shift.translate.up.fr_to.fro_con $w.all.first.moving.shift.translate.up.fr_to.to $w.all.first.moving.shift.translate.up.fr_to.to_con -side left -fill x -padx 1m

#        frame $w.all.first.moving.shift.translate.up.reset
#        button $w.all.first.moving.shift.translate.up.reset.scrollbar -text "scroll-bar reset" -width 12 -command {::Molcontrl::reset}
#        grid $w.all.first.moving.shift.translate.up.reset.scrollbar

        pack $w.all.first.moving.shift.translate.up.fr_to -side left -fill x -padx 1m

	#xyz
	frame $w.all.first.moving.shift.translate.down
	frame $w.all.first.moving.shift.translate.down.pack_x
        label $w.all.first.moving.shift.translate.down.pack_x.x -text "X:"
        entry $w.all.first.moving.shift.translate.down.pack_x.x_sit -width 5 -bd 2 -textvariable ::Molcontrl::trans_x
        scale $w.all.first.moving.shift.translate.down.pack_x.x_scale -label "X:" -variable ::Molcontrl::trans_x -length 58m -width .25c -from -10 -to 10 -resolution 1 -tickinterval 4 -showvalue 0 -orient horizontal -command {::Molcontrl::move_x}
        grid $w.all.first.moving.shift.translate.down.pack_x.x $w.all.first.moving.shift.translate.down.pack_x.x_sit $w.all.first.moving.shift.translate.down.pack_x.x_scale
        bind $w.all.first.moving.shift.translate.down.pack_x.x_sit <Return> {
                ::Molcontrl::move_trans
		::Molcontrl::reset
        }

	frame $w.all.first.moving.shift.translate.down.pack_y
        label $w.all.first.moving.shift.translate.down.pack_y.y -text "Y:"
        entry $w.all.first.moving.shift.translate.down.pack_y.y_sit -width 5 -bd 2 -textvariable ::Molcontrl::trans_y
        scale $w.all.first.moving.shift.translate.down.pack_y.y_scale -label "Y:" -variable ::Molcontrl::trans_y -length 58m -width .25c -from -10 -to 10 -resolution 1 -tickinterval 4 -showvalue 0 -orient horizontal -command {::Molcontrl::move_y}
        grid $w.all.first.moving.shift.translate.down.pack_y.y $w.all.first.moving.shift.translate.down.pack_y.y_sit $w.all.first.moving.shift.translate.down.pack_y.y_scale
        bind $w.all.first.moving.shift.translate.down.pack_y.y_sit <Return> {
                ::Molcontrl::move_trans
		::Molcontrl::reset
        }

	frame $w.all.first.moving.shift.translate.down.pack_z
        label $w.all.first.moving.shift.translate.down.pack_z.z -text "Z:"
        entry $w.all.first.moving.shift.translate.down.pack_z.z_sit -width 5 -bd 2 -textvariable ::Molcontrl::trans_z
        scale $w.all.first.moving.shift.translate.down.pack_z.z_scale -label "Z:" -variable ::Molcontrl::trans_z -length 58m -width .25c -from -10 -to 10 -resolution 1 -tickinterval 4 -showvalue 0 -orient horizontal -command {::Molcontrl::move_z}
        grid $w.all.first.moving.shift.translate.down.pack_z.z $w.all.first.moving.shift.translate.down.pack_z.z_sit $w.all.first.moving.shift.translate.down.pack_z.z_scale
        bind $w.all.first.moving.shift.translate.down.pack_z.z_sit <Return> {
                ::Molcontrl::move_trans
		::Molcontrl::reset
        }
	pack $w.all.first.moving.shift.translate.down.pack_x $w.all.first.moving.shift.translate.down.pack_y $w.all.first.moving.shift.translate.down.pack_z -fill y -pady 1m -expand 1 -side top
	pack $w.all.first.moving.shift.translate.up $w.all.first.moving.shift.translate.down -fill y -pady 1m

	#rotate
        frame $w.all.first.moving.shift.rotate.rot_ref
        grid $w.all.first.moving.shift.rotate.rot_ref

	frame $w.all.first.moving.shift.rotate.rot_ref.empty_rot

	frame $w.all.first.moving.shift.rotate.rot_ref.empty_rot.empty
	label $w.all.first.moving.shift.rotate.rot_ref.empty_rot.empty.lab -text " "
	grid $w.all.first.moving.shift.rotate.rot_ref.empty_rot.empty.lab

        frame $w.all.first.moving.shift.rotate.rot_ref.empty_rot.rot
        grid $w.all.first.moving.shift.rotate.rot_ref.empty_rot.rot

	frame $w.all.first.moving.shift.rotate.rot_ref.empty_rot.rot.pack_x
        label $w.all.first.moving.shift.rotate.rot_ref.empty_rot.rot.pack_x.x -text "X:"
        entry $w.all.first.moving.shift.rotate.rot_ref.empty_rot.rot.pack_x.x_sit -width 5 -relief sunken -bd 2 -textvariable ::Molcontrl::rota_x
        scale $w.all.first.moving.shift.rotate.rot_ref.empty_rot.rot.pack_x.x_scale -label "X:" -variable ::Molcontrl::rota_x -length 58m -width .25c -from -180 -to 180 -resolution 1 -tickinterval 90 -showvalue 0 -orient horizontal -command {::Molcontrl::rotatex}
        grid $w.all.first.moving.shift.rotate.rot_ref.empty_rot.rot.pack_x.x $w.all.first.moving.shift.rotate.rot_ref.empty_rot.rot.pack_x.x_sit $w.all.first.moving.shift.rotate.rot_ref.empty_rot.rot.pack_x.x_scale
        bind $w.all.first.moving.shift.rotate.rot_ref.empty_rot.rot.pack_x.x_sit <Return> {
                ::Molcontrl::move_rotax
		::Molcontrl::reset
        }

	frame $w.all.first.moving.shift.rotate.rot_ref.empty_rot.rot.pack_y
        label $w.all.first.moving.shift.rotate.rot_ref.empty_rot.rot.pack_y.y -text "Y:"
        entry $w.all.first.moving.shift.rotate.rot_ref.empty_rot.rot.pack_y.y_sit -width 5 -relief sunken -bd 2 -textvariable ::Molcontrl::rota_y
        scale $w.all.first.moving.shift.rotate.rot_ref.empty_rot.rot.pack_y.y_scale -label "Y:" -variable ::Molcontrl::rota_y -length 58m -width .25c -from -180 -to 180 -resolution 1 -tickinterval 90 -showvalue 0 -orient horizontal -command {::Molcontrl::rotatey}
        grid $w.all.first.moving.shift.rotate.rot_ref.empty_rot.rot.pack_y.y $w.all.first.moving.shift.rotate.rot_ref.empty_rot.rot.pack_y.y_sit $w.all.first.moving.shift.rotate.rot_ref.empty_rot.rot.pack_y.y_scale
        bind $w.all.first.moving.shift.rotate.rot_ref.empty_rot.rot.pack_y.y_sit <Return> {
                ::Molcontrl::move_rotay
		::Molcontrl::reset
        }

	frame $w.all.first.moving.shift.rotate.rot_ref.empty_rot.rot.pack_z
        label $w.all.first.moving.shift.rotate.rot_ref.empty_rot.rot.pack_z.z -text "Z:"
        entry $w.all.first.moving.shift.rotate.rot_ref.empty_rot.rot.pack_z.z_sit -width 5 -relief sunken -bd 2 -textvariable ::Molcontrl::rota_z
        scale $w.all.first.moving.shift.rotate.rot_ref.empty_rot.rot.pack_z.z_scale -label "Z:" -variable ::Molcontrl::rota_z -length 58m -width .25c -from -180 -to 180 -resolution 1 -tickinterval 90 -showvalue 0 -orient horizontal -command {::Molcontrl::rotatez}
        grid $w.all.first.moving.shift.rotate.rot_ref.empty_rot.rot.pack_z.z $w.all.first.moving.shift.rotate.rot_ref.empty_rot.rot.pack_z.z_sit $w.all.first.moving.shift.rotate.rot_ref.empty_rot.rot.pack_z.z_scale
        bind $w.all.first.moving.shift.rotate.rot_ref.empty_rot.rot.pack_z.z_sit <Return> {
                ::Molcontrl::move_rotaz
		::Molcontrl::reset
        }
	pack $w.all.first.moving.shift.rotate.rot_ref.empty_rot.rot.pack_x $w.all.first.moving.shift.rotate.rot_ref.empty_rot.rot.pack_y $w.all.first.moving.shift.rotate.rot_ref.empty_rot.rot.pack_z -fill y -pady 1m -side top -expand 1
	pack $w.all.first.moving.shift.rotate.rot_ref.empty_rot.empty $w.all.first.moving.shift.rotate.rot_ref.empty_rot.rot -fill y -pady 1m

	#reference
        frame $w.all.first.moving.shift.rotate.rot_ref.ref

        labelframe $w.all.first.moving.shift.rotate.rot_ref.ref.reference -text "Reference" -relief ridge -bd 2 -padx 5 -pady 4
        grid $w.all.first.moving.shift.rotate.rot_ref.ref.reference

        label $w.all.first.moving.shift.rotate.rot_ref.ref.reference.empty_upper -height 4
        radiobutton $w.all.first.moving.shift.rotate.rot_ref.ref.reference.center -text "geometric center" -variable ::Molcontrl::is_center -value "center"
	bind $w.all.first.moving.shift.rotate.rot_ref.ref.reference.center <Button-1> {
                ::Molcontrl::need_disable
        }

        radiobutton $w.all.first.moving.shift.rotate.rot_ref.ref.reference.weight -text "center of mass" -variable ::Molcontrl::is_center -value "weight mass"
	bind $w.all.first.moving.shift.rotate.rot_ref.ref.reference.weight <Button-1> {
                ::Molcontrl::need_disable
        }

        radiobutton $w.all.first.moving.shift.rotate.rot_ref.ref.reference.origin -text "origin" -variable ::Molcontrl::is_center -value "origin"
	bind $w.all.first.moving.shift.rotate.rot_ref.ref.reference.origin <Button-1> {
                ::Molcontrl::need_disable
        }

        radiobutton $w.all.first.moving.shift.rotate.rot_ref.ref.reference.user -text "user" -variable ::Molcontrl::is_center -value "user"
	bind $w.all.first.moving.shift.rotate.rot_ref.ref.reference.user <Button-1> {
                ::Molcontrl::need_able
        }

	frame $w.all.first.moving.shift.rotate.rot_ref.ref.reference.user_choice
	frame $w.all.first.moving.shift.rotate.rot_ref.ref.reference.user_choice.x
	label $w.all.first.moving.shift.rotate.rot_ref.ref.reference.user_choice.x.x_text -text "X:"
	entry $w.all.first.moving.shift.rotate.rot_ref.ref.reference.user_choice.x.x_entry -width 5 -relief sunken -bd 2 -textvariable ::Molcontrl::user_choice_x -state disabled
	pack $w.all.first.moving.shift.rotate.rot_ref.ref.reference.user_choice.x.x_text $w.all.first.moving.shift.rotate.rot_ref.ref.reference.user_choice.x.x_entry -side left -fill x 

	frame $w.all.first.moving.shift.rotate.rot_ref.ref.reference.user_choice.y 
	label $w.all.first.moving.shift.rotate.rot_ref.ref.reference.user_choice.y.y_text -text "Y:"
	entry $w.all.first.moving.shift.rotate.rot_ref.ref.reference.user_choice.y.y_entry -width 5 -relief sunken -bd 2 -textvariable ::Molcontrl::user_choice_y -state disabled
	pack $w.all.first.moving.shift.rotate.rot_ref.ref.reference.user_choice.y.y_text $w.all.first.moving.shift.rotate.rot_ref.ref.reference.user_choice.y.y_entry -side left -fill x

	frame $w.all.first.moving.shift.rotate.rot_ref.ref.reference.user_choice.z
	label $w.all.first.moving.shift.rotate.rot_ref.ref.reference.user_choice.z.z_text -text "Z:"
	entry $w.all.first.moving.shift.rotate.rot_ref.ref.reference.user_choice.z.z_entry -width 5 -relief sunken -bd 2 -textvariable ::Molcontrl::user_choice_z -state disabled
	pack $w.all.first.moving.shift.rotate.rot_ref.ref.reference.user_choice.z.z_text $w.all.first.moving.shift.rotate.rot_ref.ref.reference.user_choice.z.z_entry -side left -fill x

	pack $w.all.first.moving.shift.rotate.rot_ref.ref.reference.user_choice.x $w.all.first.moving.shift.rotate.rot_ref.ref.reference.user_choice.y $w.all.first.moving.shift.rotate.rot_ref.ref.reference.user_choice.z -fill x -side left

        label $w.all.first.moving.shift.rotate.rot_ref.ref.reference.empty_lower -height 4
        grid $w.all.first.moving.shift.rotate.rot_ref.ref.reference.empty_upper -sticky w
        grid $w.all.first.moving.shift.rotate.rot_ref.ref.reference.center -sticky w
        grid $w.all.first.moving.shift.rotate.rot_ref.ref.reference.weight -sticky w
        grid $w.all.first.moving.shift.rotate.rot_ref.ref.reference.origin -sticky w
	grid $w.all.first.moving.shift.rotate.rot_ref.ref.reference.user -sticky w
	grid $w.all.first.moving.shift.rotate.rot_ref.ref.reference.user_choice
        grid $w.all.first.moving.shift.rotate.rot_ref.ref.reference.empty_lower -sticky w

        pack $w.all.first.moving.shift.rotate.rot_ref.empty_rot $w.all.first.moving.shift.rotate.rot_ref.ref -side left -fill both -expand 1
	pack $w.all.first.moving.default_and_reset $w.all.first.moving.shift -fill both

        pack $w.all.first.moving -fill x

	#merge
	labelframe $w.all.first.merge -text "Save File" -relief ridge -bd 2 -padx 5 -pady 4
	
	label $w.all.first.merge.show -text "Save Type:"

	menubutton $w.all.first.merge.mb -textvariable ::Molcontrl::selection -width 60 -bg white
	set m [menu $w.all.first.merge.mb.menu -tearoff 0]
	$w.all.first.merge.mb configure -menu $m
	$m add radiobutton -value "Res_Count" -variable ::Molcontrl::selection -label "Res_Count"
	$m add radiobutton -value "Selected Atoms" -variable ::Molcontrl::selection -label "Selected Atoms"
	$m add radiobutton -value "Selected File/Molecular" -variable ::Molcontrl::selection -label "Selected File/Molecular"
	$m add radiobutton -value "Merged All Listed Files" -variable ::Molcontrl::selection -label "Merged All Listed Files"

	button $w.all.first.merge.save -text "Save" -command {::Molcontrl::judge}
	pack $w.all.first.merge.show $w.all.first.merge.mb $w.all.first.merge.save -side left -padx 1m -expand 1

	pack $w.all.first.merge -fill x

	label $w.all.first.extend -height 0
	pack $w.all.first.extend -fill x

	grid rowconfigure . 0 -weight 1
        grid columnconfigure . 0 -weight 1
}
proc ::Molcontrl::molinformation {} {
	variable filelist
	variable molid
	variable all_mol
	variable thesefile
	variable position
	variable update_molid
	variable pbc_list
	variable chain
	variable resid_residue_list
	variable residue_atom
	variable residue_count
	variable residue_id
	variable atom
	variable element
	variable crystal_size_a
	variable crystal_size_b
	variable crystal_size_c
	variable crystal_size_alpha
	variable crystal_size_beta
	variable crystal_size_gamma
	variable center
	variable weight
	variable select_files
	variable x_min
	variable y_min
        variable z_min
        variable x_max
        variable y_max
        variable z_max
	variable size_x
	variable size_y
	variable size_z
	variable all_atom_number

	variable style_color_sel
	set style_color_sel {}

	set chain {}
	set resid_residue_list {}
	set residue_atom {}
	set residue_count {}
	set residue_id {}
	set atom {}
	set element {}

	set filelist {}
	set thesefile {}
	set pbc_list {}

	set ::Molcontrl::turn 0

	set crystal_size_a 0
	set crystal_size_b 0
	set crystal_size_c 0
	set crystal_size_alpha 0
	set crystal_size_beta 0
	set crystal_size_gamma 0

	set x_min 0
	set y_min 0
	set z_min 0
	set x_max 0
	set y_max 0
	set z_max 0

	set size_x 0
	set size_y 0
	set size_z 0
	
	set center {}
	set weight 0

	set select_files {}
	set all_atom_number {}

	set all_mol [molinfo num]
	if {$all_mol==0} {
		return
	}

	set flag 0
	set update_molid {}
	set update_molid [molinfo list]
	set number 0
        set newlength [llength $update_molid]
        set mollength [llength $molid]
        if {$newlength==$mollength} {
                while {$number<$mollength} {
                        set new [lindex $update_molid $number]
                        set old [lindex $molid $number]
                        if {$new!=$old} {
                                set flag 1
                                break
                        }
			incr number
                }
        }
	if {$newlength!=$mollength} {
		set flag 1
	}

	if {$flag==1} {
		set molid $update_molid
		set number 0
		while {$number < $all_mol} {
			#id
			set id [lindex $molid $number]
			set id_info_list [list $id]
			#file
			set file_name_all [molinfo $id get filename]
			foreach single_split_file $file_name_all {
				foreach single_file_name $single_split_file {
					set get_file_extension [file extension $single_file_name]
                                        if {$get_file_extension==".pdb"} {
                                                lappend thesefile $single_file_name
                                                set file_name [file tail $single_file_name]
                                        }
                                        if {$get_file_extension==".gro"} {
                                                lappend thesefile $single_file_name
                                                set file_name [file tail $single_file_name]
                                        }
                                        if {$get_file_extension==".mol2"} {
                                                lappend thesefile $single_file_name
                                                set file_name [file tail $single_file_name]
                                        }
                                        if {$get_file_extension==""} {
                                                lappend thesefile $single_file_name
						set file_name [file tail $single_file_name]
					}
				}
			}

			set file_name_info_list [list $file_name]
			#atom
			set sel [atomselect $id all]
			set atom_num [$sel num]

			set atom_num_info_list [list $atom_num]
			lappend all_atom_number $atom_num
	
			set msg [format "%s   %s   %s" $id_info_list $file_name_info_list $atom_num_info_list]
			lappend ::Molcontrl::filelist $msg

			incr number
		}
	} else {
                set number 0
                while {$number < $all_mol} {
                        #id
                        set id [lindex $molid $number]
			set id_info_list [list $id]
                        #file
                        set file_name_all [molinfo $id get filename]
			foreach single_split_file $file_name_all {
                                foreach single_file_name $single_split_file {
                                        set get_file_extension [file extension $single_file_name]
                                        if {$get_file_extension==".pdb"} {
                                                lappend thesefile $single_file_name
                                                set file_name [file tail $single_file_name]
                                        }
                                        if {$get_file_extension==".gro"} {
                                                lappend thesefile $single_file_name
                                                set file_name [file tail $single_file_name]
                                        }
                                        if {$get_file_extension==".mol2"} {
                                                lappend thesefile $single_file_name
                                                set file_name [file tail $single_file_name]
                                        }
                                        if {$get_file_extension==""} {
                                                lappend thesefile $single_file_name
                                                set file_name [file tail $single_file_name]
                                        }
                                }
                        }
			
			set file_name_info_list [list $file_name]
                        #atom
                        set sel [atomselect $id all]
                        set atom_num [$sel num] 

			set atom_num_info_list [list $atom_num]
			lappend all_atom_number $atom_num

			set msg [format "%s   %s   %s" $id_info_list $file_name_info_list $atom_num_info_list]
                        lappend ::Molcontrl::filelist $msg 

                        incr number
                }
	}

	#position
	set number 0
        while {$number<$all_mol} {
		set is_exist 0
                set id [lindex $molid $number]
		foreach val $position {
			if {$val==$id} {
				set is_exist 1
			}
		}
		if {$is_exist==0} {
                	set sel [atomselect $id all]
                	set apos [$sel get {x y z}]
			lappend position $id
	               	lappend position $apos
		}
		incr number
        }

	#pbc
	set number 0
	while {$number < $all_mol} {
		set id [lindex $molid $number]
		set pbcsit [molinfo $id get {a b c alpha beta gamma}]
		lappend pbc_list $pbcsit
		incr number
	}
	::Molcontrl::turnoff
}
proc ::Molcontrl::geometry {W} {
	variable molid
	variable all_mol
	variable center
	variable weight
	variable chain
	variable resid
	variable residue
	variable residueonly
	variable res_num
	variable serial
	variable element
	variable elementonly
	variable element_mass
	variable atom
	variable atom_charge
	variable atomonly
	variable select_id
	variable mass
	variable charge

	variable crystal_size_a
        variable crystal_size_b
        variable crystal_size_c
        variable crystal_size_alpha
        variable crystal_size_beta
        variable crystal_size_gamma

	variable turn

	variable chainvalue
        variable residvalue
        variable residuevalue
        variable elementvalue
        variable atomvalue
        variable chargevalue

	variable chain_select
        variable resid_select
        variable residue_select
        variable element_select
        variable atom_select
        variable charge_select

	variable cmd	
	
	variable style_color_sel
	variable info_style_list
	variable info_color_list
	variable info_sel_list
	variable this_sel_global

	variable info_material_list
	variable color_ID_list

	variable resid_residue_list
	variable residue_atom
	variable residue_count
	variable residue_id
	variable style_color_sel_id
	variable select_files

	variable thesefile

	variable chain_list_select
	variable residue_list_select
	variable chain_id

	variable x_min
	variable y_min
        variable z_min
        variable x_max
        variable y_max
        variable z_max
	variable size_x
	variable size_y
	variable size_z

	set chain_select 0
	set resid_select 0
	set residue_select 0
	set element_select 0
	set atom_select 0
	set charge_select 0

	set x_min 0
	set y_min 0
	set z_min 0
	set x_max 0
	set y_max 0
	set z_max 0
	set size_x 0
	set size_y 0
	set size_z 0
	#empty
	set residue {}
	set atom {}
	set center ""
	set weight {}
	set element {}
	set chain {}
	set resid {}
	set res_num {}
	set mass {}
	set charge {} 
	set center_f {}
	set weight_f {}
	set last_charge {}
	set atom_charge {}
	set residue_count {}
	set single_residue {}
	set single_residue_all {}
	set resid_residue_list {}
	set residue_atom {}
	set residue_id {}

	set style_color_sel_id 0
	set style_color_sel {}
	
	set signelement 0
	set new_molid [molinfo list]
	set select_files {}

	foreach index [$W curselection] {
		lappend select_files $index

		#select id
                set select_id $index

		#get id
		set id [lindex $molid $index]
		set need_to_refresh 1
		foreach val $new_molid {
			if {$val==$id} {
				set need_to_refresh 0
			}
		}
		if {$need_to_refresh==1} {
			set msg "File does not exist, please refresh the list"
			tk_messageBox -title "File name Error" -parent .textview -type ok -message $msg
			return
		}

		#get center
		set atomsel [atomselect $id all]
		set cmd "all"
		set center_sel [atomselect $id all]
		if {[catch {set center_f [measure center $center_sel]}]} {
			set msg "PDB file does not exist"
			tk_messageBox -title "PDB error" -parent .textview -type ok -message $msg
			return
		}
		set number 0
		set centerlength [llength $center_f]
		while {$number<$centerlength} {
			set center_sit_f [lindex $center_f $number]
			set center_sit [format "%10.2f" $center_sit_f]
			append center $center_sit
			incr number
		}

		#get chain
		set command [format "%s get chain" $atomsel]
		set all_chain [eval $command]
		foreach chain_val $all_chain {
			set is_in_chain [lsearch $chain $chain_val]
			if {$is_in_chain==-1} {
				lappend chain $chain_val
			}
		}
		#get resid
#		set command [format "%s get resid" $atomsel]
#                set all_resid [eval $command]
#                set resid [lsort -unique -integer $all_resid]
		#get residue
#		set command [format "%s get resname" $atomsel]
#		set all_residue [eval $command]
#		set residueonly [lsort -unique $all_residue]
#		foreach var $residueonly {
#			if {$var!=""&&$var!="****"} {
#				set res_sel [atomselect $id "resname $var"]
#				set res_all [lsort -unique [$res_sel get resid]]
#				set res_length [llength $res_all]
#				set cate_num [format "%s/%d" $var $res_length]
#                        	lappend residue $cate_num
#			}
#                }

		#get residue
		set chain_fir [lindex $chain 0]
		set chain_list_select $chain_fir
		set chain_id $chain_fir
		set chain_sel [atomselect $id "chain '$chain_fir'"]
		set resid_all_fir [$chain_sel get resid]
                set residue_all_fir [$chain_sel get resname]

		set number 0
                foreach var $resid_all_fir {
			set residue_fir_single [lindex $residue_all_fir $number]
			set resid_residue [format "%d %s" $var $residue_fir_single]
			lappend resid_residue_list $resid_residue
			incr number
                }
		set resid_residue_list [lsort -dictionary -unique $resid_residue_list]

		#get atom initialize
		set resid_residue_fir [lindex $resid_residue_list 0]
		set resid_residue_fir_list [split $resid_residue_fir " "]
		set resid_fir [lindex $resid_residue_fir_list 0]
		set residue_list_select $resid_fir
		set atom_sel [atomselect $id "chain '$chain_fir' and resid '$resid_fir'"]
                #get atom name
                set atom_name_list [$atom_sel get name]
		set atom_number_from_zero [$atom_sel list]
		set atom_number {}
		foreach var $atom_number_from_zero {
			lappend atom_number [expr $var + 1]
		}
		set number 0
                foreach var $atom_number {
                        set atom_name [lindex $atom_name_list $number]
                        incr number
                        set number_name [format "%d %s" $var $atom_name]
                        lappend residue_atom $number_name
                }

		#get residue count
		set flag 0
		set number 0
		set command [format "%s get resname" $atomsel]
		set all_residue [eval $command]
		set single_residue [lsort -unique $all_residue]

		set all_resid_command [format "%s get resid" $atomsel]
		set all_resid [eval $all_resid_command]
#		puts "$all_resid"
		foreach var $all_resid {
			set residue_single [lindex $all_residue $number]
			incr number
			if {$var!=$flag} {
				set flag $var
				lappend single_residue_all $residue_single
			}
		}
	
#		set single_residue [lsort -unique $single_residue_all]

#		puts "$single_residue"

#		puts "$all_residue"
#		puts "haha $$single_residue"
		foreach var1 $single_residue {
			set number 0
			foreach var2 $single_residue_all {
				if {$var1==$var2} {
					incr number
				}
			}
			set residue_number [format "%s %d" $var1 $number]
			lappend residue_count $residue_number
		}

		#get res_location
		set res_loc_fir [lindex $residue_count 0]
		set res_loc_fir_list [split $res_loc_fir " "]
		set res_select_fir [lindex $res_loc_fir_list 0]
		set sel [atomselect $id "resname '$res_select_fir'"]
                set residue_id_all [$sel get resid]
                set residue_id [lsort -integer -unique $residue_id_all]

		#get element
		if {$signelement==0} {
			set command [format "%s get element" $atomsel]
		        set all_element [eval $command]
		        set elementonly [lsort -unique $all_element]
		        foreach var1 $elementonly {
		                set number 0 
		                foreach var2 $all_element {
		                        set judge [string equal $var1 $var2]
		                        if {$judge} {
		                                incr number
		                        }
		                }
		                set element_num [format "%s %d" $var1 $number]
		                lappend element $element_num
		        }
			#get mass
			set command [format "%s get mass" $atomsel]
		        set all_mass [eval $command]
		        set count 0
		        set length_mass [llength $all_element]
		        while {$count<$length_mass} {
		                set element_part [lindex $all_element $count]
		                set mass_part [lindex $all_mass $count]
		                incr count
		                lappend element_mass $element_part
		                lappend element_mass $mass_part
		        }
		} else {
#			set msg "There are no elements in your pdb file"
#			tk_messageBox -title "PDB Error" -parent .textview -type ok -message $msg
		}
		#get atom
		set command [format "%s get name" $atomsel]
		set all_atom [eval $command]
		set atomonly [lsort -unique $all_atom]
		foreach var1 $atomonly {
			set number 0
			foreach var2 $all_atom {
				set is_equal [string equal $var1 $var2]
				if {$is_equal} {
					incr number
				}
			}
			set atomnum [format "%s %d" $var1 $number]
			lappend atom $atomnum
		}
		#get charge
		set count 0
                set atom_length [llength $all_atom]
                while {$count<$atom_length} {
	                set atom_part [lindex $all_atom $count]
                        set charge_part [lindex $last_charge $count]
                        incr count
                        lappend atom_charge $atom_part
                        lappend atom_charge $charge_part
                }


		#get weight
		set weight_all [$center_sel get mass]
		set weight 0
		foreach wei $weight_all {
			set weight [expr $weight + $wei]
		}
		set weight [format "%.2f" $weight]

		#pbc            
        	set pbcsit [molinfo $id get {a b c alpha beta gamma}]
		set crystal_size_a [lindex $pbcsit 0]
		set crystal_size_a [format "%.2f" $crystal_size_a]
		set crystal_size_b [lindex $pbcsit 1]
		set crystal_size_b [format "%.2f" $crystal_size_b]
		set crystal_size_c [lindex $pbcsit 2]
		set crystal_size_c [format "%.2f" $crystal_size_c]
		set crystal_size_alpha [lindex $pbcsit 3]
		set crystal_size_alpha [format "%.2f" $crystal_size_alpha]
		set crystal_size_beta [lindex $pbcsit 4]
		set crystal_size_beta [format "%.2f" $crystal_size_beta]
		set crystal_size_gamma [lindex $pbcsit 5]
		set crystal_size_gamma [format "%.2f" $crystal_size_gamma]

		#pbc box
		set judge $turn
		if {$judge} {
			::Molcontrl::turnon		
		} else {
			::Molcontrl::turnoff
		}

		#get representations
		set information_list [mol list $id]
		set information_list_length [llength $information_list]
		set information_index 0
		set info_style_list {}
		set info_color_list {}
		set info_sel_list {}
		set style_color_sel {}
		set color_ID_list {}
		set info_next_num 0
		while {$information_index<$information_list_length} {
			set info_content [lindex $information_list $information_index]
			set is_method 0
			set is_rep 0
			set is_sel 0

			set is_method [string equal $info_content "method:"]
			set is_rep [string equal $info_content "Representation:"]
			set is_sel [string equal $info_content "Selection:"]
			if {$is_method==1} {
				set info_style [lindex $information_list [expr $information_index + 1]]
				set is_colorid 0
				set is_sec_str 0
				set is_colorid [string equal $info_style "ColorID"]
				if {$is_colorid==0} {
					lappend info_color_list $info_style
					lappend color_ID_list ""
				}
				if {$is_colorid==1} {
					set colorID_num [lindex $information_list [expr $information_index + 2]]
					lappend info_color_list $info_style
					lappend color_ID_list $colorID_num
				}
				incr info_next_num
			}
			if {$is_rep==1} {
				set info_color [lindex $information_list [expr $information_index + 1]]
				lappend info_style_list $info_color
			}
			if {$is_sel==1} {
				set info_sel [lindex $information_list [expr $information_index + 1]]
				set info_next_num_str [format "%d:" $info_next_num]
				set if_next [string equal $info_sel $info_next_num_str]

				set info_sel_single {}
				while {$if_next==0} {
					lappend info_sel_single $info_sel
					incr information_index
					if {$information_index>=$information_list_length} {
						break
					}
					set info_sel [lindex $information_list [expr $information_index + 1]]
					set if_next [string equal $info_sel $info_next_num_str]
				}
				set info_sel_list_single ""
				foreach var $info_sel_single {
					append info_sel_list_single " "
					append info_sel_list_single $var
				}
				lappend info_sel_list $info_sel_list_single
			}
			incr information_index
		} 
		set number 0
#		set info_material_list {}
		foreach var $info_style_list {
			set this_style_info_list [list $var]
			set this_color_info [lindex $info_color_list $number]
			set this_color_info_list [list $this_color_info]
			set this_color_id [lindex $color_ID_list $number]
			set this_color_and_id [format "%s %s" $this_color_info $this_color_id]
			set this_color_and_id_list [list $this_color_and_id]
			set this_sel_info [lindex $info_sel_list $number]
			set this_sel_info_list [list $this_sel_info]

			set single_info [format "%s %s %s" $this_style_info_list $this_color_and_id_list $this_sel_info_list]
			lappend style_color_sel $single_info
	
			incr number
		}
#		puts "$number"
#		puts "$info_style_list"
#		puts "$info_material_list"
		set info_material_list {}
		set number 0
		set material_length [llength $info_style_list]
		while {$number<$material_length} {
			set material_command [format "molinfo %d get {{rep %d} {material %d}}" $id $number $number]
			set this_material [eval $material_command]
			lappend info_material_list [lindex $this_material 1]
			incr number
		}

		# minx miny minz maxx maxy maxz
		set sel [atomselect $id all]
		set minmax_list [measure minmax $sel]
		set min_list [lindex $minmax_list 0]
		set max_list [lindex $minmax_list 1]

		set x_min_f [lindex $min_list 0]
		set x_min [format "%.2f" $x_min_f]
		set y_min_f [lindex $min_list 1]
		set y_min [format "%.2f" $y_min_f]
		set z_min_f [lindex $min_list 2]
		set z_min [format "%.2f" $z_min_f]

		set x_max_f [lindex $max_list 0]
		set x_max [format "%.2f" $x_max_f]
		set y_max_f [lindex $max_list 1]
		set y_max [format "%.2f" $y_max_f]
		set z_max_f [lindex $max_list 2]
		set z_max [format "%.2f" $z_max_f]

		set size_x_f [expr $x_max - $x_min]
		set size_x [format "%.2f" $size_x_f]
		set size_y_f [expr $y_max - $y_min]
		set size_y [format "%.2f" $size_y_f]
		set size_z_f [expr $z_max - $z_min]
		set size_z [format "%.2f" $size_z_f]

		#clear
		::Molcontrl::clear
	}
}
#clear
proc ::Molcontrl::clear {} {
	variable chainvalue
        variable residvalue
        variable residuevalue
        variable elementvalue
        variable atomvalue
        variable chargevalue
	
	label delete Atoms all
	set chainvalue 0
        set residvalue 0
        set residuevalue 0
        set elementvalue 0
        set atomvalue 0
        set chargevalue	0
	
}
#need disable
proc ::Molcontrl::need_disable {} {
        .textview.all.first.moving.shift.rotate.rot_ref.ref.reference.user_choice.x.x_entry configure -state disable
        .textview.all.first.moving.shift.rotate.rot_ref.ref.reference.user_choice.y.y_entry configure -state disable
        .textview.all.first.moving.shift.rotate.rot_ref.ref.reference.user_choice.z.z_entry configure -state disable
}
#need able
proc ::Molcontrl::need_able {} {
	.textview.all.first.moving.shift.rotate.rot_ref.ref.reference.user_choice.x.x_entry configure -state normal
	.textview.all.first.moving.shift.rotate.rot_ref.ref.reference.user_choice.y.y_entry configure -state normal
	.textview.all.first.moving.shift.rotate.rot_ref.ref.reference.user_choice.z.z_entry configure -state normal
}
#set color
proc ::Molcontrl::color {} {
	variable color_type
	variable draw_type
	variable material_type
	variable color_ID
	variable molid
	variable select_id
	variable cmd
	variable need_to_show
	variable is_cmd
	variable is_select
	variable rep_sel
	variable all_mol
	variable style_color_sel
	variable style_color_sel_id
	variable this_sel_global
        variable info_color_list
        variable info_style_list
	variable info_sel_list
	variable info_material_list
	variable color_ID_list
	variable index_out

	if {$cmd==""} {
		return
	}
	if {$all_mol==0} {
		return
	}

	set new_molid [molinfo list]
        set id [lindex $molid $select_id]
        set need_to_refresh 1
        foreach val $new_molid {
                if {$val==$id} {
                        set need_to_refresh 0
                }
        }
        if {$need_to_refresh==1} {
                set msg "File does not exist, please refresh the list"
                tk_messageBox -title "File name Error" -parent .textview -type ok -message $msg
                return
        }

	::Molcontrl::ref_sty_col_sel
	if {$style_color_sel==""} {
		return
	}
	if {$index_out==1} {
		return
	}

#	if {$color_type=="colorID"}
	set flag [string equal $color_type "ColorID"]
#	set style_color_sel {}

#	set x [colorinfo colors]
#	puts "$x"
#	set y [lindex $x 0]
#	puts "$y"
	set id [lindex $molid $select_id]
	set is_volume [string equal $color_type "Volume"]
	if {$is_volume==1} {
		set  color_type "Volume - 1"
	}
	set is_X [string equal $color_type "X"]
	if {$is_X==1} {
		set  color_type "PosX"
	}
	set is_Y [string equal $color_type "Y"]
	if {$is_Y==1} {
		set color_type "PosY"
	}
	set is_Z [string equal $color_type "Z"]
	if {$is_Z==1} {
		set color_type "PosZ"
	}
	set is_Radial [string equal $color_type "Radial"]
	if {$is_Radial==1} {
		set color_type "Pos"
	}
	set is_physical [string equal $color_type "Physical Time"]
	if {$is_physical==1} {
		set color_type "PhysicalTime"
	}
	set is_structure [string equal $color_type "Secondary Structure"]
	if {$is_structure==1} {
		set color_type "Structure"
	}

	if {$flag==0} {
		.textview.all.first.structure.all.highlight.draw.color.colorid configure -state disabled
#		set id [lindex $molid $select_id]
#		mol default color $color_type
#		mol delrep $id
		if {$is_cmd==1} {
			mol modselect $rep_sel $id $cmd
			lset info_sel_list $style_color_sel_id $cmd
			set is_cmd 0
		}
		if {$is_select==1} {
			set my_select [lindex $info_sel_list $style_color_sel_id]
			mol modselect $rep_sel $id $my_select
			set is_select 0
		}
		mol modcolor $rep_sel $id $color_type
		mol modstyle $rep_sel $id $draw_type
		mol modmaterial $rep_sel $id $material_type
#		mol addrep $id
		lset info_color_list $style_color_sel_id $color_type
	}

	if {$flag==1} {
		.textview.all.first.structure.all.highlight.draw.color.colorid configure -state readonly

		set color_list [split $color_ID " "]
		set this_color [lindex $color_list 0]
#		puts "$this_color"

#		set id [lindex $molid $select_id]
#		mol delrep $id
		if {$is_cmd==1} {
                        mol modselect $rep_sel $id $cmd
			lset info_sel_list $style_color_sel_id $cmd
			set is_cmd 0
                }
                if {$is_select==1} {
			set my_select [lindex $info_sel_list $style_color_sel_id]
                        mol modselect $rep_sel $id $my_select
			set is_select 0
                }
		mol modcolor $rep_sel $id ColorID $this_color
		mol modstyle $rep_sel $id $draw_type
		mol modmaterial $rep_sel $id $material_type
#		mol addrep $id
#		mol default color ColorID [$this_color]
#		mol default representation $draw_type
		set with_colorid [format "ColorID %d" $this_color]
		lset info_color_list $style_color_sel_id "ColorID"
		lset color_ID_list $style_color_sel_id $this_color
	}

	lset info_style_list $style_color_sel_id $draw_type
	lset info_material_list $style_color_sel_id $material_type

	::Molcontrl::ref_sty_col_sel
#	puts "$flag"
#	puts "$color_type"
#	puts "haha"
}
#create rep
proc ::Molcontrl::create_rep {} {
        variable info_color_list
        variable info_style_list
        variable info_material_list
        variable info_sel_list
	variable color_ID_list
        variable style_color_sel_id
        variable molid
        variable select_id
	variable all_mol

	if {$all_mol==0} {
		return
	}

	set new_molid [molinfo list]
	set id [lindex $molid $select_id]
	set need_to_refresh 1
	foreach val $new_molid {
		if {$val==$id} {
			set need_to_refresh 0
		}
	}
	if {$need_to_refresh==1} {
		set msg "File does not exist, please refresh the list"
		tk_messageBox -title "File name Error" -parent .textview -type ok -message $msg
		return
	}

        set new_rep_style [lindex $info_style_list $style_color_sel_id]
        set new_rep_iscolorid [lindex $info_color_list $style_color_sel_id]
	set is_colorID [string equal $new_rep_iscolorid "ColorID"]
	if {$is_colorID==1} {
		set new_colorid [lindex $color_ID_list $style_color_sel_id]
		set new_colorid_list [split $new_colorid " "]
		set new_colorid_num [lindex $new_colorid_list 0]
		set new_rep_color [format "%s %d" $new_rep_iscolorid $new_colorid_num]
	}
	if {$is_colorID==0} {
		set new_rep_color $new_rep_iscolorid
	}
        set new_rep_sel [lindex $info_sel_list $style_color_sel_id]
        set new_rep_material [lindex $info_material_list $style_color_sel_id]

        mol selection $new_rep_sel
        mol color $new_rep_color
        mol representation $new_rep_style
        mol material $new_rep_material
        mol addrep $id

        ::Molcontrl::ref_sty_col_sel_list
}
#delete rep
proc ::Molcontrl::delete_rep {} {
        variable style_color_sel_id
	variable style_color_sel
        variable molid
        variable select_id
	variable all_mol

	if {$all_mol==0} {
		return
	}

        set id [lindex $molid $select_id]
	set new_molid [molinfo list]
	set need_to_refresh 1
	foreach val $new_molid {
		if {$val==$id} {
			set need_to_refresh 0
		}
	}
	if {$need_to_refresh==1} {
		set msg "File does not exist, please refresh the list"
		tk_messageBox -title "File name Error" -parent .textview -type ok -message $msg
		return
	}

	set style_color_sel_length [llength $style_color_sel]
	if {$style_color_sel_length==0} {
		return
	}

	if {$style_color_sel_id>=$style_color_sel_length} {
		set style_color_sel_id [expr $style_color_sel_length - 1]
        	mol delrep $style_color_sel_id $id
        	::Molcontrl::ref_sty_col_sel_list
		set minus [expr $style_color_sel_id - 1]
		set style_color_sel_id $minus
		if {$style_color_sel_id<0} {
                        set style_color_sel_id 0
                }
	} else {
        	mol delrep $style_color_sel_id $id
        	::Molcontrl::ref_sty_col_sel_list
		set style_color_sel_length [llength $style_color_sel]
		set style_color_sel_id [expr $style_color_sel_length - 1]
		if {$style_color_sel_id<0} {
			set style_color_sel_id 0
		}
	}
}
#get highlight information
proc ::Molcontrl::get_highlight_info {W} {
	variable info_style_list
	variable info_color_list
	variable info_sel_list
	variable info_material_list
	variable style_color_sel
	variable cmd
	
	variable color_type
	variable draw_type
	variable color_ID
	variable color_ID_list
	variable material_type

	variable rep_sel
	variable style_color_sel_id

	variable is_top

	foreach index [$W curselection] {
#		set x [lindex $style_color_sel $index]
		if {$is_top==1} {
			set rep_sel 0
			set style_color_sel_id 0
		}
		if {$is_top!=1} {
			set rep_sel $index
			set style_color_sel_id $index
		}

		set choose_style_method [lindex $info_style_list $index]
		set choose_color_method [lindex $info_color_list $index]
		set choose_sel_method [lindex $info_sel_list $index]
		set choose_material_method [lindex $info_material_list $index]
		set choose_colorid_method [lindex $color_ID_list $index]
		set cmd $choose_sel_method
		
		set color_method_list [split $choose_color_method " "]
		set color_method_fir [lindex $color_method_list 0]

		set is_colorid [string equal $color_method_fir "ColorID"]
		if {$is_colorid==1} {
			.textview.all.first.structure.all.highlight.draw.color.colorid configure -state readonly
			set color_type $color_method_fir
			set color_ID $choose_colorid_method
			set draw_type $choose_style_method
			set material_type $choose_material_method
		}
		if {$is_colorid==0} {
			.textview.all.first.structure.all.highlight.draw.color.colorid configure -state disabled
			set color_type $choose_color_method
			set draw_type $choose_style_method
			set material_type $choose_material_method
		}
	}
	::Molcontrl::show_center
	::Molcontrl::show_weight
}
#refresh style color sel list
proc ::Molcontrl::ref_sty_col_sel_list {} {
	variable molid
	variable select_id
	variable info_style_list
	variable info_color_list
	variable info_sel_list
	variable info_material_list
	variable style_color_sel
	variable color_ID_list
	
	set id [lindex $molid $select_id]

	#get representations
	set information_list [mol list $id]
	set information_list_length [llength $information_list]
	set information_index 0
	set info_style_list {}
	set info_color_list {}
	set info_sel_list {}
	set style_color_sel {}
	set color_ID_list {}
	set info_next_num 0
	while {$information_index<$information_list_length} {
		set info_content [lindex $information_list $information_index]
		set is_method 0
		set is_rep 0
		set is_sel 0

		set is_method [string equal $info_content "method:"]
		set is_rep [string equal $info_content "Representation:"]
		set is_sel [string equal $info_content "Selection:"]
		if {$is_method==1} {
			set info_style [lindex $information_list [expr $information_index + 1]]
			set is_colorid 0
			set is_colorid [string equal $info_style "ColorID"]
			if {$is_colorid==0} {
				lappend info_color_list $info_style
				lappend color_ID_list ""
			}
			if {$is_colorid==1} {
				set colorID_num [lindex $information_list [expr $information_index + 2]]
				lappend info_color_list $info_style
				lappend color_ID_list $colorID_num
			}
			incr info_next_num
		}
		if {$is_rep==1} {
			set info_color [lindex $information_list [expr $information_index + 1]]
			lappend info_style_list $info_color
		}
		if {$is_sel==1} {
			set info_sel [lindex $information_list [expr $information_index + 1]]
			set info_next_num_str [format "%d:" $info_next_num]
			set if_next [string equal $info_sel $info_next_num_str]

			set info_sel_single {}
			while {$if_next==0} {
				lappend info_sel_single $info_sel
				incr information_index
				if {$information_index>=$information_list_length} {
					break
				}
				set info_sel [lindex $information_list [expr $information_index + 1]]
				set if_next [string equal $info_sel $info_next_num_str]
			}
			set info_sel_list_single ""
			foreach var $info_sel_single {
				append info_sel_list_single $var
				append info_sel_list_single " "
			}
			lappend info_sel_list $info_sel_list_single
		}
		incr information_index
	}
	set number 0
	foreach var $info_style_list {
		set this_style_info_list [list $var]
		set this_color_info [lindex $info_color_list $number]
		set this_colorid [lindex $color_ID_list $number]
		set this_color_id_info [format "%s %s" $this_color_info $this_colorid]
		set this_color_id_info_list [list $this_color_id_info]
		set this_sel_info [lindex $info_sel_list $number]
		set this_sel_info_list [list $this_sel_info]
		set this_style_color_sel [format "%s %s %s" $this_style_info_list $this_color_id_info_list $this_sel_info_list]
		lappend style_color_sel $this_style_color_sel
                 
		incr number
	}

	set info_material_list {}
	set number 0
	set material_length [llength $info_style_list]
	while {$number<$material_length} {
		set material_command [format "molinfo %d get {{rep %d} {material %d}}" $id $number $number]
		set this_material [eval $material_command]
		lappend info_material_list [lindex $this_material 1]
		incr number
	}
}
#residue atom charge
proc ::Molcontrl::is_res_ato_cha {} {
	variable is_residue
	variable is_atom
	variable is_charge
	variable label_type
	variable style_color_sel_id

	set is_residue [string equal $label_type "residue"]
        set is_atom [string equal $label_type "atom"]
        set is_charge [string equal $label_type "charge"]
}
#show sel label
proc ::Molcontrl::show_sel_label {} {
	variable molid
	variable select_id
	variable style_color_sel_id
	variable label_type
	variable info_sel_list
	variable is_residue
	variable is_atom
	variable is_charge

	set id [lindex $molid $select_id]
	set this_sel [lindex $info_sel_list $style_color_sel_id]

	set sel [atomselect $id $this_sel]

	if {$is_residue==1} {
		set number 0
		foreach var [$sel list] {
			label add Atoms $id/$var
			label textformat Atoms $number %r
			#label textoffset Atoms $number { -0.11 -0.0055 }
			incr number
		}
	}

	if {$is_atom==1} {
		set number 0
                foreach var [$sel list] {
                        label add Atoms $id/$var
                        label textformat Atoms $number %1i
                        #label textoffset Atoms $number { -0.11 -0.0055 }
                        incr number
                }

	}

	if {$is_charge==1} {
		set number 0
                foreach var [$sel list] {
                        label add Atoms $id/$var
                        label textformat Atoms $number %q
                        #label textoffset Atoms $number { -0.11 -0.0055 }
                        incr number
                }
	}
}
#delete sel label
proc ::Molcontrl::show_delete_label {} {
        variable molid
        variable select_id
        variable style_color_sel_id
        variable label_type
        variable info_sel_list
        variable is_residue
        variable is_atom
        variable is_charge

        set id [lindex $molid $select_id]
        set this_sel [lindex $info_sel_list $style_color_sel_id]

        set sel [atomselect $id $this_sel]

        if {$is_residue==1} {
                set number 0
                foreach var [$sel list] {
                        label delete Atoms $id/$var
                        label textformat Atoms $number %r
                        #label textoffset Atoms $number { -0.11 -0.0055 }
                        incr number
                }
        }

        if {$is_atom==1} {
                set number 0
                foreach var [$sel list] {
                        label delete Atoms $id/$var
                        label textformat Atoms $number %1i
                        #label textoffset Atoms $number { -0.11 -0.0055 }
                        incr number
                }

        }

        if {$is_charge==1} {
                set number 0
                foreach var [$sel list] {
                        label delete Atoms $id/$var
                        label textformat Atoms $number %q
                        #label textoffset Atoms $number { -0.11 -0.0055 }
                        incr number
                }
        }
}
#show or not show mol
proc ::Molcontrl::mol_show_off {} {
	variable style_color_sel_id
	variable molid
	variable select_id

	set id [lindex $molid $select_id]
	mol showrep $id $style_color_sel_id off
#	.textview.all.first.structure.highlight.draw.rep.scrollbar.box configure -font {Times 12 italic}
}
proc ::Molcontrl::mol_show_on {} {
	variable style_color_sel_id
	variable molid
	variable select_id

	set id [lindex $molid $select_id]
	mol showrep $id $style_color_sel_id on
#	.textview.all.first.structure.highlight.draw.rep.scrollbar.box configure -font {Times 12 normal}
}
#refresh style color sel
proc ::Molcontrl::ref_sty_col_sel {} {
	variable style_color_sel
	variable style_color_sel_id
	variable info_color_list
	variable info_style_list
	variable info_sel_list
	variable color_ID_list
	variable index_out

	set this_style [lindex $info_style_list $style_color_sel_id]
	set this_style_list [list $this_style]
	set this_color [lindex $info_color_list $style_color_sel_id]
	set this_color_list [list $this_color]
	set this_color_id [lindex $color_ID_list $style_color_sel_id]
	set color_and_id [format "%s %s" $this_color $this_color_id]
	set color_and_id_list [list $color_and_id]
	set this_sel [lindex $info_sel_list $style_color_sel_id]
	set this_sel_list [list $this_sel]

	if {$this_color=="ColorID"} {	
		set single_info [format "%s %s %s" $this_style_list $color_and_id_list $this_sel_list]
	} else {
		set single_info [format "%s %s %s" $this_style_list $this_color_list $this_sel_list]
	}

	if {$style_color_sel==""} {
		return
	}
	if {[catch {lset style_color_sel $style_color_sel_id $single_info}]} {
		set index_out 1
		return
	} else {
		set index_out 0
	}
}
#show select chain
proc ::Molcontrl::show_select_chain {W} {
	variable chain
	variable chain_list_select
	variable color_type
	variable draw_type
	variable material_type
	variable molid
	variable select_id
	variable rep_sel
	variable color_ID
	variable is_select
	variable style_color_sel
	variable style_color_sel_id
	variable info_color_list
	variable info_style_list
	variable info_material_list
	variable info_sel_list
	variable all_mol
	variable cmd
	variable is_top

	::Molcontrl::ref_sty_col_sel_list
	set style_color_sel_len [llength $style_color_sel]

	if {$style_color_sel_len==0} {
                return
        }
        if {$all_mol==0} {
                return
        }

	if {$style_color_sel_len<=$style_color_sel_id} {
		set msg "Please select a rep"
                tk_messageBox -title "Rep error" -parent .textview -type ok -message $msg
		return
	}

	set new_molid [molinfo list]
        set id [lindex $molid $select_id]
        set need_to_refresh 1
        foreach val $new_molid {
                if {$val==$id} {
                        set need_to_refresh 0
                }
        }
        if {$need_to_refresh==1} {
                #set msg "File does not exist, please refresh the list"
                #tk_messageBox -title "File name Error" -parent .textview -type ok -message $msg
                return
        }
	
	if {$is_top==1} {
		set style_color_sel_id 0
	} 

	foreach index [$W curselection] {
		set is_colorID [lindex $info_color_list $style_color_sel_id]
		set is_colorID_list [split $is_colorID " "]
		set color_type [lindex $is_colorID_list 0]
		set draw_type [lindex $info_style_list $style_color_sel_id]
		set material_type [lindex $info_material_list $style_color_sel_id]

		set need_to_show [lindex $chain $index]
		set chain_list_select [lindex $chain $index]

		set flag [string equal $color_type "ColorID"]

	        if {$flag==0} {
        	        .textview.all.first.structure.all.highlight.draw.color.colorid configure -state disabled
                	set id [lindex $molid $select_id]
                	mol modselect $style_color_sel_id $id "chain '$need_to_show'"
                	mol modcolor $style_color_sel_id $id $color_type
                	mol modstyle $style_color_sel_id $id $draw_type
                	mol modmaterial $style_color_sel_id $id $material_type
        	}

	        if {$flag==1} {
        	        .textview.all.first.structure.all.highlight.draw.color.colorid configure -state readonly
                	set color_list [split $color_ID " "]
                	set this_color [lindex $color_list 0]

	                set id [lindex $molid $select_id]
                	mol modselect $style_color_sel_id $id "chain '$need_to_show'"
                	mol modcolor $style_color_sel_id $id ColorID $this_color
                	mol modstyle $style_color_sel_id $id $draw_type
                	mol modmaterial $style_color_sel_id $id $material_type
        	}

		set is_select 1

		set this_sel_info [format "chain '%s'" $need_to_show]
		lset info_sel_list $style_color_sel_id $this_sel_info
		set cmd $this_sel_info

		::Molcontrl::ref_sty_col_sel
		::Molcontrl::show_center
		::Molcontrl::show_weight
		::Molcontrl::minmax
	}
}
proc ::Molcontrl::show_select_residue {W} {
	variable resid_residue_list
	variable chain
	variable chain_list_select
	variable residue_list_select
	variable color_type
        variable draw_type
        variable material_type
        variable molid
        variable select_id
        variable rep_sel
        variable color_ID
	variable is_select
	variable style_color_sel
	variable style_color_sel_id
        variable info_color_list
        variable info_style_list
	variable info_material_list
	variable info_sel_list
	variable all_mol
	variable cmd
	variable is_top

	::Molcontrl::ref_sty_col_sel_list
        set style_color_sel_len [llength $style_color_sel]

	if {$style_color_sel_len==0} {
                return
        }
        if {$all_mol==0} {
                return
        }

        if {$style_color_sel_len<=$style_color_sel_id} {
		set msg "Please select a rep"
                tk_messageBox -title "Rep error" -parent .textview -type ok -message $msg
                return
        }

	set new_molid [molinfo list]
        set id [lindex $molid $select_id]
        set need_to_refresh 1
        foreach val $new_molid {
                if {$val==$id} {
                        set need_to_refresh 0
                }
        }
        if {$need_to_refresh==1} {
                #set msg "File does not exist, please refresh the list"
                #tk_messageBox -title "File name Error" -parent .textview -type ok -message $msg
                return
        }

	
	if {$is_top==1} {
                set style_color_sel_id 0
        }

	foreach index [$W curselection] {
		set is_colorID [lindex $info_color_list $style_color_sel_id]
                set is_colorID_list [split $is_colorID " "]
                set color_type [lindex $is_colorID_list 0]
                set draw_type [lindex $info_style_list $style_color_sel_id]
		set material_type [lindex $info_material_list $style_color_sel_id]

		set need_to_show_string [lindex $resid_residue_list $index]
		set need_to_show_list [split $need_to_show_string " "]
		set need_to_show [lindex $need_to_show_list 0]
		set residue_list_select [lindex $need_to_show_list 0]

		set flag [string equal $color_type "ColorID"]

                if {$flag==0} {
                        .textview.all.first.structure.all.highlight.draw.color.colorid configure -state disabled
                        set id [lindex $molid $select_id]
			if {[catch {mol modselect $style_color_sel_id $id "chain '$chain_list_select' and resid '$need_to_show'"}]} {
				set msg "Please select chain first"
				tk_messageBox -title "Rep error" -parent .textview -type ok -message $msg
				return
			}
#			mol modselect $style_color_sel_id $id "chain $chain_list_select and resid $need_to_show"
                        mol modcolor $style_color_sel_id $id $color_type
                        mol modstyle $style_color_sel_id $id $draw_type
                        mol modmaterial $style_color_sel_id $id $material_type
                }

                if {$flag==1} {
                        .textview.all.first.structure.all.highlight.draw.color.colorid configure -state readonly
                        set color_list [split $color_ID " "]
                        set this_color [lindex $color_list 0]

                        set id [lindex $molid $select_id]
			if {[catch {mol modselect $style_color_sel_id $id "chain '$chain_list_select' and resid '$need_to_show'"}]} {
                                set msg "Please select chain first"
                                tk_messageBox -title "Rep error" -parent .textview -type ok -message $msg
                                return
                        }
#			mol modselect $style_color_sel_id $id "chain $chain_list_select and resid $need_to_show"
                        mol modcolor $style_color_sel_id $id ColorID $this_color
                        mol modstyle $style_color_sel_id $id $draw_type
                        mol modmaterial $style_color_sel_id $id $material_type
                }
		set is_select 1

                set this_sel_info [format "chain '%s' and resid '%s'" $chain_list_select $need_to_show]
		lset info_sel_list $style_color_sel_id $this_sel_info
		set cmd $this_sel_info

		::Molcontrl::ref_sty_col_sel
		::Molcontrl::show_center
		::Molcontrl::show_weight
		::Molcontrl::minmax
	}
}
proc ::Molcontrl::show_select_residueatom {W} {
	variable residue_atom
	variable chain
	variable chain_list_select
	variable residue_list_select
	variable color_type
        variable draw_type
        variable material_type
        variable molid
        variable select_id
        variable rep_sel
        variable color_ID
	variable is_select
	variable style_color_sel
	variable style_color_sel_id
        variable info_color_list
        variable info_style_list
	variable info_material_list
	variable info_sel_list
	variable all_mol
	variable cmd
	variable is_top

        if {$all_mol==0} {
                return
        }

	set new_molid [molinfo list]
        set id [lindex $molid $select_id]
        set need_to_refresh 1
        foreach val $new_molid {
                if {$val==$id} {
                        set need_to_refresh 0
                }
        }
        if {$need_to_refresh==1} {
                set msg "File does not exist, please refresh the list"
                tk_messageBox -title "File name Error" -parent .textview -type ok -message $msg
                return
        }

	::Molcontrl::ref_sty_col_sel_list
        set style_color_sel_len [llength $style_color_sel]

        if {$style_color_sel_len==0} {
                return
        }

        if {$style_color_sel_len<=$style_color_sel_id} {
                set msg "Please select a rep"
                tk_messageBox -title "Rep error" -parent .textview -type ok -message $msg
                return
        }

	if {$is_top==1} {
                set style_color_sel_id 0
        }
	
	foreach index [$W curselection] {
		set is_colorID [lindex $info_color_list $style_color_sel_id]
                set is_colorID_list [split $is_colorID " "]
                set color_type [lindex $is_colorID_list 0]
                set draw_type [lindex $info_style_list $style_color_sel_id]
		set material_type [lindex $info_material_list $style_color_sel_id]

		set need_to_show_string [lindex $residue_atom $index]
		set need_to_show_list [split $need_to_show_string " "]
		set need_to_show [lindex $need_to_show_list 0]

		set flag [string equal $color_type "ColorID"]

                if {$flag==0} {
                        .textview.all.first.structure.all.highlight.draw.color.colorid configure -state disabled
                        set id [lindex $molid $select_id]
			if {[catch {mol modselect $style_color_sel_id $id "chain '$chain_list_select' and resid '$residue_list_select' and index [expr $need_to_show - 1]"}]} {
                                set msg "Please select chain and residue first"
                                tk_messageBox -title "Rep error" -parent .textview -type ok -message $msg
                                return
                        }

#			mol modselect $style_color_sel_id $id "chain $chain_list_select and resid $residue_list_select and index [expr $need_to_show - 1]"
                        mol modcolor $style_color_sel_id $id $color_type
                        mol modstyle $style_color_sel_id $id $draw_type
                        mol modmaterial $style_color_sel_id $id $material_type
                }

                if {$flag==1} {
                        .textview.all.first.structure.all.highlight.draw.color.colorid configure -state readonly
                        set color_list [split $color_ID " "]
                        set this_color [lindex $color_list 0]

                        set id [lindex $molid $select_id]
			if {[catch {mol modselect $style_color_sel_id $id "chain '$chain_list_select' and resid '$residue_list_select' and index [expr $need_to_show - 1]"}]} {
                                set msg "Please select chain and residue first"
                                tk_messageBox -title "Rep error" -parent .textview -type ok -message $msg
                                return
                        }

#			mol modselect $style_color_sel_id $id "chain $chain_list_select and resid $residue_list_select and index [expr $need_to_show - 1]"
                        mol modcolor $style_color_sel_id $id ColorID $this_color
                        mol modstyle $style_color_sel_id $id $draw_type
                        mol modmaterial $style_color_sel_id $id $material_type
                }
		set is_select 1
		
		set this_index [expr $need_to_show - 1]
                set this_sel_info [format "chain '%s' and resid '%s' and index %d" $chain_list_select $residue_list_select $this_index]
		lset info_sel_list $style_color_sel_id $this_sel_info
		set cmd $this_sel_info

		::Molcontrl::ref_sty_col_sel
		::Molcontrl::show_center
		::Molcontrl::show_weight
		::Molcontrl::minmax
        }
}
proc ::Molcontrl::show_select_residueall {W} {
	variable residue_count
	variable color_type
        variable draw_type
        variable material_type
        variable molid
        variable select_id
        variable rep_sel
        variable color_ID
	variable is_select
	variable style_color_sel
	variable style_color_sel_id
        variable info_color_list
        variable info_style_list
	variable info_material_list
	variable info_sel_list
	variable all_mol
	variable cmd
	variable is_top

	::Molcontrl::ref_sty_col_sel_list
        set style_color_sel_len [llength $style_color_sel]

	if {$style_color_sel_len==0} {
                return
        }
        if {$all_mol==0} {
                return
        }

        if {$style_color_sel_len<=$style_color_sel_id} {
		set msg "Please select a rep"
                tk_messageBox -title "Rep error" -parent .textview -type ok -message $msg
                return
        }

	set new_molid [molinfo list]
        set id [lindex $molid $select_id]
        set need_to_refresh 1
        foreach val $new_molid {
                if {$val==$id} {
                        set need_to_refresh 0
                }
        }
        if {$need_to_refresh==1} {
                #set msg "File does not exist, please refresh the list"
                #tk_messageBox -title "File name Error" -parent .textview -type ok -message $msg
                return
        }

	if {$is_top==1} {
                set style_color_sel_id 0
        }

	foreach index [$W curselection] {
		set is_colorID [lindex $info_color_list $style_color_sel_id]
                set is_colorID_list [split $is_colorID " "]
                set color_type [lindex $is_colorID_list 0]
                set draw_type [lindex $info_style_list $style_color_sel_id]
		set material_type [lindex $info_material_list $style_color_sel_id]

		set need_to_show_string [lindex $residue_count $index]
		set need_to_show_list [split $need_to_show_string " "]
		set need_to_show [lindex $need_to_show_list 0]
		
		set flag [string equal $color_type "ColorID"]

                if {$flag==0} {
                        .textview.all.first.structure.all.highlight.draw.color.colorid configure -state disabled
                        set id [lindex $molid $select_id]
                        mol modselect $style_color_sel_id $id "resname '$need_to_show'"
                        mol modcolor $style_color_sel_id $id $color_type
                        mol modstyle $style_color_sel_id $id $draw_type
                        mol modmaterial $style_color_sel_id $id $material_type
                }

                if {$flag==1} {
                        .textview.all.first.structure.all.highlight.draw.color.colorid configure -state readonly
                        set color_list [split $color_ID " "]
                        set this_color [lindex $color_list 0]

                        set id [lindex $molid $select_id]
                        mol modselect $style_color_sel_id $id "resname '$need_to_show'"
                        mol modcolor $style_color_sel_id $id ColorID $this_color
                        mol modstyle $style_color_sel_id $id $draw_type
                        mol modmaterial $style_color_sel_id $id $material_type
                }
		set is_select 1

                set this_sel_info [format "resname '%s'" $need_to_show]
		lset info_sel_list $style_color_sel_id $this_sel_info
		set cmd $this_sel_info

		::Molcontrl::ref_sty_col_sel
		::Molcontrl::show_center
		::Molcontrl::show_weight
		::Molcontrl::minmax
	}
}
proc ::Molcontrl::show_select_residueid {W} {
	variable residue_id
        variable color_type
        variable draw_type
        variable material_type
        variable molid
        variable select_id
        variable rep_sel
        variable color_ID
        variable is_select
        variable style_color_sel
        variable style_color_sel_id
        variable info_color_list
        variable info_style_list
        variable info_material_list
        variable info_sel_list
	variable all_mol
	variable cmd
	variable is_top
	
        if {$all_mol==0} {
                return
        }

	set new_molid [molinfo list]
        set id [lindex $molid $select_id]
        set need_to_refresh 1
        foreach val $new_molid {
                if {$val==$id} {
                        set need_to_refresh 0
                }
        }
        if {$need_to_refresh==1} {
                set msg "File does not exist, please refresh the list"
                tk_messageBox -title "File name Error" -parent .textview -type ok -message $msg
                return
        }

	::Molcontrl::ref_sty_col_sel_list
        set style_color_sel_len [llength $style_color_sel]

        if {$style_color_sel_len==0} {
                return
        }

        if {$style_color_sel_len<=$style_color_sel_id} {
                set msg "Please select a rep"
                tk_messageBox -title "Rep error" -parent .textview -type ok -message $msg
                return
        }

	if {$is_top==1} {
                set style_color_sel_id 0
        }

	foreach index [$W curselection] {
		set is_colorID [lindex $info_color_list $style_color_sel_id]
                set is_colorID_list [split $is_colorID " "]
                set color_type [lindex $is_colorID_list 0]
                set draw_type [lindex $info_style_list $style_color_sel_id]
                set material_type [lindex $info_material_list $style_color_sel_id]

                set need_to_show [lindex $residue_id $index]

                set flag [string equal $color_type "ColorID"]

                if {$flag==0} {
                        .textview.all.first.structure.all.highlight.draw.color.colorid configure -state disabled                  
                        set id [lindex $molid $select_id]
                        mol modselect $style_color_sel_id $id "resid '$need_to_show'"
                        mol modcolor $style_color_sel_id $id $color_type
                        mol modstyle $style_color_sel_id $id $draw_type
                        mol modmaterial $style_color_sel_id $id $material_type
                }

                if {$flag==1} {
                        .textview.all.first.structure.all.highlight.draw.color.colorid configure -state readonly
                        set color_list [split $color_ID " "]
                        set this_color [lindex $color_list 0]

                        set id [lindex $molid $select_id]
                        mol modselect $style_color_sel_id $id "resid '$need_to_show'"
                        mol modcolor $style_color_sel_id $id ColorID $this_color
                        mol modstyle $style_color_sel_id $id $draw_type
                        mol modmaterial $style_color_sel_id $id $material_type
                }
                set is_select 1

                set this_sel_info [format "resid '%s'" $need_to_show]
                lset info_sel_list $style_color_sel_id $this_sel_info
		set cmd $this_sel_info

                ::Molcontrl::ref_sty_col_sel
		::Molcontrl::show_center
		::Molcontrl::show_weight
		::Molcontrl::minmax
        }
}
proc ::Molcontrl::show_select_element {W} {
	variable element
	variable color_type
        variable draw_type
        variable material_type
        variable molid
        variable select_id
        variable rep_sel
        variable color_ID
	variable is_select
	variable style_color_sel
	variable style_color_sel_id
        variable info_color_list
        variable info_style_list
	variable info_material_list
	variable info_sel_list
	variable all_mol

	set style_color_sel_len [llength $style_color_sel]
        if {$style_color_sel_len==0} {
                return
        }
	if {$all_mol==0} {
                return
        }

	set new_molid [molinfo list]
        set id [lindex $molid $select_id]
        set need_to_refresh 1
        foreach val $new_molid {
                if {$val==$id} {
                        set need_to_refresh 0
                }
        }
        if {$need_to_refresh==1} {
                set msg "File does not exist, please refresh the list"
                tk_messageBox -title "File name Error" -parent .textview -type ok -message $msg
                return
        }

	foreach index [$W curselection] {
		set is_colorID [lindex $info_color_list $style_color_sel_id]
                set is_colorID_list [split $is_colorID " "]
                set color_type [lindex $is_colorID_list 0]
                set draw_type [lindex $info_style_list $style_color_sel_id]
		set material_type [lindex $info_material_list $style_color_sel_id]

		set need_to_show_string [lindex $element $index]
		set need_to_show_list [split $need_to_show_string " "]
		set need_to_show [lindex $need_to_show_list 0]

		set flag [string equal $color_type "ColorID"]

                if {$flag==0} {
                        .textview.all.first.structure.all.highlight.draw.color.colorid configure -state disabled
                        set id [lindex $molid $select_id]
                        mol modselect $rep_sel $id element $need_to_show
                        mol modcolor $rep_sel $id $color_type
                        mol modstyle $rep_sel $id $draw_type
                        mol modmaterial $rep_sel $id $material_type
                }

                if {$flag==1} {
                        .textview.all.first.structure.all.highlight.draw.color.colorid configure -state readonly
                        set color_list [split $color_ID " "]
                        set this_color [lindex $color_list 0]

                        set id [lindex $molid $select_id]
                        mol modselect $rep_sel $id element $need_to_show
                        mol modcolor $rep_sel $id ColorID $this_color
                        mol modstyle $rep_sel $id $draw_type
                        mol modmaterial $rep_sel $id $material_type
                }
		set is_select 1

                set this_sel_info [format "element %s" $need_to_show]
		lset info_sel_list $style_color_sel_id $this_sel_info

		::Molcontrl::ref_sty_col_sel
	}
	
}
proc ::Molcontrl::show_select_atom {W} {
	variable atom
	variable color_type
        variable draw_type
        variable material_type
        variable molid
        variable select_id
        variable rep_sel
        variable color_ID
	variable is_select
	variable style_color_sel
	variable style_color_sel_id
        variable info_color_list
        variable info_style_list
	variable info_material_list
	variable info_sel_list
	variable all_mol

	set style_color_sel_len [llength $style_color_sel]
        if {$style_color_sel_len==0} {
                return
        }
	if {$all_mol==0} {
                return
        }
	
	set new_molid [molinfo list]
        set id [lindex $molid $select_id]
        set need_to_refresh 1
        foreach val $new_molid {
                if {$val==$id} {
                        set need_to_refresh 0
                }
        }
        if {$need_to_refresh==1} {
                set msg "File does not exist, please refresh the list"
                tk_messageBox -title "File name Error" -parent .textview -type ok -message $msg
                return
        }

	foreach index [$W curselection] {
		set is_colorID [lindex $info_color_list $style_color_sel_id]
                set is_colorID_list [split $is_colorID " "]
                set color_type [lindex $is_colorID_list 0]
                set draw_type [lindex $info_style_list $style_color_sel_id]
		set material_type [lindex $info_material_list $style_color_sel_id]

		set need_to_show_string [lindex $atom $index]
		set need_to_show_list [split $need_to_show_string " "]
		set need_to_show [lindex $need_to_show_list 0]

		set flag [string equal $color_type "ColorID"]

                if {$flag==0} {
                        .textview.all.first.structure.all.highlight.draw.color.colorid configure -state disabled
                        set id [lindex $molid $select_id]
                        mol modselect $rep_sel $id name $need_to_show
                        mol modcolor $rep_sel $id $color_type
                        mol modstyle $rep_sel $id $draw_type
                        mol modmaterial $rep_sel $id $material_type
                }

                if {$flag==1} {
                        .textview.all.first.structure.all.highlight.draw.color.colorid configure -state readonly
                        set color_list [split $color_ID " "]
                        set this_color [lindex $color_list 0]

                        set id [lindex $molid $select_id]
                        mol modselect $rep_sel $id name $need_to_show
                        mol modcolor $rep_sel $id ColorID $this_color
                        mol modstyle $rep_sel $id $draw_type
                        mol modmaterial $rep_sel $id $material_type
                }
		set is_select 1

                set this_sel_info [format "name %s" $need_to_show]
		lset info_sel_list $style_color_sel_id $this_sel_info

		::Molcontrl::ref_sty_col_sel
	}

}
#show center
proc ::Molcontrl::show_center {} {
	variable choose_center
	variable cmd
	variable all_mol
	variable select_id
	variable molid
	variable center

	if {$cmd==""} {
		return
	}
	if {$all_mol==0} {
		return
	}

	set new_molid [molinfo list]
        set id [lindex $molid $select_id]
        set need_to_refresh 1
        foreach val $new_molid {
                if {$val==$id} {
                        set need_to_refresh 0
                }
        }
        if {$need_to_refresh==1} {
                set msg "File does not exist, please refresh the list"
                tk_messageBox -title "File name Error" -parent .textview -type ok -message $msg
                return
        }
	
	set center ""
	set id [lindex $molid $select_id]
	if {[catch {atomselect $id $cmd}]} {
                return
        }

	if {$choose_center=="geometry center:"} {
		set center_sel [atomselect $id $cmd]
		if {[catch {measure center $center_sel}]} {
			return
		}
		set center_f [measure center $center_sel]
		set number 0
		set centerlength [llength $center_f]
		while {$number<$centerlength} {
			set center_sit_f [lindex $center_f $number]
			set center_sit [format "%10.2f" $center_sit_f]
			append center $center_sit
			incr number
		}
	}
	if {$choose_center=="center of mass:"} {
		set center_sel [atomselect $id $cmd]
		if {[catch {measure center $center_sel weight mass}]} {
			return
		}
		set center_f [measure center $center_sel weight mass]
		set number 0
		set centerlength [llength $center_f]
		while {$number<$centerlength} {
			set center_sit_f [lindex $center_f $number]
			set center_sit [format "%10.2f" $center_sit_f]
			append center $center_sit
			incr number
		}
	}
}
#get x y z min max
proc ::Molcontrl::minmax {} {
	variable cmd
	variable select_id
	variable molid
	variable x_min
	variable y_min
	variable z_min
	variable x_max
	variable y_max
	variable z_max
	variable all_mol
	variable all_atom_number
	variable size_x
	variable size_y
	variable size_z

	if {$cmd==""} {
                return
        }
        if {$all_mol==0} {
                return
        }

	set new_molid [molinfo list]
        set id [lindex $molid $select_id]
        set need_to_refresh 1
        foreach val $new_molid {
                if {$val==$id} {
                        set need_to_refresh 0
                }
        }
        if {$need_to_refresh==1} {
                return
        }

	set is_zero_number [lindex $all_atom_number $select_id]
        if {$is_zero_number==0} {
                return
        }

	set id [lindex $molid $select_id]
	if {[catch {set sel [atomselect $id $cmd]}]} {
                set msg "The atom selection you typed could not be understood"
                tk_messageBox -title "Selection Error" -parent .textview -type ok -message $msg
                return
        }
	set minmax_list [measure minmax $sel]
	set min_list [lindex $minmax_list 0]
	set max_list [lindex $minmax_list 1]

	set x_min_f [lindex $min_list 0]
	set x_min [format "%.2f" $x_min_f]
	set y_min_f [lindex $min_list 1]
        set y_min [format "%.2f" $y_min_f]
	set z_min_f [lindex $min_list 2]
        set z_min [format "%.2f" $z_min_f]

	set x_max_f [lindex $max_list 0]
	set x_max [format "%.2f" $x_max_f]
	set y_max_f [lindex $max_list 1]
        set y_max [format "%.2f" $y_max_f]
	set z_max_f [lindex $max_list 2]
        set z_max [format "%.2f" $z_max_f]

	set size_x_f [expr $x_max - $x_min]
	set size_x [format "%.2f" $size_x_f]
	set size_y_f [expr $y_max - $y_min]
	set size_y [format "%.2f" $size_y_f]
	set size_z_f [expr $z_max - $z_min]
	set size_z [format "%.2f" $size_z_f]
}
#get resid_residue
proc ::Molcontrl::resid_residue {W} {
        variable molid
        variable select_id
        variable chain
        variable resid_residue_list
        variable chain_id
	variable all_mol

	if {$all_mol==0} {
                return
        }

        set id [lindex $molid $select_id]
        set resid_residue_list {}
        set number 0
        set flag 0

	set new_molid [molinfo list]
        set need_to_refresh 1
        foreach val $new_molid {
                if {$val==$id} {
                        set need_to_refresh 0
                }
        }
        if {$need_to_refresh==1} {
                set msg "File does not exist, please refresh the list"
                tk_messageBox -title "File name Error" -parent .textview -type ok -message $msg
                return
        }

        foreach index [$W curselection] {
                set chain_id [lindex $chain $index]
                set chain_sel [atomselect $id "chain '$chain_id'"]
                set resid_all [$chain_sel get resid]
                set residue_all [$chain_sel get resname]

                foreach var $resid_all {
                        set residue_single [lindex $residue_all $number]
			set resid_residue [format "%d %s" $var $residue_single]
			lappend resid_residue_list $resid_residue
			incr number
                }
		set resid_residue_list [lsort -dictionary -unique $resid_residue_list]
        }
}
#get atom
proc ::Molcontrl::get_atom {W} {
	variable molid
        variable select_id
        variable resid_residue_list
        variable chain_id
	variable residue_atom
	variable all_mol

	if {$all_mol==0} {
                return
        }

        set id [lindex $molid $select_id]
	set new_molid [molinfo list]
        set need_to_refresh 1
        foreach val $new_molid {
                if {$val==$id} {
                        set need_to_refresh 0
                }
        }
        if {$need_to_refresh==1} {
                set msg "File does not exist, please refresh the list"
                tk_messageBox -title "File name Error" -parent .textview -type ok -message $msg
                return
        }

	set residue_atom {}
	set atom_name_list {}
	set atom_number {}
	set number 0
	foreach index [$W curselection] {
		#get atom number
		set resid_residue [lindex $resid_residue_list $index]
		set split_list [split $resid_residue " "]
		set resid_number [lindex $split_list 0]
		set atom_sel_command [format "atomselect %d {chain '%s' and resid '%d'}" $id $chain_id $resid_number]
		set atom_sel [eval $atom_sel_command]
		set atom_from_zero [$atom_sel list]

		foreach var $atom_from_zero {
			lappend atom_number [expr $var + 1]
		}		
		
		#get atom name
		set atom_name_list [$atom_sel get name]
		foreach var $atom_number {
			set atom_name [lindex $atom_name_list $number]
			incr number
			set number_name [format "%d %s" $var $atom_name]
			lappend residue_atom $number_name
		}
	}
}
#get res_num
proc ::Molcontrl::residue {W} {
	variable residue
	variable residueonly
	variable res_num
	variable molid
	variable select_id

	#empty
	set res_num {}

	set id [lindex $molid $select_id]
	foreach index [$W curselection] {
		set res [lindex $residueonly $index]
		set res_sel [atomselect $id "resname $res"]
		set residue_all [lsort -integer -unique [$res_sel get resid]]
		foreach var $residue_all {
			set chain_sel [atomselect $id "resid $var"]
			set chain_command [format "%s get chain" $chain_sel]
			set chain_all [eval $chain_command]
			set chain [lsort -unique $chain_all]
			set chain_resid ""
			foreach cha $chain {
				append chain_resid $cha
				append chain_resid "-"
				append chain_resid $var
				append chain_resid " "
			}
			lappend res_num $chain_resid
		}
	}
}
#get mass
proc ::Molcontrl::elementmass {W} {
	variable element_mass
	variable elementonly
	variable mass

	foreach index [$W curselection] {
		set element [lindex $elementonly $index]
                set number 0
                set length [llength $element_mass]
                while {$number<$length} {
                        set all [lindex $element_mass $number]
                        set judge [string equal $element $all]
                        if {$judge} {
                                set num [expr $number + 1]
                                set mass_part [lindex $element_mass $num]
                                set mass $mass_part
				set mass [format "%.3f" $mass]
                                break
                        }
                        incr number
                }
	}
}
#get id
proc ::Molcontrl::get_id {W} {
	variable residue_id
	variable residue_count
	variable molid
	variable select_id
	variable all_mol

	if {$all_mol==0} {
                return
        }	

	set residue_id {}
	set id [lindex $molid $select_id]
	set new_molid [molinfo list]
        set need_to_refresh 1
        foreach val $new_molid {
                if {$val==$id} {
                        set need_to_refresh 0
                }
        }
        if {$need_to_refresh==1} {
                set msg "File does not exist, please refresh the list"
                tk_messageBox -title "File name Error" -parent .textview -type ok -message $msg
                return
        }

	foreach index [$W curselection] {
		set res_count [lindex $residue_count $index]
		set res_count_list [split $res_count " "]
		set res_select [lindex $res_count_list 0]

		set sel [atomselect $id "resname '$res_select'"]
		set residue_id_all [$sel get resid]
		set residue_id [lsort -integer -unique $residue_id_all]
	}
}
#get charge
proc ::Molcontrl::atomcharge {W} {
	variable atom_charge
	variable atomonly
	variable charge

	foreach index [$W curselection] {
		set atom [lindex $atomonly $index]
		set number 0
		set length [llength $atom_charge]
		while {$number<$length} {
			set all [lindex $atom_charge $number]
			set judge [string equal $atom $all]
			if {$judge} {
				set num [expr $number + 1]
				set charge_part [lindex $atom_charge $num]
				set charge $charge_part
				set is_NaN [string equal $charge "NaN"]
				if {$is_NaN!=1&&$charge!=""} {
					set charge [format "%.3f" $charge]
				}
				break
			}
			incr number
		}
	}
}
#change scale
proc ::Molcontrl::change {} {
	variable from
	variable to
	variable select_id
        variable molid
        variable all_mol

        set new_molid [molinfo list]
        set id [lindex $molid $select_id]
        set need_to_refresh 1
        foreach val $new_molid {
                if {$val==$id} {
                        set need_to_refresh 0
                }
        }
        if {$need_to_refresh==1} {
                set msg "File does not exist, please refresh the list"
                tk_messageBox -title "File name Error" -parent .textview -type ok -message $msg
                return
        }

	set length [expr $to-$from]
	set interval [expr $length/5]
	destroy .textview.all.first.moving.shift.translate.down.pack_x.x .textview.all.first.moving.shift.translate.down.pack_x.x_sit .textview.all.first.moving.shift.translate.down.pack_x.x_scale
        destroy .textview.all.first.moving.shift.translate.down.pack_y.y .textview.all.first.moving.shift.translate.down.pack_y.y_sit .textview.all.first.moving.shift.translate.down.pack_y.y_scale
        destroy .textview.all.first.moving.shift.translate.down.pack_z.z .textview.all.first.moving.shift.translate.down.pack_z.z_sit .textview.all.first.moving.shift.translate.down.pack_z.z_scale

        label .textview.all.first.moving.shift.translate.down.pack_x.x -text "X:"
        entry .textview.all.first.moving.shift.translate.down.pack_x.x_sit -width 5 -bd 2 -textvariable ::Molcontrl::trans_x
        scale .textview.all.first.moving.shift.translate.down.pack_x.x_scale -label "X:" -variable ::Molcontrl::trans_x -length 58m -width .25c -from $from -to $to -resolution 1 -tickinterval $interval -showvalue 0 -orient horizontal -command {::Molcontrl::move_x}
        grid .textview.all.first.moving.shift.translate.down.pack_x.x .textview.all.first.moving.shift.translate.down.pack_x.x_sit .textview.all.first.moving.shift.translate.down.pack_x.x_scale
        bind .textview.all.first.moving.shift.translate.down.pack_x.x_sit <Return> {
                ::Molcontrl::move_trans
		::Molcontrl::reset
        }

        label .textview.all.first.moving.shift.translate.down.pack_y.y -text "Y:"
        entry .textview.all.first.moving.shift.translate.down.pack_y.y_sit -width 5 -bd 2 -textvariable ::Molcontrl::trans_y
        scale .textview.all.first.moving.shift.translate.down.pack_y.y_scale -label "Y:" -variable ::Molcontrl::trans_y -length 58m -width .25c -from $from -to $to -resolution 1 -tickinterval $interval -showvalue 0 -orient horizontal -command {::Molcontrl::move_y}
        grid .textview.all.first.moving.shift.translate.down.pack_y.y .textview.all.first.moving.shift.translate.down.pack_y.y_sit .textview.all.first.moving.shift.translate.down.pack_y.y_scale
        bind .textview.all.first.moving.shift.translate.down.pack_y.y_sit <Return> {
                ::Molcontrl::move_trans
		::Molcontrl::reset
        }

        label .textview.all.first.moving.shift.translate.down.pack_z.z -text "Z:"
        entry .textview.all.first.moving.shift.translate.down.pack_z.z_sit -width 5 -bd 2 -textvariable ::Molcontrl::trans_z
        scale .textview.all.first.moving.shift.translate.down.pack_z.z_scale -label "Z:" -variable ::Molcontrl::trans_z -length 58m -width .25c -from $from -to $to -resolution 1 -tickinterval $interval -showvalue 0 -orient horizontal -command {::Molcontrl::move_z}
        grid .textview.all.first.moving.shift.translate.down.pack_z.z .textview.all.first.moving.shift.translate.down.pack_z.z_sit .textview.all.first.moving.shift.translate.down.pack_z.z_scale
        bind .textview.all.first.moving.shift.translate.down.pack_z.z_sit <Return> {
                ::Molcontrl::move_trans
		::Molcontrl::reset
        }
}
#pbc
proc ::Molcontrl::pbcset {} {
	variable crystal_size_a
	variable crystal_size_b
	variable crystal_size_c
	variable crystal_size_alpha
	variable crystal_size_beta
	variable crystal_size_gamma
	variable molid
	variable select_id
	variable pbc_list
	variable all_mol
	variable all_atom_number
	global vmd_logfile_channel
	
	if {$all_mol==0} {
                return
        }

        set new_molid [molinfo list]
        set id [lindex $molid $select_id]
        set need_to_refresh 1
        foreach val $new_molid {
                if {$val==$id} {
                        set need_to_refresh 0
                }
        }
        if {$need_to_refresh==1} {
                set msg "File does not exist, please refresh the list"
                tk_messageBox -title "File name Error" -parent .textview -type ok -message $msg
                return
        }
	set is_zero_number [lindex $all_atom_number $select_id]
        if {$is_zero_number==0} {
                return
        }

	set sit {}
	lappend sit $crystal_size_a
	lappend sit $crystal_size_b
	lappend sit $crystal_size_c
	lappend sit $crystal_size_alpha
	lappend sit $crystal_size_beta
	lappend sit $crystal_size_gamma
	pbc set $sit -molid $id

	lset pbc_list $select_id $sit

	if {[catch {puts $vmd_logfile_channel "pbc set \{$sit\} -molid $id"}]} {
		return
	}
	flush $vmd_logfile_channel
}
#command
proc ::Molcontrl::command {} {
	variable cmd
	variable select_id
	variable molid
	variable all_mol
	variable center
	variable weight
	variable choose_center
	variable is_cmd

	variable element_mass
	variable style_color_sel
	variable style_color_sel_id
	variable this_sel_global
	variable draw_type
	variable color_type
	variable material_type
	variable info_sel_list
	variable all_atom_number
	variable color_ID_list

	set center ""
	set weight 0

	if {$cmd==""} {
		return
	}

	if {$all_mol==0} {
		return
	}

	set new_molid [molinfo list]
        set id [lindex $molid $select_id]
        set need_to_refresh 1
        foreach val $new_molid {
                if {$val==$id} {
                        set need_to_refresh 0
                }
        }
        if {$need_to_refresh==1} {
                set msg "File does not exist, please refresh the list"
                tk_messageBox -title "File name Error" -parent .textview -type ok -message $msg
                return
        }
	set style_color_sel_len [llength $style_color_sel]
	if {$style_color_sel_len==0} {
		return
	}

	if {[catch {atomselect $id $cmd}]} {
		set msg "The atom selection you typed could not be understood"
                tk_messageBox -title "Selection Error" -parent .textview -type ok -message $msg
                return
	}
	
	::Molcontrl::ref_sty_col_sel_list
        set style_color_sel_len [llength $style_color_sel]
        if {$style_color_sel_len<=$style_color_sel_id} {
                set msg "Please select a rep"
                tk_messageBox -title "Rep error" -parent .textview -type ok -message $msg
                return
        }

	set is_zero_number [lindex $all_atom_number $select_id]
        if {$is_zero_number==0} {
                return
        }
	
	set is_cmd 1

        set this_draw_info $draw_type
	if {$color_type!="ColorID"} {
		set this_color_info $color_type
	} else {
		set color_ID_number [lindex $color_ID_list $style_color_sel_id]
		set this_color_info [format "ColorID %d" $color_ID_number]
	}
	
	::Molcontrl::ref_sty_col_sel_list
	mol modselect $style_color_sel_id $id $cmd
        mol modcolor $style_color_sel_id $id $this_color_info
        mol modstyle $style_color_sel_id $id $draw_type
        mol modmaterial $style_color_sel_id $id $material_type
	
        set this_sel_info $cmd

        set this_draw_info_list [list $this_draw_info]
        set this_color_info_list [list $this_color_info]
        set this_sel_info_list [list $this_sel_info]

        set single_info [format "%s %s %s" $this_draw_info_list $this_color_info_list $this_sel_info_list]
	lset style_color_sel $style_color_sel_id $single_info
        lset info_sel_list $style_color_sel_id $cmd

	::Molcontrl::show_center
	::Molcontrl::show_weight
	::Molcontrl::minmax
}
#weight
proc ::Molcontrl::show_weight {} {
	variable weight
	variable cmd
	variable molid
	variable element_mass
	variable select_id
	variable all_mol

	set weight 0
	if {$cmd==""} {
                return
        }

        if {$all_mol==0} {
                return
        }

	set id [lindex $molid $select_id]
	if {[catch {atomselect $id $cmd}]} {
		return
	}
	set center_sel [atomselect $id $cmd]
	set weight_all [$center_sel get mass]
	foreach wei $weight_all {
		set weight [expr $weight + $wei]
	}
        set weight [format "%.2f" $weight]
}
#pbc box
proc ::Molcontrl::turnon {} {
	variable molid
	variable select_id
	variable all_mol
	global vmd_logfile_channel

	if {$all_mol==0} {
		return
	}

	set new_molid [molinfo list]
	set id [lindex $molid $select_id]
	set need_to_refresh 1
	foreach val $new_molid {
		if {$val==$id} {
			set need_to_refresh 0
		}
	}
	if {$need_to_refresh==1} {
		set msg "File does not exist, please refresh the list"
		tk_messageBox -title "File name Error" -parent .textview -type ok -message $msg
		return
	}

	set id [lindex $molid $select_id]
	foreach val $molid {
		pbc box -molid $val -off
		if {[catch {puts $vmd_logfile_channel "pbc box -molid $val -off"}]} {
			continue
		}
	}
	pbc box -molid $id -on

	if {[catch {puts $vmd_logfile_channel "pbc box -molid $id -on"}]} {
		return
	}
	flush $vmd_logfile_channel
}
proc ::Molcontrl::turnoff {} {
	variable molid
	variable select_id
	variable all_mol
	global vmd_logfile_channel

	if {$all_mol==0} {
		return
	}

	set new_molid [molinfo list]
	set id [lindex $molid $select_id]
	set need_to_refresh 1
	foreach val $new_molid {
		if {$val==$id} {
			set need_to_refresh 0
		}
	}
	if {$need_to_refresh==1} {
#		set msg "File does not exist, please refresh the list"
#		tk_messageBox -title "File name Error" -parent .textview -type ok -message $msg
		return
	}
	
	foreach val $molid {
		pbc box -molid $val -off
		if {[catch {puts $vmd_logfile_channel "pbc box -molid $val -off"}]} {
			continue
		}
	}
	if {[catch {flush $vmd_logfile_channel}]} {
		return
	}
}
#logfile turn on
proc ::Molcontrl::logfile_turnon {} {
	global vmd_logfile_channel

	set logfilename [tk_getSaveFile -filetypes  {{{Text Files} {.txt}} {All *}}]
	set file_len [string length $logfilename]
	if {$file_len==0} {
		set ::Molcontrl::turnon_logfile 0
		return
	}
	set rc [catch { open $logfilename w } log_msg]
	set vmd_logfile_channel $log_msg
	puts $vmd_logfile_channel "# [vmdinfo versionmsg]"
	puts $vmd_logfile_channel "# Log file $logfilename, created by user $::tcl_platform(user), developed by Chenchen Wu"
	flush $vmd_logfile_channel
}
proc ::Molcontrl::logfile_turnoff {} {
	global vmd_logfile_channel

	if {[catch {close $vmd_logfile_channel}]} {
		return
	}
}
#default
proc ::Molcontrl::def {} {
	variable molid
	variable select_id
	variable all_mol
	variable position
	variable trans_x
	variable trans_y
	variable trans_z
	variable rota_x
	variable rota_y
	variable rota_z
	variable trans_reference_x
	variable trans_reference_y
	variable trans_reference_z
	variable rota_reference_x
	variable rota_reference_y
	variable rota_reference_z

#	global vmd_logfile_channel

	if {$all_mol==0} {
                return
        }

	set new_molid [molinfo list]
        set id [lindex $molid $select_id]
        set need_to_refresh 1
        foreach val $new_molid {
                if {$val==$id} {
                        set need_to_refresh 0
                }
        }
        if {$need_to_refresh==1} {
                set msg "File does not exist, please refresh the list"
                tk_messageBox -title "File name Error" -parent .textview -type ok -message $msg
                return
        }

	set id_number [lsearch $position $id]
	set pos_number [expr $id_number+1]
	
	set sel [atomselect $id all]
	set apos [lindex $position $pos_number]
	$sel set {x y z} $apos

	set trans_x 0
	set trans_y 0
	set trans_z 0
	set rota_x 0
	set rota_y 0
	set rota_z 0
	set trans_reference_x 0
	set trans_reference_y 0
	set trans_reference_z 0
	set rota_reference_x 0
	set rota_reference_y 0
	set rota_reference_z 0

	::Molcontrl::show_center
	::Molcontrl::minmax

#	if {[catch {puts $vmd_logfile_channel "set sel \[atomselect $id all\]"}]} {
#		return
#	}
#	puts $vmd_logfile_channel "\$sel set \{x y z\} \{$apos\}"
#	flush $vmd_logfile_channel
}
#scroll-bar reset
proc ::Molcontrl::reset {} {
	variable trans_x
	variable trans_y
	variable trans_z
	variable rota_x
	variable rota_y
	variable rota_z
	variable trans_reference_x
	variable trans_reference_y
	variable trans_reference_z
        variable rota_reference_x
        variable rota_reference_y
        variable rota_reference_z

	set trans_x 0
	set trans_y 0
	set trans_z 0
	set rota_x 0
	set rota_y 0
	set rota_z 0
	set trans_reference_x 0
	set trans_reference_y 0
	set trans_reference_z 0
	set rota_reference_x 0
	set rota_reference_y 0
	set rota_reference_z 0
}
#scale trans
proc ::Molcontrl::move_x {val} {
	variable trans_reference_x
	variable all_mol
	variable molid
        variable select_id
	variable cmd
	variable all_atom_number
	global vmd_logfile_channel
	
	if {$all_mol==0} {
		return
	}
	set new_molid [molinfo list]
        set id [lindex $molid $select_id]
        set need_to_refresh 1
        foreach var $new_molid {
                if {$var==$id} {
                        set need_to_refresh 0
                }
        }
        if {$need_to_refresh==1} {
                set msg "File does not exist, please refresh the list"
                tk_messageBox -title "File name Error" -parent .textview -type ok -message $msg
                return
        }
	set is_zero_number [lindex $all_atom_number $select_id]
	if {$is_zero_number==0} {
		return
	}

	set x [expr $val-$trans_reference_x]
	set trans_reference_x $val
	set y 0
	set z 0
        set matrix {}
        lappend matrix $x
        lappend matrix $y
        lappend matrix $z
	if {[catch {set sel [atomselect $id $cmd]}]} {
                set msg "The atom selection you typed could not be understood"
                tk_messageBox -title "Selection Error" -parent .textview -type ok -message $msg
                return
        }
        $sel moveby $matrix
	::Molcontrl::show_center
	::Molcontrl::minmax

	if {[catch {puts $vmd_logfile_channel "set sel \[atomselect $id \"$cmd\"\]"}]} {
		return
	}
	puts $vmd_logfile_channel "\$sel moveby \{$matrix\}"
	flush $vmd_logfile_channel
}
proc ::Molcontrl::move_y {val} {
	variable trans_reference_y
	variable all_mol
	variable molid
        variable select_id
	variable cmd
	variable all_atom_number
	global vmd_logfile_channel

        if {$all_mol==0} {
                return
        }
	set new_molid [molinfo list]
        set id [lindex $molid $select_id]
        set need_to_refresh 1
        foreach var $new_molid {
                if {$var==$id} {
                        set need_to_refresh 0
                }
        }
        if {$need_to_refresh==1} {
                set msg "File does not exist, please refresh the list"
                tk_messageBox -title "File name Error" -parent .textview -type ok -message $msg
                return
        }
	set is_zero_number [lindex $all_atom_number $select_id]
        if {$is_zero_number==0} {
                return
        }

        set x 0
        set y [expr $val-$trans_reference_y]
	set trans_reference_y $val
        set z 0
        set matrix {}
        lappend matrix $x
        lappend matrix $y
        lappend matrix $z
	if {[catch {set sel [atomselect $id $cmd]}]} {
                set msg "The atom selection you typed could not be understood"
                tk_messageBox -title "Selection Error" -parent .textview -type ok -message $msg
                return
        }
        $sel moveby $matrix
	::Molcontrl::show_center
	::Molcontrl::minmax

	if {[catch {puts $vmd_logfile_channel "set sel \[atomselect $id \"$cmd\"\]"}]} {
                return
        }
        puts $vmd_logfile_channel "\$sel moveby \{$matrix\}"
        flush $vmd_logfile_channel
}
proc ::Molcontrl::move_z {val} {
	variable trans_reference_z
	variable all_mol
	variable molid
        variable select_id
	variable cmd
	variable all_atom_number
	global vmd_logfile_channel

        if {$all_mol==0} {
                return
        }
	set new_molid [molinfo list]
        set id [lindex $molid $select_id]
        set need_to_refresh 1
        foreach var $new_molid {
                if {$var==$id} {
                        set need_to_refresh 0
                }
        }
        if {$need_to_refresh==1} {
                set msg "File does not exist, please refresh the list"
                tk_messageBox -title "File name Error" -parent .textview -type ok -message $msg
                return
        }
	set is_zero_number [lindex $all_atom_number $select_id]
        if {$is_zero_number==0} {
                return
        }

        set x 0
        set y 0
        set z [expr $val-$trans_reference_z]
	set trans_reference_z $val
        set matrix {}
        lappend matrix $x
        lappend matrix $y
        lappend matrix $z
	if {[catch {set sel [atomselect $id $cmd]}]} {
                set msg "The atom selection you typed could not be understood"
                tk_messageBox -title "Selection Error" -parent .textview -type ok -message $msg
                return
        }
        $sel moveby $matrix
	::Molcontrl::show_center
	::Molcontrl::minmax

	if {[catch {puts $vmd_logfile_channel "set sel \[atomselect $id \"$cmd\"\]"}]} {
                return
        }
        puts $vmd_logfile_channel "\$sel moveby \{$matrix\}"
        flush $vmd_logfile_channel
}
#entry trans
proc ::Molcontrl::move_trans {} {
	variable trans_x
	variable trans_y
	variable trans_z
	variable molid
        variable select_id
	variable cmd
	variable all_mol
	variable all_atom_number
	global vmd_logfile_channel

	if {$all_mol==0} {
                return
        }

	set new_molid [molinfo list]
        set id [lindex $molid $select_id]
        set need_to_refresh 1
        foreach var $new_molid {
                if {$var==$id} {
                        set need_to_refresh 0
                }
        }
        if {$need_to_refresh==1} {
                set msg "File does not exist, please refresh the list"
                tk_messageBox -title "File name Error" -parent .textview -type ok -message $msg
                return
        }
	set is_zero_number [lindex $all_atom_number $select_id]
        if {$is_zero_number==0} {
                return
        }
	
	set matrix {}
	lappend matrix $trans_x
	lappend matrix $trans_y
	lappend matrix $trans_z
	if {[catch {set sel [atomselect $id $cmd]}]} {
                set msg "The atom selection you typed could not be understood"
                tk_messageBox -title "Selection Error" -parent .textview -type ok -message $msg
                return
        }
	$sel moveby $matrix
	::Molcontrl::show_center
	::Molcontrl::minmax

	if {[catch {puts $vmd_logfile_channel "set sel \[atomselect $id \"$cmd\"\]"}]} {
                return
        }
        puts $vmd_logfile_channel "\$sel moveby \{$matrix\}"
        flush $vmd_logfile_channel
}
#entry rotate
proc ::Molcontrl::move_rotax {} {
	variable rota_x
	variable is_center
	variable molid
        variable select_id
	variable cmd
	variable user_choice_x
	variable user_choice_y
	variable user_choice_z
	variable all_mol
	variable all_atom_number
	global vmd_logfile_channel

        if {$all_mol==0} {
                return
        }

	set new_molid [molinfo list]
        set id [lindex $molid $select_id]
        set need_to_refresh 1
        foreach var $new_molid {
                if {$var==$id} {
                        set need_to_refresh 0
                }
        }
        if {$need_to_refresh==1} {
                set msg "File does not exist, please refresh the list"
                tk_messageBox -title "File name Error" -parent .textview -type ok -message $msg
                return
        }
	set is_zero_number [lindex $all_atom_number $select_id]
        if {$is_zero_number==0} {
                return
        }

	if {[catch {set sel [atomselect $id $cmd]}]} {
                set msg "The atom selection you typed could not be understood"
                tk_messageBox -title "Selection Error" -parent .textview -type ok -message $msg
                return
        }
	if {$is_center=="center"} {
		set acen [measure center $sel]
	}
	if {$is_center=="weight mass"} {
		set acen [measure center $sel weight mass]	
	}
	if {$is_center=="origin"} {
		set acen {0 0 0}
	}
	if {$is_center=="user"} {
		set acen {0 0 0}
                lset acen 0 $user_choice_x
                lset acen 1 $user_choice_y
                lset acen 2 $user_choice_z
	}
	$sel move [trans center $acen axis x $rota_x]
	::Molcontrl::show_center
	::Molcontrl::minmax

	if {[catch {puts $vmd_logfile_channel "set sel \[atomselect $id \"$cmd\"\]"}]} {
                return
        }
        puts $vmd_logfile_channel "\$sel move \[trans center \{$acen\} axis x $rota_x\]"
        flush $vmd_logfile_channel
}
proc ::Molcontrl::move_rotay {} {
        variable rota_y
	variable is_center
	variable molid
        variable select_id
	variable cmd
	variable user_choice_x
        variable user_choice_y
        variable user_choice_z
	variable all_mol
	variable all_atom_number
	global vmd_logfile_channel

        if {$all_mol==0} {
                return
        }

	set new_molid [molinfo list]
        set id [lindex $molid $select_id]
        set need_to_refresh 1
        foreach var $new_molid {
                if {$var==$id} {
                        set need_to_refresh 0
                }
        }
        if {$need_to_refresh==1} {
                set msg "File does not exist, please refresh the list"
                tk_messageBox -title "File name Error" -parent .textview -type ok -message $msg
                return
        }
	set is_zero_number [lindex $all_atom_number $select_id]
        if {$is_zero_number==0} {
                return
        }

	if {[catch {set sel [atomselect $id $cmd]}]} {
                set msg "The atom selection you typed could not be understood"
                tk_messageBox -title "Selection Error" -parent .textview -type ok -message $msg
                return
        }
        if {$is_center=="center"} {
                set acen [measure center $sel]
        }
        if {$is_center=="weight mass"} {
                set acen [measure center $sel weight mass]
        }
        if {$is_center=="origin"} {
                set acen {0 0 0}
        }
	if {$is_center=="user"} {
		set acen {0 0 0}
                lset acen 0 $user_choice_x
                lset acen 1 $user_choice_y
                lset acen 2 $user_choice_z
        }
        $sel move [trans center $acen axis y $rota_y]
	::Molcontrl::show_center
	::Molcontrl::minmax

	if {[catch {puts $vmd_logfile_channel "set sel \[atomselect $id \"$cmd\"\]"}]} {
                return
        }
        puts $vmd_logfile_channel "\$sel move \[trans center \{$acen\} axis y $rota_y\]"
        flush $vmd_logfile_channel
}
proc ::Molcontrl::move_rotaz {} {
        variable rota_z
	variable is_center
	variable molid
        variable select_id
	variable cmd
	variable user_choice_x
        variable user_choice_y
        variable user_choice_z
	variable all_mol
	variable all_atom_number
	global vmd_logfile_channel

        if {$all_mol==0} {
                return
        }

	set new_molid [molinfo list]
        set id [lindex $molid $select_id]
        set need_to_refresh 1
        foreach var $new_molid {
                if {$var==$id} {
                        set need_to_refresh 0
                }
        }
        if {$need_to_refresh==1} {
                set msg "File does not exist, please refresh the list"
                tk_messageBox -title "File name Error" -parent .textview -type ok -message $msg
                return
        }
	set is_zero_number [lindex $all_atom_number $select_id]
        if {$is_zero_number==0} {
                return
        }

	if {[catch {set sel [atomselect $id $cmd]}]} {
                set msg "The atom selection you typed could not be understood"
                tk_messageBox -title "Selection Error" -parent .textview -type ok -message $msg
                return
        }
        if {$is_center=="center"} {
                set acen [measure center $sel]
        }
        if {$is_center=="weight mass"} {
                set acen [measure center $sel weight mass]
        }
        if {$is_center=="origin"} {
                set acen {0 0 0}
        }
	if {$is_center=="user"} {
		set acen {0 0 0}
                lset acen 0 $user_choice_x
                lset acen 1 $user_choice_y
                lset acen 2 $user_choice_z
        }
        $sel move [trans center $acen axis z $rota_z]
	::Molcontrl::show_center
	::Molcontrl::minmax

	if {[catch {puts $vmd_logfile_channel "set sel \[atomselect $id \"$cmd\"\]"}]} {
                return
        }
        puts $vmd_logfile_channel "\$sel move \[trans center \{$acen\} axis z $rota_z\]"
        flush $vmd_logfile_channel
}
#scale rotate
proc ::Molcontrl::rotatex {val} {
	variable is_center
	variable rota_reference_x
	variable all_mol
	variable molid
        variable select_id
	variable cmd
	variable user_choice_x
        variable user_choice_y
        variable user_choice_z
	variable all_atom_number
	global vmd_logfile_channel

	if {$all_mol==0} {
                return
        }

	set new_molid [molinfo list]
        set id [lindex $molid $select_id]
        set need_to_refresh 1
        foreach var $new_molid {
                if {$var==$id} {
                        set need_to_refresh 0
                }
        }
        if {$need_to_refresh==1} {
                set msg "File does not exist, please refresh the list"
                tk_messageBox -title "File name Error" -parent .textview -type ok -message $msg
                return
        }
	set is_zero_number [lindex $all_atom_number $select_id]
        if {$is_zero_number==0} {
                return
        }

	set x [expr $val-$rota_reference_x]
	set rota_reference_x $val
	
	if {[catch {set sel [atomselect $id $cmd]}]} {
                set msg "The atom selection you typed could not be understood"
                tk_messageBox -title "Selection Error" -parent .textview -type ok -message $msg
                return
        }
        if {$is_center=="center"} {
                set acen [measure center $sel]
        }
        if {$is_center=="weight mass"} {
                set acen [measure center $sel weight mass]
        }
        if {$is_center=="origin"} {
                set acen {0 0 0}
        }
	if {$is_center=="user"} {
		set acen {0 0 0}
		lset acen 0 $user_choice_x
		lset acen 1 $user_choice_y
		lset acen 2 $user_choice_z
        }
        $sel move [trans center $acen axis x $x]
	::Molcontrl::show_center
	::Molcontrl::minmax

	if {[catch {puts $vmd_logfile_channel "set sel \[atomselect $id \"$cmd\"\]"}]} {
                return
        }
        puts $vmd_logfile_channel "\$sel move \[trans center \{$acen\} axis x $x\]"
        flush $vmd_logfile_channel
}
proc ::Molcontrl::rotatey {val} {
	variable is_center
        variable rota_reference_y
	variable all_mol
	variable molid
        variable select_id
	variable cmd
	variable user_choice_x
        variable user_choice_y
        variable user_choice_z
	variable all_atom_number
	global vmd_logfile_channel

	if {$all_mol==0} {
                return
        }

	set new_molid [molinfo list]
        set id [lindex $molid $select_id]
        set need_to_refresh 1
        foreach var $new_molid {
                if {$var==$id} {
                        set need_to_refresh 0
                }
        }
        if {$need_to_refresh==1} {
                set msg "File does not exist, please refresh the list"
                tk_messageBox -title "File name Error" -parent .textview -type ok -message $msg
                return
        }
	set is_zero_number [lindex $all_atom_number $select_id]
        if {$is_zero_number==0} {
                return
        }

	set x [expr $val-$rota_reference_y]
        set rota_reference_y $val

	if {[catch {set sel [atomselect $id $cmd]}]} {
                set msg "The atom selection you typed could not be understood"
                tk_messageBox -title "Selection Error" -parent .textview -type ok -message $msg
                return
        }
        if {$is_center=="center"} {
                set acen [measure center $sel]
        }
        if {$is_center=="weight mass"} {
                set acen [measure center $sel weight mass]
        }
        if {$is_center=="origin"} {
                set acen {0 0 0}
        }
	if {$is_center=="user"} {
		set acen {0 0 0}
                lset acen 0 $user_choice_x
                lset acen 1 $user_choice_y
                lset acen 2 $user_choice_z
        }
        $sel move [trans center $acen axis y $x]
	::Molcontrl::show_center
	::Molcontrl::minmax

	if {[catch {puts $vmd_logfile_channel "set sel \[atomselect $id \"$cmd\"\]"}]} {
                return
        }
        puts $vmd_logfile_channel "\$sel move \[trans center \{$acen\} axis y $x\]"
        flush $vmd_logfile_channel
}
proc ::Molcontrl::rotatez {val} {
	variable is_center
        variable rota_reference_z
	variable all_mol
	variable molid
        variable select_id
	variable cmd
	variable user_choice_x
        variable user_choice_y
        variable user_choice_z
	variable all_atom_number
	global vmd_logfile_channel

	if {$all_mol==0} {
                return
        }

	set new_molid [molinfo list]
        set id [lindex $molid $select_id]
        set need_to_refresh 1
        foreach var $new_molid {
                if {$var==$id} {
                        set need_to_refresh 0
                }
        }
        if {$need_to_refresh==1} {
                set msg "File does not exist, please refresh the list"
                tk_messageBox -title "File name Error" -parent .textview -type ok -message $msg
                return
        }
	set is_zero_number [lindex $all_atom_number $select_id]
        if {$is_zero_number==0} {
                return
        }

	set x [expr $val-$rota_reference_z]
        set rota_reference_z $val

	if {[catch {set sel [atomselect $id $cmd]}]} {
                set msg "The atom selection you typed could not be understood"
                tk_messageBox -title "Selection Error" -parent .textview -type ok -message $msg
                return
        }
        if {$is_center=="center"} {
                set acen [measure center $sel]
        }
        if {$is_center=="weight mass"} {
                set acen [measure center $sel weight mass]
        }
        if {$is_center=="origin"} {
                set acen {0 0 0}
        }
	if {$is_center=="user"} {
		set acen {0 0 0}
                lset acen 0 $user_choice_x
                lset acen 1 $user_choice_y
                lset acen 2 $user_choice_z
        }
        $sel move [trans center $acen axis z $x]
	::Molcontrl::show_center
	::Molcontrl::minmax

	if {[catch {puts $vmd_logfile_channel "set sel \[atomselect $id \"$cmd\"\]"}]} {
                return
        }
        puts $vmd_logfile_channel "\$sel move \[trans center \{$acen\} axis z $x\]"
        flush $vmd_logfile_channel
}
#select chain resid residue element atom charge
proc ::Molcontrl::selectall {} {
	variable all_mol
	variable molid
        variable select_id
	variable cmd

	if {$all_mol==0} {
                return
        }

	set id [lindex $molid $select_id]
        set sel [atomselect $id $cmd]

	set chain [expr $::Molcontrl::chain_select%2]
	set resid [expr $::Molcontrl::resid_select%2]
	set residue [expr $::Molcontrl::residue_select%2]
	set element [expr $::Molcontrl::element_select%2]
	set atom [expr $::Molcontrl::atom_select%2]
	set charge [expr $::Molcontrl::charge_select%2]
	set selall {}
	lappend selall $chain
	lappend selall $resid
	lappend selall $residue
	lappend selall $element
	lappend selall $atom
	lappend selall $charge

	set form {%c %d %r %e %1i %q}
	set number 0
	set length [llength $selall]
	set msg ""
	while {$number<$length} {
		set value [lindex $selall $number]
		if {$value==1} {
			set state [lindex $form $number]
			append msg $state
		}
		incr number
	}
	label delete Atoms all
	set number 0
        foreach var [$sel list] {
                label add Atoms $id/$var
                label textformat Atoms $number $msg
                #label textoffset Atoms $number { -0.11 -0.0055 }
                incr number
        }
        $sel delete
        label textsize 1.2
}
#res_count
proc ::Molcontrl::res_count {} {
	variable residue_count

	set res_len [llength $residue_count]
	if {$res_len==0} {
		set msg "You need to select a molecule"
		tk_messageBox -title "Empty List" -parent .textview -type ok -message $msg
		return
        }

	set filename [tk_getSaveFile -filetypes  {{{Text Files} {.txt}} {All *}}]
	set filelength [llength $filename]
	if {$filelength==0} {
		return
	}
	set f [open $filename w]

	foreach val $residue_count {
		set val_res [lindex $val 0]
		set val_num [lindex $val 1]
		set single_info [format "%s\t%s" $val_res $val_num]
		puts $f $single_info
	}
	close $f
}
#judge
proc ::Molcontrl::judge {} {
	variable selection
	variable all_mol

        if {$all_mol==0} {
                return
        }
	if {$selection=="Res_Count"} {
		::Molcontrl::res_count
	}

	if {$selection=="Selected Atoms"} {
		::Molcontrl::part
	}

	if {$selection=="Selected File/Molecular"} {
		::Molcontrl::save
	}

	if {$selection=="Merged All Listed Files"} {
		::Molcontrl::these	
	}
}
#part
proc ::Molcontrl::part {} {
	variable molid
	variable select_id
	variable cmd
	variable thesefile

	set file_not_change [lindex $thesefile $select_id]
	set extension_name [file extension $file_not_change]
	set is_pdb [string equal $extension_name ".pdb"]
	set is_gro [string equal $extension_name ".gro"]
	set is_mol2 [string equal $extension_name ".mol2"]
	set is_empty [string equal $extension_name ""]

	if {$is_pdb==0&&$is_gro==0&&$is_mol2==0&&$is_empty==0} {
		set msg "You should use a pdb/gro/mol2 file"
		tk_messageBox -title "File type Error" -parent .textview -type ok -message $msg
		return
	}

	set new_molid [molinfo list]
        set id [lindex $molid $select_id]
        set need_to_refresh 1
        foreach val $new_molid {
                if {$val==$id} {
                        set need_to_refresh 0
                }
        }
        if {$need_to_refresh==1} {
                set msg "File does not exist, please refresh the list"
                tk_messageBox -title "File name Error" -parent .textview -type ok -message $msg
                return
        }	

	if {$is_pdb==1} {
		set id [lindex $molid $select_id]
		if {[catch {set sel [atomselect $id $cmd]}]} {
			set msg "The atom selection you typed could not be understood"
			tk_messageBox -title "Selection Error" -parent .textview -type ok -message $msg
			return
		}
		set filename [::Molcontrl::savefile]
		set filelength [llength $filename]
        	if {$filelength==0} {
                	return
        	}
		if {[catch {$sel writepdb $filename}]} {
			set msg "webpdb does not exist"
			tk_messageBox -title "File Error" -parent .textview -type ok -message $msg
			return
		}
	}
	
	if {$is_gro==1} {
		set id [lindex $molid $select_id]
		if {[catch {set sel [atomselect $id $cmd]}]} {
                        set msg "The atom selection you typed could not be understood"
                        tk_messageBox -title "Selection Error" -parent .textview -type ok -message $msg
                        return
                }
		set filename [::Molcontrl::savefile]
		set filelength [llength $filename]
        	if {$filelength==0} {
                	return
        	}
		if {[catch {$sel writepdb $filename}]} {
                        set msg "webpdb does not exist"
                        tk_messageBox -title "File Error" -parent .textview -type ok -message $msg
                        return
                }
	}

	if {$is_mol2==1} {
		set id [lindex $molid $select_id]
		if {[catch {set sel [atomselect $id $cmd]}]} {
                        set msg "The atom selection you typed could not be understood"
                        tk_messageBox -title "Selection Error" -parent .textview -type ok -message $msg
                        return
                }
		set filename [::Molcontrl::savefile]
		set filelength [llength $filename]
        	if {$filelength==0} {
                	return
	        }
		if {[catch {$sel writepdb $filename}]} {
                        set msg "webpdb does not exist"
                        tk_messageBox -title "File Error" -parent .textview -type ok -message $msg
                        return
                }
	}
	if {$is_empty==1} {
		set id [lindex $molid $select_id]
		if {[catch {set sel [atomselect $id $cmd]}]} {
                        set msg "The atom selection you typed could not be understood"
                        tk_messageBox -title "Selection Error" -parent .textview -type ok -message $msg
                        return
                }
                set filename [::Molcontrl::savefile]
                set filelength [llength $filename]
                if {$filelength==0} {
                        return
                }
		if {[catch {$sel writepdb $filename}]} {
                        set msg "webpdb does not exist"
                        tk_messageBox -title "File Error" -parent .textview -type ok -message $msg
                        return
                }
	}

	set f_end [open $filename a]
	set ter "TER"
	puts $f_end $ter
	close $f_end	
}
#choose pdb files
proc ::Molcontrl::choose {} {
        variable filename
        set direction [tk_getOpenFile -filetypes  {{PDB .pdb} {All *}} -multiple true]
        set length [string length $direction]
        set number 0
        set filename {}
        set count 0
        while {$number<$length} {
                set str [string index $direction $number]
                if {$count==0} {
               	        if {$str==" "} {
       	                        set space [expr $number - 1]
                                set data [string range $direction 0 $space]
                               	lappend filename $data
                       	        set previous [expr $number + 1]
               	                incr count
 		        }
	        } else {
                        if {$str==" "} {
       	                        set space [expr $number - 1]
                                set data [string range $direction $previous $space]
                               	lappend filename $data
                       	        set previous [expr $number + 1]
               	        }
                }
                incr number
	}
	if {$count==0} {
		lappend filename $direction
	} else {
        	set data [string range $direction $previous end]
        	lappend filename $data
	}
        return $direction
}
#save pdb files
proc ::Molcontrl::savefile {} {
	set filename [tk_getSaveFile -filetypes  {{PDB .pdb} {All *}}]	
	return $filename
}
#merge pdb files
proc ::Molcontrl::merge {} {
	variable filename

	set find_atom "ATOM"
	set find_cryst1 "CRYST1"
	set alpha_int 90
	set beta_int 90
	set gamma_int 90	
	set is_pdb 1

	foreach each_file $filename {
                set extension_name [file extension $each_file]
                if {$extension_name!=".pdb"} {
                        set is_pdb 0
                }
        }

        if {$is_pdb==0} {
                set msg "You should use pdb files"
                tk_messageBox -title "File type Error" -parent .textview -type ok -message $msg
                return
        }

	set filelength [llength $filename]
	if {$filelength==0} {
		return
	}

	set pdbfile [::Molcontrl::savefile]
	set judge [string equal $pdbfile ""]
	if {$judge} {
		return
	}

	# get crystal_a{} crystal_b{} crystal_c{}
	set crystal_a {}
	set crystal_b {}
	set crystal_c {}

	foreach var $filename {
		set f_crystal [open $var r]
		set row 0

		while {[eof $f_crystal]!=1} {
			incr row
                        gets $f_crystal line
			set sense_atom [string first $find_atom $line]
			if {$sense_atom==0} {
				set string_a [string range $line 30 37]
				set string_b [string range $line 38 45]
				set string_c [string range $line 46 53]
				set float_a [format "%9.3f" $string_a]
				set float_b [format "%9.3f" $string_b]
				set float_c [format "%9.3f" $string_c]
				lappend crystal_a $float_a
				lappend crystal_b $float_b
				lappend crystal_c $float_c
			}
		}
		close $f_crystal
	}

	#find a b c max min
	set crystal_a_max [lindex $crystal_a 0]
	set crystal_a_min [lindex $crystal_a 0]
	foreach val $crystal_a {
		if {$val>$crystal_a_max} {
			set crystal_a_max $val
		}
		if {$val<$crystal_a_min} {
			set crystal_a_min $val
		}
	}
	
	set crystal_b_max [lindex $crystal_b 0]
        set crystal_b_min [lindex $crystal_b 0]
        foreach val $crystal_b {
                if {$val>$crystal_b_max} {
                        set crystal_b_max $val
                }
                if {$val<$crystal_b_min} {
                        set crystal_b_min $val
                }
        }

	set crystal_c_max [lindex $crystal_c 0]
        set crystal_c_min [lindex $crystal_c 0]
        foreach val $crystal_c {
                if {$val>$crystal_c_max} {
                        set crystal_c_max $val
                }
                if {$val<$crystal_c_min} {
                        set crystal_c_min $val
                }
        }
	set crystal_a_difference [expr $crystal_a_max - $crystal_a_min]
	set crystal_b_difference [expr $crystal_b_max - $crystal_b_min]
	set crystal_c_difference [expr $crystal_c_max - $crystal_c_min]
	set new_crystal_a [format "%9.3f" $crystal_a_difference]
	set new_crystal_b [format "%9.3f" $crystal_b_difference]
	set new_crystal_c [format "%9.3f" $crystal_c_difference]

	set f [open $pdbfile w]
        set atom_number 1
        set cryst {}
	#select all cryst1
	foreach val $filename {
		set fd [open $val r]
		set row 0
		
		while {[eof $fd]!=1} {
			incr row
			gets $fd line
			set sense_crystal [string first $find_cryst1 $line]
			if {$sense_crystal==0} {
				lappend cryst $line
			}
		}	
		close $fd
	}

	set alpha_float [format "%7.2f" $alpha_int]
	set beta_float [format "%7.2f" $beta_int]
	set gamma_float [format "%7.2f" $gamma_int]

	set cryst_first [lindex $cryst 0]
	set cryst_end [string range $cryst_first 54 end]
	set cryst1 [format "CRYST1%s%s%s%s%s%s%s" $new_crystal_a $new_crystal_b $new_crystal_c $alpha_float $beta_float $gamma_float $cryst_end]
	puts $f $cryst1
	close $f

	set f [open $pdbfile a]
	foreach val $filename {
                set fd [open $val r]
                set row 0

		while {[eof $fd]!=1} {
                        incr row
                        gets $fd line
			set sense_atom [string first $find_atom $line]
			if {$sense_atom==0} {
				set newline $line
				set atomnumber_next [format "%5d" $atom_number]
				set atom [string replace $newline 6 10 $atomnumber_next]
				puts $f $atom
				incr atom_number
			}
		}
		close $fd
	}
	close $f
}
proc ::Molcontrl::save {} {
	variable molid
	variable select_id
	variable thesefile
	variable pbc_list
	variable select_files

	set find_atom "ATOM"
	set find_cryst1 "CRYST1"
	set sense_crystal 1
	set atom_number_list {}
	set is_support 1
	set alpha_int 90
        set beta_int 90
        set gamma_int 90
	set thesefile_new {}
	
	set filelength [llength $thesefile]
        if {$filelength==0} {
                return
        }

	set new_molid [molinfo list]
	set refresh_select_files {}
	foreach val $select_files {
		set new_select_file [lindex $molid $val]
		lappend refresh_select_files $new_select_file
	}

        foreach val1 $refresh_select_files {
		set need_to_refresh 1
		foreach val2 $new_molid {
			if {$val1==$val2} {
				set need_to_refresh 0
			}
		}
		if {$need_to_refresh==1} {
         	       set msg "File does not exist, please refresh the list"
                	tk_messageBox -title "File name Error" -parent .textview -type ok -message $msg
                	return
        	}
        }

	set new_filelist {}
	foreach var $select_files {
		set file_single [lindex $thesefile $var]
		lappend new_filelist $file_single
	}

	foreach each_file $new_filelist {
                set extension_name [file extension $each_file]
                if {$extension_name!=".pdb"&&$extension_name!=".gro"&&$extension_name!=".mol2"&&$extension_name!=""} {
                        set is_support 0
                }
        }

        if {$is_support==0} {
                set msg "You should use pdb/gro/mol2 files"
                tk_messageBox -title "File type Error" -parent .textview -type ok -message $msg
                return
        }

        set filelength [llength $new_filelist]
        if {$filelength==0} {
		set msg "Please select molecules"
                tk_messageBox -title "File name Error" -parent .textview -type ok -message $msg
                return
        }

        set pdbfile [::Molcontrl::savefile]

        set judge [string equal $pdbfile ""]
        if {$judge} {
                return
        }	
	
	foreach val $thesefile {
                set is_same_filename [string equal $val $pdbfile]
                if {$is_same_filename==1} {
                        set msg "File exists in the list"
                        tk_messageBox -title "File name Error" -parent .textview -type ok -message $msg
                        return
                }
        }

        #save new pdb files
        set filenumber 0
        foreach val $refresh_select_files {
                set sel [atomselect $val all]

                set dir_name_pdb [lindex $new_filelist $filenumber]
                set dir_name [file dirname $dir_name_pdb]
                set tail_name [file tail $dir_name_pdb]
                set paper_name [file root $tail_name]
                set extension_name ".pdb"
                set reference_name [format "%s/~$%s%d%s" $dir_name $paper_name $filenumber $extension_name]

		if {[catch {$sel writepdb $reference_name}]} {
                        set msg "PDB file does not exist"
                        tk_messageBox -title "PDB Error" -parent .textview -type ok -message $msg
			foreach val $thesefile_new {
				file delete $val
			}
                        return
                }

                incr filenumber
                lappend thesefile_new $reference_name
        }

        set f [open $pdbfile w]
        set cryst {}
        set crystal_max {}
        set crystal_min {}
        foreach val $refresh_select_files {
                set sel [atomselect $val all]
                set crystal_min_max [measure minmax $sel]
                lappend crystal_min [lindex $crystal_min_max 0]
                lappend crystal_max [lindex $crystal_min_max 1]
        }

        #max-min
        set crystal_min_abc_first [lindex $crystal_min 0]
        set crystal_min_a [lindex $crystal_min_abc_first 0]
        set index 0
        foreach val $crystal_min {
                set crystal_min_abc [lindex $crystal_min $index]
                set min_a [lindex $crystal_min_abc 0]
                if {$min_a<$crystal_min_a} {
                        set crystal_min_a $min_a
                }
                incr index
        }
	
	set index 0
        set crystal_min_b [lindex $crystal_min_abc_first 1]
        foreach val $crystal_min {
                set crystal_min_abc [lindex $crystal_min $index]
                set min_b [lindex $crystal_min_abc 1]
                if {$min_b<$crystal_min_b} {
                        set crystal_min_b $min_b
                }
                incr index
        }

        set index 0
        set crystal_min_c [lindex $crystal_min_abc_first 2]
        foreach val $crystal_min {
                set crystal_min_abc [lindex $crystal_min $index]
                set min_c [lindex $crystal_min_abc 2]
                if {$min_c<$crystal_min_c} {
                        set crystal_min_c $min_c
                }
                incr index
        }

        set crystal_max_abc_first [lindex $crystal_max 0]
        set crystal_max_a [lindex $crystal_max_abc_first 0]
        set index 0
        foreach val $crystal_max {
                set crystal_max_abc [lindex $crystal_max $index]
                set max_a [lindex $crystal_max_abc 0]
                if {$max_a>$crystal_max_a} {
                        set crystal_max_a $max_a
                }
                incr index
        }

        set index 0
        set crystal_max_b [lindex $crystal_max_abc_first 1]
        foreach val $crystal_max {
                set crystal_max_abc [lindex $crystal_max $index]
                set max_b [lindex $crystal_max_abc 1]
                if {$max_b>$crystal_max_b} {
                        set crystal_max_b $max_b
                }
                incr index
        }

	set index 0
        set crystal_max_c [lindex $crystal_max_abc_first 2]
        foreach val $crystal_max {
                set crystal_max_abc [lindex $crystal_max $index]
                set max_c [lindex $crystal_max_abc 2]
                if {$max_c>$crystal_max_c} {
                        set crystal_max_c $max_c
                }
                incr index
        }

        set crystal_a_difference [expr $crystal_max_a - $crystal_min_a]
        set crystal_b_difference [expr $crystal_max_b - $crystal_min_b]
        set crystal_c_difference [expr $crystal_max_c - $crystal_min_c]

        set new_crystal_a [format "%9.3f" $crystal_a_difference]
        set new_crystal_b [format "%9.3f" $crystal_b_difference]
        set new_crystal_c [format "%9.3f" $crystal_c_difference]

        #get all cryst1
        foreach val $new_filelist {
                set is_which_file [file extension $val]
                if {$is_which_file==".pdb"} {
                        lappend atom_number_list "pdb"
                }
                if {$is_which_file==".gro"} {
                        lappend atom_number_list "gro"
                }
                if {$is_which_file==".mol2"} {
                        lappend atom_number_list "mol2"
                }
        }

	set alpha [format "%7.2f" $alpha_int]
        set beta [format "%7.2f" $beta_int]
        set gamma [format "%7.2f" $gamma_int]

        set cryst_first [lindex $cryst 0]
        set cryst_end [string range $cryst_first 54 end]
        set cryst1 [format "CRYST1%s%s%s%s%s%s%s" $new_crystal_a $new_crystal_b $new_crystal_c $alpha $beta $gamma $cryst_end]
        puts $f $cryst1
        close $f

        set atom_number 1
        set f [open $pdbfile a]
        set index 0
        foreach val $thesefile_new {
                set fd [open $val r]
                set row 0

                set number_limit [lindex $atom_number_list $index]

                if {$number_limit=="gro"} {
                        while {[eof $fd]!=1} {
                                incr row
                                gets $fd line
                                set sense_atom [string first $find_atom $line]
                                if {$sense_atom==0} {
                                        set newline $line
                                        set atomnumber_next [format "%5d" $atom_number]
                                        set atom [string replace $newline 6 10 $atomnumber_next]
                                        puts $f $atom
                                        incr atom_number
                                }
                        }
                        close $fd
                        incr index
                }

                if {$number_limit=="mol2"} {
                        while {[eof $fd]!=1} {
                                incr row
                                gets $fd line
                                set sense_atom [string first $find_atom $line]
                                if {$sense_atom==0} {
                                        set newline $line
                                        set atomnumber_next [format "%5d" $atom_number]
                                        set atom [string replace $newline 6 10 $atomnumber_next]
                                        puts $f $atom
                                        incr atom_number
                                }
                        }
                        close $fd
                        incr index
                }

		if {$number_limit!="gro"&&$number_limit!="mol2"} {
			while {[eof $fd]!=1} {
                                incr row
                                gets $fd line
                                set sense_atom [string first $find_atom $line]
                                if {$sense_atom==0} {
                                        set newline $line
                                        set atomnumber_next [format "%5d" $atom_number]
                                        set atom [string replace $newline 6 10 $atomnumber_next]
                                        puts $f $atom
                                        incr atom_number
                                }
                        }
                        close $fd
                        incr index
                }
        }
        close $f

	set f_end [open $pdbfile a]
        set ter "TER"
        puts $f_end $ter
        close $f_end

        #delete new files
        foreach val $thesefile_new {
                file delete $val
        }
}
proc ::Molcontrl::these {} {
	variable thesefile
	variable molid

	set thesefile_new {}
        set find_atom "ATOM"
        set find_cryst1 "CRYST1"
        set alpha_int 90
        set beta_int 90
        set gamma_int 90
	set atom_number_list {}
	set is_support 1

        set filelength [llength $thesefile]
        if {$filelength==0} {
                return
        }

	set new_molid [molinfo list]
        set new_molid_length [llength $new_molid]
        set molid_length [llength $molid]
        if {$new_molid_length!=$molid_length} {
                set msg "File list changed, please refresh"
                tk_messageBox -title "File name Error" -parent .textview -type ok -message $msg
                return
        }

        set need_to_refresh 0
        if {$new_molid_length==$molid_length} {
                set molid_index 0
                while {$molid_index<$molid_length} {
                        set this_molid [lindex $molid $molid_index]
                        set this_new_molid [lindex $new_molid $molid_index]
                        if {$this_molid!=$this_new_molid} {
                                set need_to_refresh 1
                        }
                        incr molid_index
                }
        }
        if {$need_to_refresh==1} {
                set msg "File list changed, please refresh"
                tk_messageBox -title "File name Error" -parent .textview -type ok -message $msg
                return
        }

        foreach each_file $thesefile {
                set extension_name [file extension $each_file]
                if {$extension_name!=".pdb"&&$extension_name!=".gro"&&$extension_name!=".mol2"&&$extension_name!=""} {
                        set is_support 0
                }
        }

        if {$is_support==0} {
                set msg "You should use pdb/gro/mol2 files"
                tk_messageBox -title "File type Error" -parent .textview -type ok -message $msg
                return
        }

        set pdbfile [::Molcontrl::savefile]

        set judge [string equal $pdbfile ""]
        if {$judge} {
                return
        }

	foreach val $thesefile {
		set is_same_filename [string equal $val $pdbfile]
		if {$is_same_filename==1} {
			set msg "File exists in the list"
			tk_messageBox -title "File name Error" -parent .textview -type ok -message $msg
			return
		}
	}

	#save new pdb files
	set filenumber 0
        foreach val $molid {
		set sel [atomselect $val all]
		
                set dir_name_pdb [lindex $thesefile $filenumber]
		set dir_name [file dirname $dir_name_pdb]
	        set tail_name [file tail $dir_name_pdb]
		set paper_name [file root $tail_name]
		set extension_name ".pdb"
	        set reference_name [format "%s/~$%s%d%s" $dir_name $paper_name $filenumber $extension_name]
		if {[catch {$sel writepdb $reference_name}]} {
                        set msg "PDB file does not exist"
                        tk_messageBox -title "PDB Error" -parent .textview -type ok -message $msg
			foreach val $thesefile_new {
                                file delete $val
                        }
                        return
                }
	
                incr filenumber
                lappend thesefile_new $reference_name
        }

        set f [open $pdbfile w]
        set cryst {}
	set crystal_max {}
	set crystal_min {}
	foreach val $molid {
		set sel [atomselect $val all]
		set crystal_min_max [measure minmax $sel]
		lappend crystal_min [lindex $crystal_min_max 0]
		lappend crystal_max [lindex $crystal_min_max 1]	
	}

	#max-min
	set crystal_min_abc_first [lindex $crystal_min 0]
	set crystal_min_a [lindex $crystal_min_abc_first 0]
	set index 0
	foreach val $crystal_min {
		set crystal_min_abc [lindex $crystal_min $index]
		set min_a [lindex $crystal_min_abc 0]
		if {$min_a<$crystal_min_a} {
			set crystal_min_a $min_a
		}
		incr index
	}

	set index 0
        set crystal_min_b [lindex $crystal_min_abc_first 1]
        foreach val $crystal_min {
                set crystal_min_abc [lindex $crystal_min $index]
                set min_b [lindex $crystal_min_abc 1]
                if {$min_b<$crystal_min_b} {
                        set crystal_min_b $min_b
                }
		incr index
        }

	set index 0
        set crystal_min_c [lindex $crystal_min_abc_first 2]
        foreach val $crystal_min {
                set crystal_min_abc [lindex $crystal_min $index]
                set min_c [lindex $crystal_min_abc 2]
                if {$min_c<$crystal_min_c} {
                        set crystal_min_c $min_c
                }
		incr index
        }

	set crystal_max_abc_first [lindex $crystal_max 0]
	set crystal_max_a [lindex $crystal_max_abc_first 0]
	set index 0
	foreach val $crystal_max {
                set crystal_max_abc [lindex $crystal_max $index]
                set max_a [lindex $crystal_max_abc 0]
                if {$max_a>$crystal_max_a} {
                        set crystal_max_a $max_a
                }
		incr index
        }

	set index 0
        set crystal_max_b [lindex $crystal_max_abc_first 1]
        foreach val $crystal_max {
                set crystal_max_abc [lindex $crystal_max $index]
                set max_b [lindex $crystal_max_abc 1]
                if {$max_b>$crystal_max_b} {
                        set crystal_max_b $max_b
                }
		incr index
        }

	set index 0
        set crystal_max_c [lindex $crystal_max_abc_first 2]
        foreach val $crystal_max {
                set crystal_max_abc [lindex $crystal_max $index]
                set max_c [lindex $crystal_max_abc 2]
                if {$max_c>$crystal_max_c} {
                        set crystal_max_c $max_c
                }
		incr index
        }

	set crystal_a_difference [expr $crystal_max_a - $crystal_min_a]
	set crystal_b_difference [expr $crystal_max_b - $crystal_min_b]
	set crystal_c_difference [expr $crystal_max_c - $crystal_min_c]

	set new_crystal_a [format "%9.3f" $crystal_a_difference]
	set new_crystal_b [format "%9.3f" $crystal_b_difference]
	set new_crystal_c [format "%9.3f" $crystal_c_difference]	

        #get all cryst1
        foreach val $thesefile {
		set is_which_file [file extension $val]
		if {$is_which_file==".pdb"} {
			lappend atom_number_list "pdb"
		}
		if {$is_which_file==".gro"} {
			lappend atom_number_list "gro"
		}
		if {$is_which_file==".mol2"} {
			lappend atom_number_list "mol2"
		}
        }

        set alpha [format "%7.2f" $alpha_int]
        set beta [format "%7.2f" $beta_int]
        set gamma [format "%7.2f" $gamma_int]

        set cryst_first [lindex $cryst 0]
        set cryst_end [string range $cryst_first 54 end]
        set cryst1 [format "CRYST1%s%s%s%s%s%s%s" $new_crystal_a $new_crystal_b $new_crystal_c $alpha $beta $gamma $cryst_end]
        puts $f $cryst1
        close $f

	set atom_number 1
        set f [open $pdbfile a]
	set index 0
        foreach val $thesefile_new {
                set fd [open $val r]
                set row 0

		set number_limit [lindex $atom_number_list $index]

		if {$number_limit=="gro"} {
			while {[eof $fd]!=1} {
				incr row
				gets $fd line
				set sense_atom [string first $find_atom $line]
				if {$sense_atom==0} {
					set newline $line
					set atomnumber_next [format "%5d" $atom_number]
					set atom [string replace $newline 6 10 $atomnumber_next]
					puts $f $atom
					incr atom_number
				}
			}
			close $fd
			incr index
		}

		if {$number_limit=="mol2"} {
			while {[eof $fd]!=1} {
				incr row
				gets $fd line
				set sense_atom [string first $find_atom $line]
				if {$sense_atom==0} {
					set newline $line
					set atomnumber_next [format "%5d" $atom_number]
					set atom [string replace $newline 6 10 $atomnumber_next]
					puts $f $atom
					incr atom_number
				}
			}
			close $fd
			incr index
		}

		if {$number_limit!="gro"&&$number_limit!="mol2"} {
			while {[eof $fd]!=1} {
                                incr row
                                gets $fd line
                                set sense_atom [string first $find_atom $line]
                                if {$sense_atom==0} {
                                        set newline $line
                                        set atomnumber_next [format "%5d" $atom_number]
                                        set atom [string replace $newline 6 10 $atomnumber_next]
                                        puts $f $atom
                                        incr atom_number
                                }
                        }
			close $fd
			incr index
		}
	}
	close $f

	set f_end [open $pdbfile a]
        set ter "TER"
        puts $f_end $ter
        close $f_end

	#delete new files
	foreach val $thesefile_new {
		file delete $val
	}
}
proc ::Molcontrl::logfile {name1 name2 op} {
	global vmd_logfile_channel
	global vmd_logfile

	if {[string equal $vmd_logfile_channel stdout]} {
		vmdcon -info $vmd_logfile
	}
}
trace variable vmd_logfile w ::Molcontrl::logfile 
proc molcontroller_tk {} {
        ::Molcontrl::textview
        return $::Molcontrl::w
}
