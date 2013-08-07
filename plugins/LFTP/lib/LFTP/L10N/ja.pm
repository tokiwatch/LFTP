# $Id$

package LFTP::L10N::ja;

use strict;
use base 'LFTP::L10N::en_us';
use vars qw( %Lexicon );

## The following is the translation table.

%Lexicon = (

    # config panel
    'description of LFTP'   => '他のサーバにファイルを転送します。',
    'LFTP enabled:'         => 'プラグインを利用する',
    'LFTP cmd:'             => 'LFTPコマンドのPath(必須)',
    'LFTP method:'          => '接続方式(必須)',
    'LFTP host:'            => '転送先サーバ(必須)',
    'LFTP port:'            => '転送先のPORT番号(必須)',
    'LFTP user:'            => 'ユーザ名(必須)',
    'LFTP password:'        => 'パスワード(必須)',
    'LFTP local_dir:'       => '転送元ディレクトリ(必須)',
    'LFTP remote_dir:'      => '転送先ディレクトリ(必須)',
    'LFTP setting:'         => 'LFTPのオプション',
    'LFTP mirror_opt:'      => 'mirrorのオプション',

    'Hint enabled:'         => 'プラグインを利用する際はチェックを入れてください。',
    'Hint cmd:'             => 'LFTPコマンドの絶対パスを設定してください。',
    'Hint method:'          => 'ftp、sftp、ftpsなど、接続方式を設定してください。',
    'Hint host:'            => '転送先のサーバ名、IPアドレス等を設定してください。',
    'Hint port:'            => '転送先のサーバのSSH接続時のPORT番号を指定してください。',
    'Hint user:'            => '転送先のサーバのユーザ名を設定してください。',
    'Hint password:'        => '転送先のサーバのパスワードを設定してください。',
    'Hint local_dir:'       => '転送するファイルの設置されているディレクトリを絶対パスで指定してください。',
    'Hint remote_dir:'      => '転送するファイルが設置されるディレクトリを絶対パスで指定してください。',
    'Hint setting:'         => 'LFTPのSetコマンドを記述してください。改行はせず「 ; 」で区切ってください。',
    'Hint mirror_opt:'      => 'mirrorコマンドのオプションを設定してください。転送を除外したいディレクトリはここで設定してください。',

    # menu
    'lftp Upload Site' => 'ウェブサイトをアップロード',
    'lftp Upload Blog' => 'ブログをアップロード',

    # view
    'Upload Site' => 'アップロード',
    'Upload Blog' => 'アップロード',
    'Dry run' => 'ファイルを確認',
    'Show what would have been transferred.' => '転送されるファイルを確認する（転送は行われません）',
    'Do Upload' => '転送する'


);

1;
