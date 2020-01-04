use v6;

# for zef
# tests require cloning atweiden/finn-examples into t/data
class Build
{
    method build($)
    {
        run(qw<git clone https://github.com/atweiden/finn-examples t/data>);
        chdir('t/data');
        run(qw<git checkout 70d39d18a694c17657f8a9923a84d68d50e45df1>);
    }
}

# vim: set filetype=raku foldmethod=marker foldlevel=0:
