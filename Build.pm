use v6;
use Panda::Builder;

# for panda only
# tests require cloning atweiden/finn-examples into t/data
class Build is Panda::Builder
{
    method build($workdir)
    {
        run qw<git clone https://github.com/atweiden/finn-examples t/data>;
    }
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
