class Redpanda < Formula
    desc "Redpanda CLI & toolbox"
    homepage "https://redpanda.com"
    url "https://github.com/redpanda-data/redpanda/releases/download/v22.3.1/rpk-darwin-amd64.zip"
    version "22.3.1"
    sha256 "263fb0d3a475eaf50998df2c689557280ef4b5977eb09b10a2144d8ae808a830"

    def install
        bin.install "rpk"
    end

    def caveats; <<~EOS
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

        For more examples and guides, visit: https://docs.redpanda.com/
    EOS
    end
end
