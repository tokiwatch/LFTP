# $Id$

package LFTP::CMS;

use strict;

sub plugin {
    return MT->component('LFTP');
}


sub get_config {
   my $plugin = plugin();
   my ($key, $blog_id) = @_;
   die "no blog id." unless $blog_id;
   my $scope = $blog_id ? 'blog:'.$blog_id : 'system';
   my %plugin_param;
   $plugin->load_config(\%plugin_param, $scope);
   my $value = $plugin_param{$key};
   $value;
}

sub menu_status {
   my ($plugin) = @_;
   my $blog = MT->instance->blog;
   my $plugin_status = get_config("lftp_enabled",$blog->id);
   return $plugin_status;
}


sub view {
    my $app = shift;
    my (%opt) = @_;

    my $q = $app->{query};
    my $blog_id = scalar $q->param('blog_id');

    my $tmpl = $app->load_tmpl('view.tmpl');
    $tmpl->param('blog_id'  => $blog_id);
    $app->add_breadcrumb($app->translate("Main Menu"),$app->{mtscript_url});
    require MT::Blog;
    my $blog = MT::Blog->load ($blog_id);
    $app->add_breadcrumb($blog->name,$app->mt_uri( mode => 'menu', args => { blog_id => $blog_id }));
    $app->add_breadcrumb($app->translate("LFTP"));

    $tmpl->param(breadcrumbs       => $app->{breadcrumbs});
    return $app->build_page($tmpl);
}

sub do_upload {
   my $app = shift;
   $app->validate_magic()
       or return;
   my $q = $app->param;
   my $dryrun = $q->param('dryrun');
   my $param = {
       return_args => '__mode=lftp_view',
       dryrun => $dryrun,
   };
   my $result = upload($app);
   return $result;
}

sub upload {
    my ($app) = @_;
    my $q = $app->param;
    my $blog_id    = $q->param('blog_id');
    my $dryrun     = $q->param('dryrun');
    my $cmd        = get_config('lftp_cmd', $blog_id);
    die unless $cmd;
    my $host       = get_config('lftp_host',$blog_id);
    die unless $host;
    my $method     = get_config('lftp_method',$blog_id);
    die unless $method;
    my $port       = get_config('lftp_port', $blog_id);
    die unless $port;
    my $user       = get_config('lftp_user', $blog_id);
    die unless $user;
    my $password   = get_config('lftp_password', $blog_id);
    die unless $password;
    my $local_dir  = get_config('lftp_local_dir', $blog_id);
    die unless $local_dir;
    my $remote_dir = get_config('lftp_remote_dir', $blog_id);
    die unless $remote_dir;

    my $setting    = get_config('lftp_setting', $blog_id);
    my $mirror_opt = get_config('lftp_mirror_opt', $blog_id);

    my $ssh_opt_str;
    $ssh_opt_str = "$setting;" if $setting;

    my $open_cmd =  "open -u $user,\'$password\' -p $port $method:\/\/$host;";
    my $mirror_cmd = "mirror --reverse --only-newer --delete --no-perms --no-umask $mirror_opt";

    if ($dryrun) {
        $mirror_cmd = $mirror_cmd . ' --dry-run ';
    } else {
        $mirror_cmd = $mirror_cmd . ' --verbose ';
    }

    $mirror_cmd = "$mirror_cmd $local_dir $remote_dir;";

    my $system_cmd;
    $system_cmd = "$cmd -c \"$ssh_opt_str $open_cmd $mirror_cmd\" ";

    my $sys_result = `$system_cmd  2>&1`;
    $sys_result =~ s/$password/********/g;
    $system_cmd =~ s/$password/********/g;

    unless ($dryrun) {
        use MT::Log;
        my $log = MT::Log->new;
        $log->blog_id($blog_id);
        $log->author_id($app->user->id);
        $log->message($system_cmd . " " . $sys_result);
        $log->save or die $log->errstr;
    }

    return $sys_result;
}

1;
