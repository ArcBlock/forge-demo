defmodule CoreTx.Blog do
  defmodule Rpc do
    @moduledoc false
    def create_blog(tilte, content, tags, opts) do
      # sanity check is skipped...
      data =
        ForgeSdk.encode_any!(ForgeAbi.BlogInfo.new(title: tilte, content: content, tags: tags))

      itx = ForgeAbi.CreateAssetTx.new(readonly: false, transferrable: true, data: data)
      ForgeSdk.create_asset(itx, opts)
    end
  end
end
