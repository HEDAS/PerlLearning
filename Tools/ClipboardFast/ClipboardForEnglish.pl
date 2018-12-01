#!E:\Software\Strawberry\perl\bin\perl.exe
use v5.28; # 这个自动打开use strict;了！
use utf8;
use autodie; # open失败会自动启动die
use strict;
use warnings FATAL => 'all';
use diagnostics; # 输出更详细warnings
use Encode;
my $ENCODE = "utf8"; # options: utf8 gbk
binmode(STDIN, ":encoding($ENCODE)");
binmode(STDOUT, ":encoding($ENCODE)");
binmode(STDERR, ":encoding($ENCODE)");
my $TRUE = !!'1';  # 表示真
my $FALSE = !!'0'; # 表示假
$| = 1;            # 立即刷新缓冲区，直接输出，会影响一些效率
$" = "|";          # 输出数组时的分隔符print "@array"; 默认为空格
# 子程序最后的计算表达式为返回值
# say "Program use utf8 encode, binmode use gbk, include <use utf8;>";

# ======================================================================================================================
# File Description
# 功能：英语剪切板
# 说明：快速检测剪切板的内容，如果是英语单词，收集起来。定期提醒复习
# 作者：cucud
# 时间：2018/11/30 23:57
# ======================================================================================================================
# 引入库，定义常量
use Win32::Clipboard;
use LWP;
use LWP::Simple;
use LWP::UserAgent;
use HTTP::Headers;
use HTTP::Cookies;
use HTTP::Response;
use URI::Escape;
use URI::URL;
use JSON;
# 数据
my $eng_db_path = "Tools/ClipboardFast/English/words.txt";
my $eng_update_path = "Tools/ClipboardFast/English/update.txt";
# 更新数据
&update_eng_db();
# 读取数据
my %dictionary = &read_eng_db_in($eng_db_path);
# 开始工作
&wait_for_clip_change();
# ======================================================================================================================
# 更新上一次未收录的单词
sub update_eng_db {
    open(my $words_to_update, "<", $eng_update_path);
    open(my $eng_db, ">>", $eng_db_path);
    while(<$words_to_update>){
        chomp;
        if(defined) {
            print $eng_db "\n"."$_";
            # say $eng_db Encode::decode_utf8(&search_in_netease($_));
            print $eng_db "\n".&search_in_netease($_);
        }
    }
    close($words_to_update);
    close($eng_db);
    # 清空update文件
    open($words_to_update, ">", $eng_update_path);
    close($words_to_update);
}
# ======================================================================================================================
# 读取数据库（文件）中的单词收集库
sub read_eng_db_in {
    my ($db_path) = @_;
    my (%eng_dict);
    if(index($db_path, ".txt") == length($db_path) - 4) {
        # open(my $eng_db, "<encoding(gbk)", $db_path) || die "Can't open English database files.";
        open(my $eng_db, "<", $db_path) || die "Can't open English database files.";
        my $line = 1;
        my $current_word;
        while(<$eng_db>) {
            chomp;
            if($line % 2 == 1) { # 奇数行
                $current_word = $_;
            }
            else {
                if(defined $eng_dict{$current_word}) {
                    $eng_dict{$current_word} .= Encode::decode_utf8(" $_");
                    # $eng_dict{$current_word} .= " $_";
                }
                else {
                    $eng_dict{$current_word} = $_;
                }
            }
            $line++;
        }
        close($eng_db);
        return %eng_dict; # 返回单词字典
    }
    return(); # 空字典
}

# my %eng_dict = &read_eng_db($eng_db_path);
# while (my( $key, $value ) = each %eng_dict) {
#     say "$key => $value";
# }
# ======================================================================================================================
# 等待粘贴板内容变更时
sub wait_for_clip_change {
    my $CLIP = Win32::Clipboard();
    my $word = "Test";
    $CLIP->Empty();
    while(1) {
        $CLIP->WaitForChange(); # 等待直到发生变化，返回1
        # print "Clipboard contains: ", $CLIP->Get(), "\n";

        # 判断是否为英语单词
        $word = $CLIP->Get();
        $word =~ s/\s*$//;
        if($CLIP->IsText()) {

            # 格式化单词
            # my @words = split(/\s+/, $word);
            # foreach (@words){
            #     say $_;
            #     if(/[a-zA-Z0-9_\-]+/) {
            #         say &translate_eng_word($_);
            #     }
            # }

            # 不用格式化了
            say $word;
            say &translate_eng_word($word);
        }
        else {
            next;
        }
    }
}

# print "Clipboard contains: ", $CLIP->Get(), "\n";
# $CLIP->Set("some text to copy into the clipboard");
#
# $CLIP->Empty();
# ======================================================================================================================
# 查找字典，如果没有就调用有道词典API进行翻译
sub translate_eng_word {
    my ($word) = @_;
    chomp($word);
    if($dictionary{$word}) {
        return Encode::decode_utf8($dictionary{$word});
        # return $dictionary{$word};
    }
    else {
        $dictionary{$word} = Encode::encode_utf8("该单词未收录");
        open(my $words_to_update, ">>", $eng_update_path);
        say $words_to_update $word;
        close($words_to_update);
        return "该单词未收录";
    }
}

sub search_in_netease {
    my ($word) = @_;

    # 网络请求
    my $ua = LWP::UserAgent->new;
    $ua->agent("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36");
    # 没有用到cookie
    # my $cookie_jar = HTTP::Cookies->new(
    #     file           => 'lwp_cookies.txt',
    #     autosave       => 1,
    #     ignore_discard => 1);
    # $ua->cookie_jar($cookie_jar);

    my $netease_url = 'http://fanyi.youdao.com/translate?smartresult=dict&smartresult=rule&smartresult=ugc&sessionFrom=null';

    my $res = $ua->post($netease_url,
        {
            'type'       => 'AUTO',
            'i'          => $word,
            'doctype'    => 'json',
            'version'    => '2.1',
            'keyfrom'    => 'fanyi.web',
            'ue'         => 'UTF-8',
            'action'     => 'FY_BY_CLICKBUTTON',
            'typoResult' => 'true',
        }
    );
    # say $res->content();
    my $r = $res->content();

    # 转成utf8格式
    $r = encode_utf8($r);
    my $hash = decode_json($r);
    # print decode_utf8($hash->{"translateResult"}[0][0]{tgt});
    if($hash->{"translateResult"}[0][0]{tgt}) {
        # return decode_utf8($hash->{"translateResult"}[0][0]{tgt});
        return $hash->{"translateResult"}[0][0]{tgt};
    }
    else {
        return "使用网易API未查到该单词";
    }
}
