野沢さんがやっているようにTeXを使ってメモを取っておくと便利な気もしているので，
それを快適にできるようにすることを目指したパッケージ．

- TeXでメモを取って，***自分の***githubで管理したい
- 複数のメモを一つのレポジトリで管理したい
- makeって打っただけで（コマンド一行で，という意味）PDFにしたい
- privateレポジトリにしたいものもある
- 中間生成ファイルはコミットしたくないし，``git status``にも登場してほしくない
- latexの出力がうっとおしいので，良い感じにしたい

を満たす必要がある．

使い方
========

下の「環境」で書いてあることをやった上で，

```bash
cd /path/to/自分のディレクトリ
git subtree add --squash https://github.com/eisoku9618/report.git master -P report
cd report
make example/example.tex
gnome-open example/example.pdf
```

でOK．

環境
========

- Ubuntu 14.04以降
   - TeX Live が2010以降で良い感じに日本語対応していて，Ubuntu12.04（texlive 2009）ではダメで，Ubuntu14.04（texlive 2013）ならOK
- 最新のbxjsarticle
   - latexの出力を良い感じにするlatexrunを使っていて，latexrunは従来の``.tex -> .dvi -> .pdf``で進める``platex``や``uplatex``には対応していなくて，``pdfplatex``や``xelatex``にしか対応していない
   - jarticleやjsarticleは``platex``までにしか対応していなくて，``pdfplatex``や``xelatex``では使えない
   - https://github.com/zr-tex8r/BXjscls というレポジトリで提供されているbxjsarticleはjsarticleを``platex``に依存しないようにしたもので，``pdfplatex``や``xelatex``で使える！！！
   - が，Ubuntu14.04に最初から入っているのではダメだったので，``git clone``する必要があるっぽい
- いらないかもしれないけど``sudo apt-get install texlive-full``(ダウンロードに割と時間かかるパッケージ)

つまり，Ubutnu14.04にて

```bash
sudo apt-get install texlive-full
mkdir -p ~/texmf/tex/latex
cd ~/texmf/tex/latex
git clone https://github.com/zr-tex8r/BXjscls.git
```

をすればOK．

特徴
========

- latexrun を使うことで，texの処理の時の大量のメッセージとエラー時の解読困難なエラー文を隠蔽して見やすくしてくれている
   - https://github.com/aclements/latexrun
   - もうこれがなしでTeXを使いたくない
   - texのビルドをいい感じにしてくれるのは，latexmkとかomakeとかあるが，latexrunはログの出力までいい感じにしてくれるので，これを使うことにした
- サブディレクトリを掘ってもいいし，掘らなくてもいい，というようにした
   - サブディレクトリを掘った例がexample/example.tex
   - 掘らない例がreadme.tex
- 中間生成ファイルは気にしなくていい
   - ちなみにtexのメインファイルがあるディレクトリの.tmp以下に中間生成ファイルは作られている


できていないこと
========

よく分かっていないが，欧米ではtexから一発でpdfを使うpdflatexが主流なのに対し，日本ではアルファベットと日本語が混ざるせいでplatex+dvipdfmxが主流．
現状では，日本語を綺麗なスタイル（細かい部分だから良く分からない．段落の最初に空白をどのくらいいれるか，とかそんなレイヤーの話）で出力が必要な場合（修論とか）ではplatex+dvipdfmx+jsarticleスタイルを使うべきっぽい．

ので，そういうのにはこのレポジトリは対応していなくて，このレポジトリの守備範囲は個人的や仲間内で使うpdfが対象．

日本語文章でなくて，英語だけなら

- https://github.com/tsgates/die

が便利そう．
