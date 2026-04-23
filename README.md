# app-openvpn

OpenVPN AS を独立リポジトリとして扱うための新しい正本候補です。管理者パスワードや永続データを repo 外に逃がし、repo 単独で起動できる形にしています。

## 起動

```bash
cp .env.example .env.local
./scripts/init-data-dirs.sh
docker compose --env-file .env.local up -d
./scripts/set-admin-password.sh
```

管理画面:

- Admin UI: `https://localhost:943`
- Client UI: `https://localhost:9443`

## 管理対象

Git に含めるもの:

- `compose.yaml`
- `.env.example`
- `scripts/`
- `README.md`

Git に含めないもの:

- `.env.local`
- `data/config/`

## 初期化

```bash
./scripts/init-data-dirs.sh
```

## 管理者パスワード

```bash
./scripts/set-admin-password.sh
```

`.env.local` の `OPENVPN_ADMIN_PASSWORD` を利用して `admin` ユーザーへ設定します。失敗した場合は手動で `passwd admin` を実行してください。

## 補足

- 旧構成の external network / 固定 IP はベース compose から外しています
- reverse proxy 連携が必要なら別 override file で追加する方針です

