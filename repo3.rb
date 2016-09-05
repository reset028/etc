# coding: utf-8
#
#正例[x,y,正例負例]（正例を１負例を-1とする）
$n1=[2,2,1]
$n2=[1,1,1]
$n3=[2,1,1]
#負例
$n4=[-2,-2,-1]
$n5=[1,-1,-1]
$n6=[-1,1,-1]

w = [0,0,0]

def add(w,x,res) #重みベクトルを更新（＋）
  0.upto(2) do |a|
  w[a] = w[a] + x[a]
  end
   p "内積=#{res}で不正解"
  return w
end

def sub(w,x,res)   #重みベクトルを更新（ー）
  0.upto(2) do |a|
  w[a] = w[a] - x[a]
  end
  p "内積=#{res}で不正解"
  return w
end

def main(w)
  reset = 0       #初期化フラグを初期化
  ra = rand(6)+1  #ランダムにサンプルを選択
  no = "$n#{ra}"
  
  if eval(no)[2] == -1 then
    p "負例(#{eval(no)[0]},#{eval(no)[1]})を選んだ"
  else
    p "正例(#{eval(no)[0]},#{eval(no)[1]})を選んだ"
  end
  

  x = [1]                            #バイアスを追記する(1)
  x.push(eval(no)).flatten!
  
  res = 0
  0.upto(2) do |a|
    res = res + w[a] * x[a]           #内積計算する
  end

  if res >= 0 then                    #内積が正例
    if 1 == eval(no)[2] then          #事例も正例
      p "内積・事例共に正例で正解！"  else
      p "W=#{sub(w,x,res)}に更新" ; reset = 1 end #事例は負例
  else                                #内積が負例
    if 1 == eval(no)[2] then          #事例は正例
      p "W=#{add(w,x,res)}に更新" ; reset = 1  else
      p "内積・事例共に負例で正解！"  end  #事例も負例
  end
  return w,ra,reset
end
 flg = [0,0,0,0,0,0]
loop do
  w = main(w)                       #メゾットからすべての情報を抽出
  flg[w[1] - 1] = 1#すべてのサンプルで正しく分類できるかどうかを確認するためフラグ管理のための例番号を取得
  flg = [0,0,0,0,0,0] if  w[2] == 1 #重み付けベクトルが修正された場合フラグを初期化
  w = w[0]                          #重み付けベクトルを再度入れる
  p "flg = #{flg} "
  p "W = #{w}"
  break  if flg.inject(:+) == 6 #すべてのサンプルで正しく分類できたら終了
end
 
