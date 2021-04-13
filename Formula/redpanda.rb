class Redpanda < Formula
    desc "Fastest Queue in the West"
    homepage "https://www.vectorized.io"
    url "https://github.com/vectorizedio/redpanda/releases/download/v21.4.8/rpk-darwin-amd64.zip"
    version "21.4.8"
    sha256 "05e0a2b0c36c1345d16f54ca3e8ad3c007e233b5ebcf199737b643a2c3f48b20"

    bottle :unneeded

    def install
        bin.install "rpk"
    end

    def caveats; <<~EOS
        Redpanda - The fastest queue in the west!

        This installs RPK which, with Docker, enables the running of a local cluster 
        for testing purposes.

        You can start a 3 node cluster locally using the following command: 

            rpk container start -n 3
        
        You can then interact with the cluster using commands like the following: 

            rpk api status
        
        When done, you can stop and delete the cluster with the following command:
            
            rpk container purge

        For information on how to setup production evironments, check out our
        installation guide here: https://vectorized.io/documentation/setup-guide/
    EOS
    end
end
