// مدل اصلی پاسخ API
class ContentPostModel {
  final int count;
  final String? next;
  final String? previous;
  final MainPageResults results;

  ContentPostModel({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory ContentPostModel.fromJson(Map<String, dynamic> json) =>
      ContentPostModel(
        count: json['count'],
        next: json['next'],
        previous: json['previous'],
        results: MainPageResults.fromJson(json['results']),
      );

  Map<String, dynamic> toJson() => {
    'count': count,
    'next': next,
    'previous': previous,
    'results': results.toJson(),
  };
}

// مدل نتایج
class MainPageResults {
  final double userWalletBalance;
  final List<PostData> postData;

  MainPageResults({required this.userWalletBalance, required this.postData});

  factory MainPageResults.fromJson(Map<String, dynamic> json) =>
      MainPageResults(
        userWalletBalance: (json['user_wallet_balance'] as num).toDouble(),
        postData: List<PostData>.from(
          json['post_data'].map((x) => PostData.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    'user_wallet_balance': userWalletBalance,
    'post_data': postData.map((x) => x.toJson()).toList(),
  };
}

// مدل هر پست
class PostData {
  final int? id;
  final String? title;
  final String? body;
  final int? coinBalance;
  final List<PostContent>? contents;
  final Owner owner;
  final String? linkTitle;
  final String? link;

  PostData({
    this.id,
    this.title,
    this.body,
    this.coinBalance,
    this.contents,
    required this.owner,
    this.linkTitle,
    this.link,
  });

  factory PostData.fromJson(Map<String, dynamic> json) => PostData(
    id: json['id'],
    title: json['title'],
    body: json['body'],
    coinBalance: json['coin_balance'],
    contents: List<PostContent>.from(
      json['contents'].map((x) => PostContent.fromJson(x)),
    ),
    owner: Owner.fromJson(json['owner']),
    linkTitle: json['link_title'],
    link: json['link'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'body': body,
    'coin_balance': coinBalance,
    'contents': contents?.map((x) => x.toJson()).toList(),
    'owner': owner.toJson(),
    'link_title': linkTitle,
    'link': link,
  };
}

// مدل محتوای هر پست (تصویر یا ویدیو)
class PostContent {
  final String? preview;
  final String? content;

  PostContent({this.preview, this.content});

  factory PostContent.fromJson(Map<String, dynamic> json) =>
      PostContent(preview: json['preview'], content: json['content']);

  Map<String, dynamic> toJson() => {'preview': preview, 'content': content};
}

// مدل مالک پست
class Owner {
  final String? picture;
  final String? fullName;
  final String? biography;
  final String? id;

  Owner({this.picture, this.fullName, this.biography, this.id});

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
    picture: json['picture'],
    fullName: json['full_name'],
    biography: json['biography'],
    id: json['id'],
  );

  Map<String, dynamic> toJson() => {
    'picture': picture,
    'full_name': fullName,
    'biography': biography,
    'id': id,
  };
}
