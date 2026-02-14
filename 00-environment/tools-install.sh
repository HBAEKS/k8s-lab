#!/usr/bin/env bash
set -Eeuo pipefail

log()  { echo -e "\033[1;32m[INFO]\033[0m $*"; }
warn() { echo -e "\033[1;33m[WARN]\033[0m $*"; }
err()  { echo -e "\033[1;31m[ERR ]\033[0m $*"; }

need_cmd() { command -v "$1" >/dev/null 2>&1 || { err "필수 명령어가 없습니다: $1"; exit 1; }; }

is_wsl() { grep -qiE "microsoft|wsl" /proc/version 2>/dev/null; }

trap 'err "설치 중 오류가 발생했습니다. (line: $LINENO)"; exit 1' ERR

install_docker() {
  if command -v docker >/dev/null 2>&1; then
    log "Docker 이미 설치됨: $(docker --version || true)"
    return
  fi

  log "Docker Engine 설치 (공식 repo)"
  sudo install -m 0755 -d /etc/apt/keyrings
  if [[ ! -f /etc/apt/keyrings/docker.gpg ]]; then
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
      | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
  fi

  local arch codename
  arch="$(dpkg --print-architecture)"
  codename="$(. /etc/os-release && echo "${VERSION_CODENAME}")"

  if [[ ! -f /etc/apt/sources.list.d/docker.list ]]; then
    echo "deb [arch=${arch} signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu ${codename} stable" \
      | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
  fi

  sudo apt-get update -y
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  log "Docker 그룹 설정"
  sudo groupadd -f docker
  if ! id -nG "$USER" | grep -qw docker; then
    sudo usermod -aG docker "$USER"
    warn "현재 사용자($USER)가 docker 그룹에 추가되었습니다. 새 로그인/새 셸에서 적용됩니다."
  fi

  if command -v systemctl >/dev/null 2>&1; then
    sudo systemctl enable --now docker >/dev/null 2>&1 || true
  else
    warn "systemctl 미사용 환경입니다. Docker 데몬이 실행 중인지 확인하세요."
  fi
}

install_kubectl() {
  if command -v kubectl >/dev/null 2>&1; then
    log "kubectl 이미 설치됨: $(kubectl version --client 2>/dev/null | head -n 1 || true)"
    return
  fi

  log "kubectl 설치 (공식 Kubernetes repo)"
  sudo install -m 0755 -d /etc/apt/keyrings
  if [[ ! -f /etc/apt/keyrings/kubernetes-apt-keyring.gpg ]]; then
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key \
      | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
    sudo chmod a+r /etc/apt/keyrings/kubernetes-apt-keyring.gpg
  fi

  if [[ ! -f /etc/apt/sources.list.d/kubernetes.list ]]; then
    echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /" \
      | sudo tee /etc/apt/sources.list.d/kubernetes.list >/dev/null
  fi

  sudo apt-get update -y
  sudo apt-get install -y kubectl
}

install_kind() {
  if command -v kind >/dev/null 2>&1; then
    log "kind 이미 설치됨: $(kind --version || true)"
    return
  fi

  log "kind 설치 (GitHub 릴리즈 바이너리)"
  local arch url tmp kind_version
  arch="$(uname -m)"
  case "$arch" in
    x86_64|amd64) arch="amd64" ;;
    aarch64|arm64) arch="arm64" ;;
    *) err "지원하지 않는 아키텍처: $arch"; exit 1 ;;
  esac

  kind_version="v0.24.0"
  url="https://github.com/kubernetes-sigs/kind/releases/download/${kind_version}/kind-linux-${arch}"

  tmp="$(mktemp)"
  curl -fsSL "$url" -o "$tmp"
  sudo install -m 0755 "$tmp" /usr/local/bin/kind
  rm -f "$tmp"
}

post_checks() {
  log "설치 검증"
  docker --version
  kubectl version --client
  kind --version

  if docker ps >/dev/null 2>&1; then
    log "docker ps OK"
  else
    warn "docker ps 실패: 그룹 권한 반영 전일 수 있습니다."
    warn "해결: 'newgrp docker' 또는 새 터미널에서 재시도"
  fi
}

main() {
  log "k8s-lab tools installer 시작"
  if is_wsl; then log "환경 감지: WSL"; else warn "WSL이 아닌 환경으로 보입니다."; fi

  need_cmd apt-get
  need_cmd curl
  need_cmd gpg

  sudo -v
  sudo apt-get update -y
  sudo apt-get install -y ca-certificates curl gnupg lsb-release apt-transport-https

  install_docker
  install_kubectl
  install_kind
  post_checks

  log "완료 ✅"
  echo "필요 시: newgrp docker"
}

main "$@"
