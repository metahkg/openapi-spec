#!/bin/sh

wget "https://gitlab.com/metahkg/metahkg-server/-/raw/${branch}/openapi.yaml"
version=$(cat openapi.yaml | grep version | awk -F: '{ print $2 }' | tr '\n' ' ' | sed 's/[" ]//g' | sed 's/-dev//g')
suffix=$(if [ "$branch" = "dev" ]; then echo "-dev"; else echo ""; fi;)
minor="v$(node -e "console.log('${version}'.split('.').slice(0, 2).join('.'))")${suffix}"

if [[ -d "${minor}" ]];
then
  mv openapi.yaml "${minor}";
else
  mkdir "$minor" && mv openapi.yaml "${minor}";
fi;

export minor="$minor"

rm -f openapi.yaml;
