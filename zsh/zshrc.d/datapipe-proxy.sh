#
# proxy scripts from coliver modified heavily
#

function vpn_test()
{
  VPNSTATUS=$(nmcli -t -f NAME con show --active)
  if [[ "$VPNSTATUS" =~ DataPipeVPN ]]; then
      return 0
  fi
  return 1
}

function vpn_status()
{
  if vpn_test; then
    echo 'vpn is on'
  else
    echo 'vpn is off'
  fi
}

function vpn_off()
{
  local _autossh_pid_path_default="/tmp/datapipe-vpn-autossh.pid"
  local _autossh_pid_path="${DATAPIPE_VPN_PIDFILE:-${_autossh_pid_path_default}}"

  if [[ -n $DATAPIPE_VPN_PID ]]; then
    kill -TERM $DATAPIPE_VPN_PID &>/dev/null
    unset DATAPIPE_VPN_PID
  fi

  if [[ -f "${_autossh_pid_path}" ]]; then
    rm -f "${_autossh_pid_path}" &>/dev/null
  fi

  VPNSTATUS=$(nmcli -t -f NAME con show --active)
  if [[ "$VPNSTATUS" =~ DataPipeVPN ]]; then
      nmcli con down id DataPipeVPN
  fi
}

function vpn_on()
{
  local _autossh_pid_path="/tmp/datapipe-vpn-autossh.pid"

  VPNSTATUS=$(nmcli -t -f NAME con show --active)
  if [[ ! "$VPNSTATUS" =~ DataPipeVPN ]]; then
    nmcli con up uuid 934bb87a-95cc-4b9c-8e85-092bdda940b8
  fi

  env AUTOSSH_LOGLEVEL=1 AUTOSSH_PIDFILE="${_autossh_pid_path}" autossh -f -N -M 20000 -D localhost:8585 ltsp2.int.smq.datapipe.net
  sleep 1

  if [[ -f "${_autossh_pid_path}" ]]; then
    # read the pidfile that autossh creates into a global environment variable
    export DATAPIPE_VPN_PID=$(<"${_autossh_pid_path}")
    export DATAPIPE_VPN_PIDFILE="${_autossh_pid_path}"
  else
    echo "[error] could not read autossh pid file at '${_autossh_pid_path}'"
    unset DATAPIPE_VPN_PID
    unset DATAPIPE_VPN_PIDFILE
  fi
}

function proxy_test()
{
  local proxy_status=$(gsettings get org.gnome.system.proxy mode)
  if [[ ! ${proxy_status} =~ "none" ]]; then
    return 0
  fi
  return 1
}

function proxy_status()
{
  if proxy_test; then
    echo 'proxy is on'
  else
    echo 'proxy is off'
  fi
}

function proxy_on()
{
  gsettings set org.gnome.system.proxy.socks host 'localhost'
  gsettings set org.gnome.system.proxy.socks port 8585
  gsettings set org.gnome.system.proxy ignore-hosts "['localhost', '127.0.0.0/8', '::1', 'development.cms.dpcloud.com', 'development.cloud.datapipe.com']"
  gsettings set org.gnome.system.proxy mode manual

  export SOCKS_SERVER="127.0.0.1"
  export SOCKS_VERSION="5"
  export SOCKS_PORT="8585"
  export no_proxy="localhost, 127.0.0.0/8, development.cms.dpcloud.com, development.cloud.datapipe.com"

  unalias chromium &>/dev/null
  alias chromium='/usr/bin/chromium --proxy-server="socks5://localhost:8585" --host-resolver-rules="MAP * 0.0.0.0, EXCLUDE 127.0.0.1"'
  return 0
}

function proxy_off()
{
  gsettings reset org.gnome.system.proxy.socks host
  gsettings reset org.gnome.system.proxy.socks port
  gsettings reset org.gnome.system.proxy ignore-hosts
  gsettings set org.gnome.system.proxy mode none
  unset SOCKS_SERVER
  unset SOCKS_VERSION
  unset SOCKS_PORT
  unset no_proxy
  unalias chromium &>/dev/null
  return 0
}
