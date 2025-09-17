defmodule Ipv4 do
  def parse(<<
        _ver::4,
        hl::4,
        _tos::8,
        _total_length::16,
        _id::16,
        _ff::16,
        _ttl::8,
        proto::8,
        _check_sumsum::16,
        s1,
        s2,
        s3,
        s4,
        d1,
        d2,
        d3,
        d4,
        rest::binary
      >>) do
    ihl = hl * 4
    opt = max(ihl - 20, 0)

    case rest do
      <<_opts::binary-size(opt), tcp::binary>> ->
        {:ok, {{s1, s2, s3, s4}, {d1, d2, d3, d4}, proto, tcp}}

      _ ->
        :error
    end
  end

  def parse(_), do: :error
end
