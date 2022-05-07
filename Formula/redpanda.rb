class Redpanda < Formula
    desc "Fastest Queue in the West"
    homepage "https://www.vectorized.io"
    url "https://github.com/redpanda-data/redpanda/releases/download/v22.1.2/rpk-darwin-amd64.zip"
    version "22.1.2"
    sha256 "9acda76a55fc2f03ee008314575acec096cb8844f762dddd2469f7364dfb6472"

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

            rpk topic list
        
        When done, you can stop and delete the cluster with the following command:
            
            rpk container purge

        For information on how to setup production evironments, check out our
        installation guide here: https://vectorized.io/documentation/setup-guide/
    EOS
    end
end
