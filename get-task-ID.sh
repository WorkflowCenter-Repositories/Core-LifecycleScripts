func () {
Url=$1
phrase="/raw"
repo_Url="${Url%%$phrase*}"   #get url part before raw
var=${Url%/*}     
task=${repo_Url##*/}
item=$(echo ${var##*/})   #get the item after raw e.g: "zip-PW-release"
#echo "$repo_Url"

flag=$(git ls-remote --heads $repo_Url.git | grep $item)
if [[ ! -z $flag ]]; then
  #echo " it is a branch"
  SHA=$(echo ${flag:0:40})
  #echo $SHA	
  tag=$(git ls-remote --tags --refs $repo_Url.git | grep $SHA)
  if [[ ! -z $tag ]]; then 
   tag=${tag##*/}
  #echo "tag $tag"
  else
   #echo "tag is latest"
   tag='latest'
  fi
fi
flag=$(git ls-remote --tags $$repo_Url | grep $item)
if [[ ! -z $flag ]]; then
#echo "it's tag"
   tag=$item
fi
echo $task'.'$tag

}
