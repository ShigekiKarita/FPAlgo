# Haskell のメモ

[![Build Status](https://travis-ci.org/ShigekiKarita/FPAlgo.svg?branch=master)](https://travis-ci.org/ShigekiKarita/FPAlgo)
[![Coverage Status](https://coveralls.io/repos/ShigekiKarita/FPAlgo/badge.svg?branch=master&service=github)](https://coveralls.io/github/ShigekiKarita/FPAlgo?branch=master)

## Tips
+ test は HSpec と doctest を使うと良い。
  + coverage 計測には `hpc` を使うと良い
  + `hpc-coveralls` は `ghc-7.6` では install に失敗した
+ doctest は ghci みたいな IO っぽいので大体の副作用を使える
+ doctest で副作用のある値を使うときは Applicative に書くほうがわかりやすい ?
+ Emacs の haskell-mode + ghc-mod で `C-u C-c C-t` をすると推論された型をコードに挿入
+ `where` スコープではなくグローバルでも後方参照できた
+ 型クラスの制約を使った多相型シノニノムはないっぽい, `newtype` を使う
  + `newtype Num a => NList a = List a` C++ の typedef くらい読みにくい
  + `newtype` も `type` 同様にオーバーヘッドは無い，ただしコンストラクタとフィールドも一つだけ作れるし `deriving` も可能
  + `data` は何個でも作れるが呼び出しでオーバーヘッドがある


## TODO
+ 複数ソースのライブラリをビルド
+ HSpec で副作用のあるコードのテスト
+ Emacs の設定が肥大化したのでコンパクトに
+ Criterion で benchmark
+ モナド変換子って何
+ ghc-mod にテストコード (spec など) を読み込ませる方法
+ Windows の ghc-mod がフリーズする
+ Windows の ghc-mod や flycheck がエラーを表示しない
  + 最新版を再インストールする (hdev-tools は動かなくなっていた)
+ 自前の型に Arbitary を書く
+ `hpc-coveralls` で `test` ディレクトリを計測対象から外す
