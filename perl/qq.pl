#!/usr/bin/env perl
use Mojo::Webqq;
my $client = Mojo::Webqq->new();
$client->load("ShowMsg");
$client->load("IRCShell"); 
$client->on(before_send_message=>sub{
    my($client,$msg) = @_;
    my $content = $msg->content;
    $content .=  "-来自WeeChat";
    $msg->content($content);
});
$client->run();
