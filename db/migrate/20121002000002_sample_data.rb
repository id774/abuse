# -*- encoding: utf-8 -*-

class SampleData < ActiveRecord::Migration
  def change

    s = Status.new(
                 :status => '@todesking さん死〜などと書く人間は DNA が狂っているのだろうと、僕らがお前を分解して調べると、お前には DNA が皆無、愕然としていると、お前から社長が飛び出し豚の食い残した腐ったキャベツを糸にくくりつけ振り回し遺伝情報を形成しており僕らは生命の神秘を感じました。',
                 :keyword => '死 DNA 分解 社長 キャベツ 糸 遺伝 情報 形成 生命 神秘'
    )
    s.save!

    s = Status.new(
                 :status => '@todesking さんには他人の批判よりご自分の UI を考えなおしていただきたいです。チェーンソーでぶった切られたら命がなくなるというのが人間のUIですが、お前は分裂し社内に咲き乱れるトデ好きングにアホの社長は大はしゃぎ、社員全員強制参加季節外れのウザい花見の始まりである。',
                 :keyword => '他人 批判 UI チェーンソー 分裂 花見'
    )
    s.save!

    s = Status.new(
                 :status => '@todesking さんに痛みを教えるため社長がお前を切り刻むタイミングでお前の嫌がるサイレン音を聞かせることにしました。これにより切り刻まれると不快感が発生すると教え込むつもりでしたが「ピーポピーポヤーよ」と社長がサイレン音に怯えだし一瞬でお前を喰い殺したので実験は失敗です。',
                 :keyword => '痛 サイレン 音 不快感 実験'
    )
    s.save!

  end
end
