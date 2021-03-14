#!/bin/sh
#
# this script will be execute by venom-installer to do some stuffs
# after venom is installed
#
 
VIROOTFS=${VIROOTFS:-/run/initramfs/medium/virootfs/}
VENOMROOTFS=${VENOMROOTFS:-/tmp/venominstall}
 
# copy over all customs configs and customization except some unnecessary files
for i in $(find $VIROOTFS -type f | sed "s,$VIROOTFS,,"); do
    case $i in
        *venom-installer*|*custom_script.sh|*fstab|*issue|*venominstaller.desktop) continue;;
    esac
    install -D $VIROOTFS/$i $VENOMROOTFS/$i
done

# change slim theme
sed 's/current_theme.*/current_theme typogin/' -i $VENOMROOTFS/etc/slim.conf

# remove install venom entry from ob menu
sed '/Install Venom/d' -i $VENOMROOTFS/etc/skel/.config/obmenu-generator/schema.pl

exit 0