defmodule CoreTx.Cert do
  defmodule Rpc do
    @moduledoc false
    alias ForgeAbi.CertInfo

    alias Google.Protobuf.Timestamp

    def create(no, title, expired_at, opts) do
      # sanity check is skipped...
      wallet = opts[:wallet]
      seconds = DateTime.to_unix(expired_at)
      ts = Timestamp.new(seconds: seconds)
      cert = CertInfo.new(no: no, title: title, expired_at: ts, signer: wallet.address)
      sig = ForgeSdk.Wallet.Util.sign!(wallet, CertInfo.encode(cert))

      data = ForgeSdk.encode_any!(%{cert | signature: sig})

      itx = ForgeAbi.CreateAssetTx.new(readonly: false, transferrable: true, data: data)
      ForgeSdk.create_asset(itx, opts)
    end
  end
end
