package Apache::AuthChecker;

use Cwd;
use Config;
use Symbol;

require mod_perl;

my $mp_ver = 1;
if ($mod_perl::VERSION >= 1.99) { 
    $mp_ver = 2;
}

my %common_opts = (
    'NAME'              => 'Apache::AuthChecker',
    'VERSION_FROM'      => 'AuthChecker.pm',
    'PREREQ_PM'         => { IPC::Shareable => 0.60 },
    'DEFINE'            => ''

);

if ($mp_ver == 1) {
    require ExtUtils::MakeMaker;
    require Apache::ExtUtils;
    require Apache::src;

    @directives = (
        {
        name => 'PerlAuthCheckerMaxUsers',
        errmsg => 'number of records to store in shared memory',
        args_how => 'TAKE1',
        req_override => 'RSRC_CONF'
        },
        {
        name => 'PerlSecondsToExpire',
        errmsg => 'seconds to remember IP address and AUTH attempts',
        args_how => 'TAKE1',
        req_override => 'RSRC_CONF'
        },
    );

    Apache::ExtUtils::command_table(\@directives);

    ExtUtils::MakeMaker::WriteMakefile(
        'LIBS'		=> [''],
        'INC'		=> Apache::src->new->inc,
        %common_opts,
    );

} else {
    require ModPerl::MM;
    ModPerl::MM::WriteMakefile(
        %common_opts,
    );
}


__END__


