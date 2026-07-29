# app-openvpn

遠隔接続サーバーをコンテナで動かすためのリポジトリです。
設定と永続データはリポジトリの外へ置けるため、別のパソコンでも同じ手順で起動できます。

## 使い方

```bash
cp .env.example .env.local
./scripts/init-data-dirs.sh
docker compose --env-file .env.local up -d
./scripts/set-admin-password.sh
```

既定では自動再起動しません。必要な期間だけ起動し、使い終わったら停止します。

```bash
docker compose --env-file .env.local stop
```

管理画面:

- 管理者画面: `https://localhost:943`
- 利用者画面: `https://localhost:9443`

## 変更する値

`.env.example` は公開用の見本です。実際の値は `.env.local` に書きます。

- `HOST_DATA_DIR`: 遠隔接続サーバーの設定を保存する場所です。
- `RESTART_POLICY`: 既定は `no` です。常時運用する場合だけ
  `unless-stopped` へ変更します。
- `OPENVPN_ADMIN_PASSWORD`: 管理者 `admin` のパスワードです。必ず変更します。
- `INTERFACE`: 遠隔接続が使うホスト側のネットワーク名です。パソコンによって変わります。
- `APP_OPENVPN__...`: 親リポジトリからまとめて設定するときに使います。

## データ

公開リポジトリに上げるもの:

- `compose.yaml`
- `.env.example`
- `scripts/`
- `README.md`

公開リポジトリに上げないもの:

- `.env.local`
- `data/`

既存環境から移す場合は、旧 `openvpn` ディレクトリを `HOST_DATA_DIR` に指定します。

## 補足

- リバースプロキシ連携は親リポジトリ側の設定で扱います。
- 既存の `/config` を引き継ぐ場合、管理者パスワードを空にしておけば既存ユーザー情報を維持できます。
