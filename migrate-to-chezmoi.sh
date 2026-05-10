#!/bin/bash
# Migrate dotfiles from symlink-based setup to chezmoi

set -euo pipefail

DOTFILES_HOME="${HOME}/.dotfiles/HOME"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info()    { echo -e "${GREEN}[INFO]${NC} $*"; }
warn()    { echo -e "${YELLOW}[WARN]${NC} $*"; }
error()   { echo -e "${RED}[ERROR]${NC} $*"; exit 1; }

# ─── 1. chezmoi インストール ───────────────────────────────────────────────────
if ! command -v chezmoi &>/dev/null; then
    info "Installing chezmoi..."
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "${HOME}/.local/bin"
    export PATH="${HOME}/.local/bin:${PATH}"
fi

CHEZMOI_VERSION=$(chezmoi --version)
info "Using ${CHEZMOI_VERSION}"

# ─── 2. chezmoi init ───────────────────────────────────────────────────────────
CHEZMOI_DIR=$(chezmoi source-path 2>/dev/null || true)

if [ -z "${CHEZMOI_DIR}" ] || [ ! -d "${CHEZMOI_DIR}" ]; then
    info "Initializing chezmoi source directory..."
    chezmoi init
    CHEZMOI_DIR=$(chezmoi source-path)
fi

info "chezmoi source: ${CHEZMOI_DIR}"

# ─── 3. 既存の run_ スクリプトを生成 ──────────────────────────────────────────
# devcontainer セットアップを chezmoi の run_ スクリプトに変換
RUN_SCRIPT="${CHEZMOI_DIR}/run_onchange_devcontainer-setup.sh"
if [ ! -f "${RUN_SCRIPT}" ]; then
    info "Creating devcontainer run script..."
    cat > "${RUN_SCRIPT}" << 'EOF'
#!/bin/bash
# chezmoi run script: install extra tools in devcontainer
# hash: {{ include ".devcontainer-setup.sh" | sha256sum }}

if [ -f "/.dockerenv" ] || [ -n "${REMOTE_CONTAINERS:-}" ] || [ -n "${DEVCONTAINER:-}" ]; then
    echo "devcontainer detected, installing extra tools..."
    if [ ! -d "${HOME}/.fzf" ]; then
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install
    fi
fi
EOF
    chmod +x "${RUN_SCRIPT}"
fi

# ─── 4. ファイルを chezmoi に追加 ─────────────────────────────────────────────
info "Adding dotfiles to chezmoi..."

# SSH ディレクトリの扱いを確認
echo
warn "SSH files (.ssh/) を chezmoi に追加します。"
warn "秘密鍵など機密ファイルは .gitignore または chezmoi encrypt で管理してください。"
echo

ADDED=0
SKIPPED=0
ERRORS=0

while IFS= read -r -d '' src_file; do
    rel="${src_file#${DOTFILES_HOME}/}"
    home_file="${HOME}/${rel}"

    # シンボリックリンクまたはファイルが存在するか確認
    if [ ! -e "${home_file}" ] && [ ! -L "${home_file}" ]; then
        warn "Skipping (not in HOME): ${rel}"
        (( SKIPPED++ )) || true
        continue
    fi

    if chezmoi add --follow "${home_file}" 2>/dev/null; then
        info "  Added: ~/${rel}"
        (( ADDED++ )) || true
    else
        warn "  Failed: ~/${rel}"
        (( ERRORS++ )) || true
    fi
done < <(find "${DOTFILES_HOME}" -type f -print0 | sort -z)

# ─── 5. .chezmoiignore を生成 ──────────────────────────────────────────────────
IGNORE_FILE="${CHEZMOI_DIR}/.chezmoiignore"
if [ ! -f "${IGNORE_FILE}" ]; then
    info "Creating .chezmoiignore..."
    cat > "${IGNORE_FILE}" << 'EOF'
# SSH private keys (manage manually or with chezmoi encrypt)
.ssh/id_*
.ssh/conf.d/*.conf
!.ssh/conf.d/template.conf
EOF
fi

# ─── 6. 結果サマリ ────────────────────────────────────────────────────────────
echo
echo "────────────────────────────────────────"
info "Migration complete!"
echo "  Added:   ${ADDED} files"
echo "  Skipped: ${SKIPPED} files"
echo "  Errors:  ${ERRORS} files"
echo "────────────────────────────────────────"
echo
info "次のステップ:"
echo "  1. chezmoi diff              # 変更内容を確認"
echo "  2. chezmoi cd                # source ディレクトリに移動"
echo "  3. git init && git remote add origin <your-repo>"
echo "  4. chezmoi apply             # 適用"
echo
info "既存の .dotfiles/install.sh は install-legacy.sh に残してあります。"
info "動作確認後、不要であれば削除してください。"

# install.sh をバックアップ
if [ -f "${HOME}/.dotfiles/install.sh" ] && [ ! -f "${HOME}/.dotfiles/install-legacy.sh" ]; then
    cp "${HOME}/.dotfiles/install.sh" "${HOME}/.dotfiles/install-legacy.sh"
fi
