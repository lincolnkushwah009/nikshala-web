class FolderModel {
  //folder name
  String folderName;
  //folder id
  String id;
  //folder image
  String folderImage;
  //folder video count
  int videoCount;

  FolderModel({this.folderName, this.id, this.folderImage, this.videoCount});

  FolderModel.fromJson(Map<String, dynamic> json) {
    folderName = json["folderName"];
    folderImage = json['folderThumbnail'];
    id = json["id"];
    videoCount = json["totalVideosCount"];
  }
}
