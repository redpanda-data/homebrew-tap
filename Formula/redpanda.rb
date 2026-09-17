# typed: false
# frozen_string_literal: true

# This file was generated from a template file redpanda.rb.tmpl. DO NOT EDIT.
class Redpanda < Formula
  desc "Redpanda CLI & toolbox"
  homepage "https://redpanda.com"
  version "26.2.3"

  on_macos do
    if Hardware::CPU.intel?
      url "https://rpk.redpanda.com/v26.2.3/rpk-darwin-amd64.zip"
      sha256 "2fdafde66ed883516de3cb12bbbbba4fb56af8153988d4a7d0c8088112fd65ec"
    end
    if Hardware::CPU.arm?
      url "https://rpk.redpanda.com/v26.2.3/rpk-darwin-arm64.zip"
      sha256 "aebbeb35dfa90bfb281a9a7b62dc7e564ee5dd9729669ef55299d62822c729c2"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://rpk.redpanda.com/v26.2.3/rpk-linux-arm64.zip"
      sha256 "27c66787e9a8a54c81121afe4acf2214005a17facf788acf662a7e3f482eff49"
    end
    if Hardware::CPU.intel?
      url "https://rpk.redpanda.com/v26.2.3/rpk-linux-amd64.zip"
      sha256 "ae59144c9bd5e849dcf719dfd2effb2e999db641f134aece5d7aab12b2d8ab22"
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
