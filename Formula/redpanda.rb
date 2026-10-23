# typed: false
# frozen_string_literal: true

# This file was generated from a template file redpanda.rb.tmpl. DO NOT EDIT.
class Redpanda < Formula
  desc "Redpanda CLI & toolbox"
  homepage "https://redpanda.com"
  version "26.2.6"

  on_macos do
    if Hardware::CPU.intel?
      url "https://rpk.redpanda.com/v26.2.6/rpk-darwin-amd64.zip"
      sha256 "624a2e0663564475b966ac3a5340a75d2bd6888e3fd9f94cac055a310640f6d6"
    end
    if Hardware::CPU.arm?
      url "https://rpk.redpanda.com/v26.2.6/rpk-darwin-arm64.zip"
      sha256 "b8218c3b775ebe24b88c0afc0efcd520861cc6d11c49298ecb18da2a8e1286e7"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://rpk.redpanda.com/v26.2.6/rpk-linux-arm64.zip"
      sha256 "da59df206aafe01df7fc17a96f37fca64e8d0088c7805c1e45ed4c26cd87898d"
    end
    if Hardware::CPU.intel?
      url "https://rpk.redpanda.com/v26.2.6/rpk-linux-amd64.zip"
      sha256 "81a2bdb89f6e919e17c529fff677166735f7a1cb1cf4d919906077061fa4b059"
    end
  end

  head do
    url "https://github.com/redpanda-data/redpanda.git", branch: "dev"
    depends_on "go" => :build
  end

  def install
    if build.head?
      head_rev = Utils.git_short_head
      cd "src/go/rpk" do
        go_bin = Formula["go"].opt_bin/"go"
        ldflags = %W[
          -s -w
          -X github.com/redpanda-data/redpanda/src/go/rpk/pkg/cli/version.buildTime=#{time.iso8601}
          -X github.com/redpanda-data/redpanda/src/go/rpk/pkg/cli/version.rev=#{head_rev}
          -X github.com/redpanda-data/redpanda/src/go/rpk/pkg/cli/version.version=#{version}
        ]
        system go_bin, "build", *std_go_args(output: bin/"rpk", ldflags:), "./cmd/rpk"
      end
    else
      bin.install "rpk"
    end
    generate_completions_from_executable(bin/"rpk", "generate", "shell-completion", base_name: "rpk")
  end

  def caveats
    <<~EOS
      Redpanda Keeper (rpk) is Redpanda's command line interface (CLI)
      utility. The rpk commands let you configure, manage, and tune
      Redpanda clusters. They also let you manage topics, groups,
      and access control lists (ACLs).
      Start a three-node docker cluster locally:

          rpk container start -n 3

      Interact with the cluster using commands like:

          rpk topic list

      When done, stop and delete the docker cluster:

          rpk container purge

      For more examples and guides, visit: https://docs.redpanda.com
    EOS
  end
end
