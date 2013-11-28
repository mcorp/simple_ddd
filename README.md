Simple DDD
==========

Serviço simples para responder o DDD das cidades via jsonp

Criando os arquivos da API
==========================

```
bundle install
bin/build_api
cd site
jekyll serve -P 3000
```

Consultando a API desenvolvimento
=================================

```
curl http://localhost:3000/br.json
curl http://localhost:3000/br/pr.json
curl http://localhost:3000/br/pr/curitiba.json
curl http://localhost:3000/br/pr/curitiba/ddd.json
```

Consultando a API via JQuery (desenvolvimento)
==============================================

```
$.ajax({ url:'http://localhost:3000/brasil/pr/curitiba/ddd.jsonp', dataType:'jsonp', jsonpCallback: "simpleDDDCallback", cache: true}).done(function(t){ console.log(t); } )
```