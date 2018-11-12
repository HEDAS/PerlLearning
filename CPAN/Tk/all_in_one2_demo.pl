#!E:\Software\Strawberry\perl\bin\perl.exe -w
use strict;
use warnings FATAL => 'all';
$| = 1; # 立即刷新缓冲区，直接输出

# ======================================================================================================================
# File Description
# 功能：中级小部件
# 说明：完整运用所有部件
# 作者：cucud
# 时间：2018/11/11 17:18
# ======================================================================================================================
use Tk;

my $ver = "1.0.0";

my $mw = MainWindow->new;
$mw->geometry("500x150");
$mw->title("All-In-One Demo #2");

# ======================================================================================================================
# 菜单栏
my $main_menu = $mw->Menu();
$mw->configure(-menu => $main_menu);

# give the user a way to exit the script
my $file_menu = $main_menu->cascade(
    -label     => "File",
    -underline => 0,
    -tearoff   => 0
);

$file_menu->command(
    -label     => "Exit",
    -underline => 0,
    -command   => sub { exit }
);

# everyone needs a little help
my $help_menu = $main_menu->cascade(
    -label     => "Help",
    -underline => 0,
    -tearoff   => 0
);

$help_menu->command(
    -label     => "Version",
    -underline => 0,
    -command   => sub {
        $mw->messageBox(
            -message => "Version: $ver",
            -type    => "ok"
        )
    }
);

$help_menu->command(
    -label     => "About Program",
    -underline => 0,
    -command   => \&show_about
);

# ======================================================================================================================
# greeting框架
my $greeting_frame = $mw->
    Frame()->
    pack(-side => "top");

$greeting_frame->
    Label(-text => "Tell me a little about yourself...")->
    pack();

# ======================================================================================================================
# info框架
my $info_frame = $mw->
    Frame()->
    pack(-side => "top");

my $last_name = $info_frame->
    Entry()->
    pack(-side => "right");

$info_frame->
    Label(-text => "Last Name")->
    pack(-side => "right");

my $stat = "Mr";
$info_frame->
    Radiobutton(
    -text     => "Mr",
        -value    => "Mr",
        -variable => \$stat)->
    pack(-side => "right");

$info_frame->
    Radiobutton(
    -text     => "Mrs",
        -value    => "Mrs",
        -variable => \$stat)->
    pack(-side => "right");

$info_frame->
    Radiobutton(
    -text     => "Miss",
        -value    => "Miss",
        -variable => \$stat)->
    pack(-side => "right");

# ======================================================================================================================
# pet info框架
my $pet_info_frame = $mw->
    Frame()->
    pack(-side => "top");

$pet_info_frame->
    Label(-text => "Check all pets you like?")->
    pack(-side => "left");

my $chk1 = "no";
my $chk2 = "no";
my $chk3 = "no";
my $chk4 = "no";
my $chk5 = "no";

my $pet1_chk = $pet_info_frame->
    Checkbutton(
        -text     => "Cat",
        -variable => \$chk1,
        -onvalue  => "yes",
        -offvalue => "no")->
    pack(-side => "right");

my $pet2_chk = $pet_info_frame->
    Checkbutton(
        -text     => "Dog",
        -variable => \$chk2,
        -onvalue  => "yes",
        -offvalue => "no")->
    pack(-side => "right");

my $pet3_chk = $pet_info_frame->
    Checkbutton(
        -text     => "Fish",
        -variable => \$chk3,
        -onvalue  => "yes",
        -offvalue => "no")->
    pack(-side => "right");

my $pet4_chk = $pet_info_frame->
    Checkbutton(
        -text     => "Snake",
        -variable => \$chk4,
        -onvalue  => "yes",
        -offvalue => "no")->
    pack(-side => "right");

my $pet5_chk = $pet_info_frame->
    Checkbutton(
        -text     => "Hamster",
        -variable => \$chk5,
        -onvalue  => "yes",
        -offvalue => "no")->
    pack(-side => "right");

# ======================================================================================================================
# button框架
my $button_frame = $mw->
    Frame()->
    pack(-side => "top");

$button_frame->
    Button(
    -text    => "Ok",
        -command => \&update_output)->
    pack();

# ======================================================================================================================
# output框架
my $output_frame = $mw->
    Frame()->
    pack(-side => "bottom");

my $output_scroll = $output_frame->
    Scrollbar();

my $output_text = $output_frame->
    Text(-yscrollcommand => [ 'set', $output_scroll ]);

$output_scroll->configure(-command => [ 'yview', $output_text ]);

$output_scroll->
    pack(
        -side   => "right",
        -expand => "no",
        -fill   => "y"
    );

$output_text->pack();

sub update_output {
    my $lname = $last_name->get();
    if($lname eq "") { $lname = "No Name"; }
    my $output = "Hello $stat. $lname!\nI like the following too!";
    if($chk1 eq "yes") { $output = "$output\nCats"; }
    if($chk2 eq "yes") { $output = "$output\nDogs"; }
    if($chk3 eq "yes") { $output = "$output\nFish"; }
    if($chk4 eq "yes") { $output = "$output\nSnakes"; }
    if($chk5 eq "yes") { $output = "$output\nHamsters"; }

    $output_text->delete('0.0', 'end');
    $output_text->insert("end", $output);       # 从头输入
}

sub show_about {
    my $help_win = $mw->Toplevel;
    $help_win->geometry("300x50");
    $help_win->title("About Program");

    my $help_msg = "This help page is an example of using multiple windows.";
    $help_win->
        Label(-text => $help_msg)->
        pack();
    $help_win->
        Button(-text => "Ok", -command => [ $help_win => 'destroy' ])->
        pack();
}

# ======================================================================================================================
MainLoop;