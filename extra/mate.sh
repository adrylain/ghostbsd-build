#!/bin/sh

set -e -u

. "${cwd}/extra/common-live-setting.sh"
. "${cwd}/extra/common-base-setting.sh"
. "${cwd}/extra/finalize.sh"
. "${cwd}/extra/autologin.sh"
. "${cwd}/extra/gitpkg.sh"
. "${cwd}/extra/setuser.sh"

lightdm_setup()
{
  sed -i '' "s@#greeter-session=example-gtk-gnome@greeter-session=slick-greeter@" "${release}/usr/local/etc/lightdm/lightdm.conf"
  sed -i '' "s@#user-session=default@user-session=mate@" "${release}/usr/local/etc/lightdm/lightdm.conf"
}

setup_xinit()
{
  echo "exec marco &" > "${release}/usr/home/${liveuser}/.xinitrc"
  echo "exec feh --bg-fill /usr/local/share/backgrounds/ghostbsd/Lake_View.jpg &" >> "${release}/usr/home/${liveuser}/.xinitrc"
  echo "exec sudo install-station" >> "${release}/usr/home/${liveuser}/.xinitrc"
  chmod 765 "${release}/usr/home/${liveuser}/.xinitrc"
  # root
  echo "exec marco &" > "${release}/root/.xinitrc"
  echo "exec feh --bg-fill /usr/local/share/backgrounds/ghostbsd/Lake_View.jpg &" >> "${release}/root/.xinitrc"
  echo "exec setup-station" >> "${release}/root/.xinitrc"
}

set_live_system
patch_etc_files

git_pc_sysinstall
git_gbi
git_install_station
git_setup_station

lightdm_setup
setup_xinit

ghostbsd_setup_liveuser
ghostbsd_setup_autologin
final_setup