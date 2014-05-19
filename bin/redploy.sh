#! /bin/bash

echo "Prepare the tiny machines!"
echo "New Package is at " $1
echo ""
echo "Setup the the nfsroot"
echo ""
echo ""
echo "Remove old link"
rm -v ~/nfsroot/targetfs
echo "Old link removed"
echo ""
echo ""
echo "Create new link"
ln -v -s $1/ti/targetfs ~/nfsroot/targetfs
echo "New link created"
echo ""
echo "Create new link"
echo "Export the new nfsroot"
sudo exportfs -av
echo "New nfsroot has been exported"
echo ""
echo "Create new link"
echo "Copy uImage and bdrse_j6.dtb to tftboot"
cp -fv ~/nfsroot/targetfs/boot/uImage /tftpboot/xorn/uImage
cp -fv ~/nfsroot/targetfs/boot/bdrse_j6.dtb /tftpboot/xorn/bdrse_j6.dtb
echo "Files have been copied\n\n"
echo ""
echo "You are now ready to run"
echo ""
