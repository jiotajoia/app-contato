class Contato{
  String nome;
  String descricao;
  String urlImagem;
  double latitude;
  double longitude;

  Contato(this.nome,this.descricao,this.urlImagem,this.latitude,this.longitude);

  gerarJson(){
    return {
      "nome": nome,
      "descricao": descricao,
      "urlImagem": urlImagem,
      "latitude": latitude,
      "longitude": longitude
    };
  }
}