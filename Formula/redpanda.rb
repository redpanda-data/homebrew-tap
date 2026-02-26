# typed: false
# frozen_string_literal: true

# This file was generated from a template file redpanda.rb.tmpl. DO NOT EDIT.
class Redpanda < Formula
  desc "Redpanda CLI & toolbox"
  homepage "https://redpanda.com"
  version "25.3.9"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/redpanda-data/redpanda/releases/download/v25.3.9/rpk-darwin-amd64.zip"
      sha256 "d327dcc6eb40f3b351449dfffc58c52002717fbf7bd05248409402f350af1be5"
    end
    if Hardware::CPU.arm?
      url "https://github.com/redpanda-data/redpanda/releases/download/v25.3.9/rpk-darwin-arm64.zip"
      sha256 "0708cb64105e2aa93ba78d08a077555006e21467f1c4ea9bc67e70c7ef4de906"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/redpanda-data/redpanda/releases/download/v25.3.9/rpk-linux-arm64.zip"
      sha256 "75826a3f0ab312c6e7d27ca6529b00a1a9c88c605baee91e6269a3d3cc2f010f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/redpanda-data/redpanda/releases/download/v25.3.9/rpk-linux-amd64.zip"
      sha256 "ec6a5e6ae53ad352661f48c46f548a484e505c5f1101c57fffdc6145187c84bd"
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
