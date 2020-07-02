# Molcontroller

Visual Molecular Dynamics (VMD) is one of the most widely used molecular graphics software in the community of theoretical simulations. So far, however, it still lacks a graphical user interface (GUI) for molecular manipulations when doing some modeling tasks. For instance, translation or rotation of a selected molecule(s) or part(s) of a molecule, which are currently only can be achieved using tcl scripts. Here, we use tcl script develop a user-friendly GUI for VMD, named Molcontroller, which is featured by allowing users to quickly and conveniently perform various molecular manipulations. This GUI might be helpful for improving the modeling efficiency of VMD users.

1. Create a personal plugin directory, recommended as follows:
VMD-Home/plugins/noarch/tcl/molcontroller1.0, where VMD-Home is VMD installation directory. 

2. Download the scripts; archive and extract it in the above directory;

3.	Add the following line in your configuration file of VMD (VMD-Installation-Directory/VMD/vmd.rc in Windows, VMD-Installation-Directory/lib/vmd/.vmdrc in Linux and VMD-Installation-Direcotory/Contents/.vmdrc, respectively):
lappend auto_path VMD- Installation-Directory/plugins/noarch/tcl/molcontroller1.0
vmd_install_extension molcontrol molcontroller_tk "Modeling/Molcontrol"
If the plugin installation is successful, you will see the plugin under Extensions/Modelling/Molcontroller in the VMD menu.
