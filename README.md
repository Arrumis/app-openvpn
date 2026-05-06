# app-openvpn

OpenVPN Access Server を Docker で動かすためのリポジトリです。
設定と永続データはリポジトリの外へ置けるため、別のパソコンでも同じ手順で起動できます。

## 使い方

```bash
cp .env.example .env.local
./scripts/init-data-dirs.sh
docker compose --env-file .env.local up -d
./scripts/set-admin-password.sh
```

管理画面:

- 管理者画面: `https://localhost:943`
- 利用者画面: `https://localhost:9443`

## 変更する値

`.env.example` は公開用の見本です。実際の値は `.env.local` に書きます。

- `HOST_DATA_DIR`: OpenVPN の設定を保存する場所です。
- `OPENVPN_ADMIN_PASSWORD`: 管理者 `admin` のパスワードです。必ず変更します。
- `INTERFACE`: VPN が使うホスト側のネットワーク名です。パソコンによって変わります。
- `APP_OPENVPN__...`: 親リポジトリからまとめて設定するときに使います。

## データ

GitHub に上げるもの:

- `compose.yaml`
- `.env.example`
- `scripts/`
- `README.md`

GitHub に上げないもの:

- `.env.local`
- `data/`

既存環境から移す場合は、旧 `openvpn` ディレクトリを `HOST_DATA_DIR` に指定します。

## 補足

- リバースプロキシ連携は親リポジトリ側の設定で扱います。
- 既存の `/config` を引き継ぐ場合、管理者パスワードを空にしておけば既存ユーザー情報を維持できます。
