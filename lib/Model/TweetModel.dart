// To parse this JSON data, do
//
//     final tweetModel = tweetModelFromJson(jsonString);

import 'dart:convert';

class TweetModel {
    List<Status> statuses;
    SearchMetadata searchMetadata;

    TweetModel({
        this.statuses,
        this.searchMetadata,
    });

    factory TweetModel.fromJson(String str) => TweetModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory TweetModel.fromMap(Map<String, dynamic> json) => new TweetModel(
        statuses: new List<Status>.from(json["statuses"].map((x) => Status.fromMap(x))),
        searchMetadata: SearchMetadata.fromMap(json["search_metadata"]),
    );

    Map<String, dynamic> toMap() => {
        "statuses": new List<dynamic>.from(statuses.map((x) => x.toMap())),
        "search_metadata": searchMetadata.toMap(),
    };
}

class SearchMetadata {
    double completedIn;
    double maxId;
    String maxIdStr;
    String nextResults;
    String query;
    String refreshUrl;
    int count;
    int sinceId;
    String sinceIdStr;

    SearchMetadata({
        this.completedIn,
        this.maxId,
        this.maxIdStr,
        this.nextResults,
        this.query,
        this.refreshUrl,
        this.count,
        this.sinceId,
        this.sinceIdStr,
    });

    factory SearchMetadata.fromJson(String str) => SearchMetadata.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory SearchMetadata.fromMap(Map<String, dynamic> json) => new SearchMetadata(
        completedIn: json["completed_in"].toDouble(),
        maxId: json["max_id"].toDouble(),
        maxIdStr: json["max_id_str"],
        nextResults: json["next_results"],
        query: json["query"],
        refreshUrl: json["refresh_url"],
        count: json["count"],
        sinceId: json["since_id"],
        sinceIdStr: json["since_id_str"],
    );

    Map<String, dynamic> toMap() => {
        "completed_in": completedIn,
        "max_id": maxId,
        "max_id_str": maxIdStr,
        "next_results": nextResults,
        "query": query,
        "refresh_url": refreshUrl,
        "count": count,
        "since_id": sinceId,
        "since_id_str": sinceIdStr,
    };
}

class Status {
    String createdAt;
    double id;
    String idStr;
    String text;
    bool truncated;
    StatusEntities entities;
    Metadata metadata;
    String source;
    dynamic inReplyToStatusId;
    dynamic inReplyToStatusIdStr;
    dynamic inReplyToUserId;
    dynamic inReplyToUserIdStr;
    dynamic inReplyToScreenName;
    StatusUser user;
    dynamic geo;
    dynamic coordinates;
    dynamic place;
    dynamic contributors;
    RetweetedStatus retweetedStatus;
    bool isQuoteStatus;
    int retweetCount;
    int favoriteCount;
    bool favorited;
    bool retweeted;
    String lang;

    Status({
        this.createdAt,
        this.id,
        this.idStr,
        this.text,
        this.truncated,
        this.entities,
        this.metadata,
        this.source,
        this.inReplyToStatusId,
        this.inReplyToStatusIdStr,
        this.inReplyToUserId,
        this.inReplyToUserIdStr,
        this.inReplyToScreenName,
        this.user,
        this.geo,
        this.coordinates,
        this.place,
        this.contributors,
        this.retweetedStatus,
        this.isQuoteStatus,
        this.retweetCount,
        this.favoriteCount,
        this.favorited,
        this.retweeted,
        this.lang,
    });

    factory Status.fromJson(String str) => Status.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Status.fromMap(Map<String, dynamic> json) => new Status(
        createdAt: json["created_at"],
        id: json["id"].toDouble(),
        idStr: json["id_str"],
        text: json["text"],
        truncated: json["truncated"],
        entities: StatusEntities.fromMap(json["entities"]),
        metadata: Metadata.fromMap(json["metadata"]),
        source: json["source"],
        inReplyToStatusId: json["in_reply_to_status_id"],
        inReplyToStatusIdStr: json["in_reply_to_status_id_str"],
        inReplyToUserId: json["in_reply_to_user_id"],
        inReplyToUserIdStr: json["in_reply_to_user_id_str"],
        inReplyToScreenName: json["in_reply_to_screen_name"],
        user: StatusUser.fromMap(json["user"]),
        geo: json["geo"],
        coordinates: json["coordinates"],
        place: json["place"],
        contributors: json["contributors"],
        retweetedStatus: RetweetedStatus.fromMap(json["retweeted_status"]),
        isQuoteStatus: json["is_quote_status"],
        retweetCount: json["retweet_count"],
        favoriteCount: json["favorite_count"],
        favorited: json["favorited"],
        retweeted: json["retweeted"],
        lang: json["lang"],
    );

    Map<String, dynamic> toMap() => {
        "created_at": createdAt,
        "id": id,
        "id_str": idStr,
        "text": text,
        "truncated": truncated,
        "entities": entities.toMap(),
        "metadata": metadata.toMap(),
        "source": source,
        "in_reply_to_status_id": inReplyToStatusId,
        "in_reply_to_status_id_str": inReplyToStatusIdStr,
        "in_reply_to_user_id": inReplyToUserId,
        "in_reply_to_user_id_str": inReplyToUserIdStr,
        "in_reply_to_screen_name": inReplyToScreenName,
        "user": user.toMap(),
        "geo": geo,
        "coordinates": coordinates,
        "place": place,
        "contributors": contributors,
        "retweeted_status": retweetedStatus.toMap(),
        "is_quote_status": isQuoteStatus,
        "retweet_count": retweetCount,
        "favorite_count": favoriteCount,
        "favorited": favorited,
        "retweeted": retweeted,
        "lang": lang,
    };
}

class StatusEntities {
    List<Hashtag> hashtags;
    List<dynamic> symbols;
    List<UserMention> userMentions;
    List<Url> urls;

    StatusEntities({
        this.hashtags,
        this.symbols,
        this.userMentions,
        this.urls,
    });

    factory StatusEntities.fromJson(String str) => StatusEntities.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory StatusEntities.fromMap(Map<String, dynamic> json) => new StatusEntities(
        hashtags: new List<Hashtag>.from(json["hashtags"].map((x) => Hashtag.fromMap(x))),
        symbols: new List<dynamic>.from(json["symbols"].map((x) => x)),
        userMentions: new List<UserMention>.from(json["user_mentions"].map((x) => UserMention.fromMap(x))),
        urls: new List<Url>.from(json["urls"].map((x) => Url.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "hashtags": new List<dynamic>.from(hashtags.map((x) => x.toMap())),
        "symbols": new List<dynamic>.from(symbols.map((x) => x)),
        "user_mentions": new List<dynamic>.from(userMentions.map((x) => x.toMap())),
        "urls": new List<dynamic>.from(urls.map((x) => x.toMap())),
    };
}

class Hashtag {
    String text;
    List<int> indices;

    Hashtag({
        this.text,
        this.indices,
    });

    factory Hashtag.fromJson(String str) => Hashtag.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Hashtag.fromMap(Map<String, dynamic> json) => new Hashtag(
        text: json["text"],
        indices: new List<int>.from(json["indices"].map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "text": text,
        "indices": new List<dynamic>.from(indices.map((x) => x)),
    };
}

class Url {
    String url;
    String expandedUrl;
    String displayUrl;
    List<int> indices;

    Url({
        this.url,
        this.expandedUrl,
        this.displayUrl,
        this.indices,
    });

    factory Url.fromJson(String str) => Url.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Url.fromMap(Map<String, dynamic> json) => new Url(
        url: json["url"],
        expandedUrl: json["expanded_url"],
        displayUrl: json["display_url"],
        indices: new List<int>.from(json["indices"].map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "url": url,
        "expanded_url": expandedUrl,
        "display_url": displayUrl,
        "indices": new List<dynamic>.from(indices.map((x) => x)),
    };
}

class UserMention {
    String screenName;
    String name;
    int id;
    String idStr;
    List<int> indices;

    UserMention({
        this.screenName,
        this.name,
        this.id,
        this.idStr,
        this.indices,
    });

    factory UserMention.fromJson(String str) => UserMention.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UserMention.fromMap(Map<String, dynamic> json) => new UserMention(
        screenName: json["screen_name"],
        name: json["name"],
        id: json["id"],
        idStr: json["id_str"],
        indices: new List<int>.from(json["indices"].map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "screen_name": screenName,
        "name": name,
        "id": id,
        "id_str": idStr,
        "indices": new List<dynamic>.from(indices.map((x) => x)),
    };
}

class Metadata {
    String isoLanguageCode;
    String resultType;

    Metadata({
        this.isoLanguageCode,
        this.resultType,
    });

    factory Metadata.fromJson(String str) => Metadata.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Metadata.fromMap(Map<String, dynamic> json) => new Metadata(
        isoLanguageCode: json["iso_language_code"],
        resultType: json["result_type"],
    );

    Map<String, dynamic> toMap() => {
        "iso_language_code": isoLanguageCode,
        "result_type": resultType,
    };
}

class RetweetedStatus {
    String createdAt;
    double id;
    String idStr;
    String text;
    bool truncated;
    StatusEntities entities;
    Metadata metadata;
    String source;
    dynamic inReplyToStatusId;
    dynamic inReplyToStatusIdStr;
    dynamic inReplyToUserId;
    dynamic inReplyToUserIdStr;
    dynamic inReplyToScreenName;
    RetweetedStatusUser user;
    dynamic geo;
    dynamic coordinates;
    dynamic place;
    dynamic contributors;
    bool isQuoteStatus;
    int retweetCount;
    int favoriteCount;
    bool favorited;
    bool retweeted;
    bool possiblySensitive;
    String lang;

    RetweetedStatus({
        this.createdAt,
        this.id,
        this.idStr,
        this.text,
        this.truncated,
        this.entities,
        this.metadata,
        this.source,
        this.inReplyToStatusId,
        this.inReplyToStatusIdStr,
        this.inReplyToUserId,
        this.inReplyToUserIdStr,
        this.inReplyToScreenName,
        this.user,
        this.geo,
        this.coordinates,
        this.place,
        this.contributors,
        this.isQuoteStatus,
        this.retweetCount,
        this.favoriteCount,
        this.favorited,
        this.retweeted,
        this.possiblySensitive,
        this.lang,
    });

    factory RetweetedStatus.fromJson(String str) => RetweetedStatus.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory RetweetedStatus.fromMap(Map<String, dynamic> json) => new RetweetedStatus(
        createdAt: json["created_at"],
        id: json["id"].toDouble(),
        idStr: json["id_str"],
        text: json["text"],
        truncated: json["truncated"],
        entities: StatusEntities.fromMap(json["entities"]),
        metadata: Metadata.fromMap(json["metadata"]),
        source: json["source"],
        inReplyToStatusId: json["in_reply_to_status_id"],
        inReplyToStatusIdStr: json["in_reply_to_status_id_str"],
        inReplyToUserId: json["in_reply_to_user_id"],
        inReplyToUserIdStr: json["in_reply_to_user_id_str"],
        inReplyToScreenName: json["in_reply_to_screen_name"],
        user: RetweetedStatusUser.fromMap(json["user"]),
        geo: json["geo"],
        coordinates: json["coordinates"],
        place: json["place"],
        contributors: json["contributors"],
        isQuoteStatus: json["is_quote_status"],
        retweetCount: json["retweet_count"],
        favoriteCount: json["favorite_count"],
        favorited: json["favorited"],
        retweeted: json["retweeted"],
        possiblySensitive: json["possibly_sensitive"],
        lang: json["lang"],
    );

    Map<String, dynamic> toMap() => {
        "created_at": createdAt,
        "id": id,
        "id_str": idStr,
        "text": text,
        "truncated": truncated,
        "entities": entities.toMap(),
        "metadata": metadata.toMap(),
        "source": source,
        "in_reply_to_status_id": inReplyToStatusId,
        "in_reply_to_status_id_str": inReplyToStatusIdStr,
        "in_reply_to_user_id": inReplyToUserId,
        "in_reply_to_user_id_str": inReplyToUserIdStr,
        "in_reply_to_screen_name": inReplyToScreenName,
        "user": user.toMap(),
        "geo": geo,
        "coordinates": coordinates,
        "place": place,
        "contributors": contributors,
        "is_quote_status": isQuoteStatus,
        "retweet_count": retweetCount,
        "favorite_count": favoriteCount,
        "favorited": favorited,
        "retweeted": retweeted,
        "possibly_sensitive": possiblySensitive,
        "lang": lang,
    };
}

class RetweetedStatusUser {
    int id;
    String idStr;
    String name;
    String screenName;
    String location;
    String description;
    String url;
    PurpleEntities entities;
    bool protected;
    int followersCount;
    int friendsCount;
    int listedCount;
    String createdAt;
    int favouritesCount;
    dynamic utcOffset;
    dynamic timeZone;
    bool geoEnabled;
    bool verified;
    int statusesCount;
    String lang;
    bool contributorsEnabled;
    bool isTranslator;
    bool isTranslationEnabled;
    String profileBackgroundColor;
    String profileBackgroundImageUrl;
    String profileBackgroundImageUrlHttps;
    bool profileBackgroundTile;
    String profileImageUrl;
    String profileImageUrlHttps;
    String profileBannerUrl;
    String profileLinkColor;
    String profileSidebarBorderColor;
    String profileSidebarFillColor;
    String profileTextColor;
    bool profileUseBackgroundImage;
    bool hasExtendedProfile;
    bool defaultProfile;
    bool defaultProfileImage;
    bool following;
    bool followRequestSent;
    bool notifications;
    String translatorType;

    RetweetedStatusUser({
        this.id,
        this.idStr,
        this.name,
        this.screenName,
        this.location,
        this.description,
        this.url,
        this.entities,
        this.protected,
        this.followersCount,
        this.friendsCount,
        this.listedCount,
        this.createdAt,
        this.favouritesCount,
        this.utcOffset,
        this.timeZone,
        this.geoEnabled,
        this.verified,
        this.statusesCount,
        this.lang,
        this.contributorsEnabled,
        this.isTranslator,
        this.isTranslationEnabled,
        this.profileBackgroundColor,
        this.profileBackgroundImageUrl,
        this.profileBackgroundImageUrlHttps,
        this.profileBackgroundTile,
        this.profileImageUrl,
        this.profileImageUrlHttps,
        this.profileBannerUrl,
        this.profileLinkColor,
        this.profileSidebarBorderColor,
        this.profileSidebarFillColor,
        this.profileTextColor,
        this.profileUseBackgroundImage,
        this.hasExtendedProfile,
        this.defaultProfile,
        this.defaultProfileImage,
        this.following,
        this.followRequestSent,
        this.notifications,
        this.translatorType,
    });

    factory RetweetedStatusUser.fromJson(String str) => RetweetedStatusUser.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory RetweetedStatusUser.fromMap(Map<String, dynamic> json) => new RetweetedStatusUser(
        id: json["id"],
        idStr: json["id_str"],
        name: json["name"],
        screenName: json["screen_name"],
        location: json["location"],
        description: json["description"],
        url: json["url"],
        entities: PurpleEntities.fromMap(json["entities"]),
        protected: json["protected"],
        followersCount: json["followers_count"],
        friendsCount: json["friends_count"],
        listedCount: json["listed_count"],
        createdAt: json["created_at"],
        favouritesCount: json["favourites_count"],
        utcOffset: json["utc_offset"],
        timeZone: json["time_zone"],
        geoEnabled: json["geo_enabled"],
        verified: json["verified"],
        statusesCount: json["statuses_count"],
        lang: json["lang"],
        contributorsEnabled: json["contributors_enabled"],
        isTranslator: json["is_translator"],
        isTranslationEnabled: json["is_translation_enabled"],
        profileBackgroundColor: json["profile_background_color"],
        profileBackgroundImageUrl: json["profile_background_image_url"],
        profileBackgroundImageUrlHttps: json["profile_background_image_url_https"],
        profileBackgroundTile: json["profile_background_tile"],
        profileImageUrl: json["profile_image_url"],
        profileImageUrlHttps: json["profile_image_url_https"],
        profileBannerUrl: json["profile_banner_url"],
        profileLinkColor: json["profile_link_color"],
        profileSidebarBorderColor: json["profile_sidebar_border_color"],
        profileSidebarFillColor: json["profile_sidebar_fill_color"],
        profileTextColor: json["profile_text_color"],
        profileUseBackgroundImage: json["profile_use_background_image"],
        hasExtendedProfile: json["has_extended_profile"],
        defaultProfile: json["default_profile"],
        defaultProfileImage: json["default_profile_image"],
        following: json["following"],
        followRequestSent: json["follow_request_sent"],
        notifications: json["notifications"],
        translatorType: json["translator_type"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "id_str": idStr,
        "name": name,
        "screen_name": screenName,
        "location": location,
        "description": description,
        "url": url,
        "entities": entities.toMap(),
        "protected": protected,
        "followers_count": followersCount,
        "friends_count": friendsCount,
        "listed_count": listedCount,
        "created_at": createdAt,
        "favourites_count": favouritesCount,
        "utc_offset": utcOffset,
        "time_zone": timeZone,
        "geo_enabled": geoEnabled,
        "verified": verified,
        "statuses_count": statusesCount,
        "lang": lang,
        "contributors_enabled": contributorsEnabled,
        "is_translator": isTranslator,
        "is_translation_enabled": isTranslationEnabled,
        "profile_background_color": profileBackgroundColor,
        "profile_background_image_url": profileBackgroundImageUrl,
        "profile_background_image_url_https": profileBackgroundImageUrlHttps,
        "profile_background_tile": profileBackgroundTile,
        "profile_image_url": profileImageUrl,
        "profile_image_url_https": profileImageUrlHttps,
        "profile_banner_url": profileBannerUrl,
        "profile_link_color": profileLinkColor,
        "profile_sidebar_border_color": profileSidebarBorderColor,
        "profile_sidebar_fill_color": profileSidebarFillColor,
        "profile_text_color": profileTextColor,
        "profile_use_background_image": profileUseBackgroundImage,
        "has_extended_profile": hasExtendedProfile,
        "default_profile": defaultProfile,
        "default_profile_image": defaultProfileImage,
        "following": following,
        "follow_request_sent": followRequestSent,
        "notifications": notifications,
        "translator_type": translatorType,
    };
}

class PurpleEntities {
    Description url;
    Description description;

    PurpleEntities({
        this.url,
        this.description,
    });

    factory PurpleEntities.fromJson(String str) => PurpleEntities.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PurpleEntities.fromMap(Map<String, dynamic> json) => new PurpleEntities(
        url: Description.fromMap(json["url"]),
        description: Description.fromMap(json["description"]),
    );

    Map<String, dynamic> toMap() => {
        "url": url.toMap(),
        "description": description.toMap(),
    };
}

class Description {
    List<Url> urls;

    Description({
        this.urls,
    });

    factory Description.fromJson(String str) => Description.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Description.fromMap(Map<String, dynamic> json) => new Description(
        urls: new List<Url>.from(json["urls"].map((x) => Url.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "urls": new List<dynamic>.from(urls.map((x) => x.toMap())),
    };
}

class StatusUser {
    int id;
    String idStr;
    String name;
    String screenName;
    String location;
    String description;
    dynamic url;
    FluffyEntities entities;
    bool protected;
    int followersCount;
    int friendsCount;
    int listedCount;
    String createdAt;
    int favouritesCount;
    dynamic utcOffset;
    dynamic timeZone;
    bool geoEnabled;
    bool verified;
    int statusesCount;
    String lang;
    bool contributorsEnabled;
    bool isTranslator;
    bool isTranslationEnabled;
    String profileBackgroundColor;
    String profileBackgroundImageUrl;
    String profileBackgroundImageUrlHttps;
    bool profileBackgroundTile;
    String profileImageUrl;
    String profileImageUrlHttps;
    String profileBannerUrl;
    String profileLinkColor;
    String profileSidebarBorderColor;
    String profileSidebarFillColor;
    String profileTextColor;
    bool profileUseBackgroundImage;
    bool hasExtendedProfile;
    bool defaultProfile;
    bool defaultProfileImage;
    bool following;
    bool followRequestSent;
    bool notifications;
    String translatorType;

    StatusUser({
        this.id,
        this.idStr,
        this.name,
        this.screenName,
        this.location,
        this.description,
        this.url,
        this.entities,
        this.protected,
        this.followersCount,
        this.friendsCount,
        this.listedCount,
        this.createdAt,
        this.favouritesCount,
        this.utcOffset,
        this.timeZone,
        this.geoEnabled,
        this.verified,
        this.statusesCount,
        this.lang,
        this.contributorsEnabled,
        this.isTranslator,
        this.isTranslationEnabled,
        this.profileBackgroundColor,
        this.profileBackgroundImageUrl,
        this.profileBackgroundImageUrlHttps,
        this.profileBackgroundTile,
        this.profileImageUrl,
        this.profileImageUrlHttps,
        this.profileBannerUrl,
        this.profileLinkColor,
        this.profileSidebarBorderColor,
        this.profileSidebarFillColor,
        this.profileTextColor,
        this.profileUseBackgroundImage,
        this.hasExtendedProfile,
        this.defaultProfile,
        this.defaultProfileImage,
        this.following,
        this.followRequestSent,
        this.notifications,
        this.translatorType,
    });

    factory StatusUser.fromJson(String str) => StatusUser.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory StatusUser.fromMap(Map<String, dynamic> json) => new StatusUser(
        id: json["id"],
        idStr: json["id_str"],
        name: json["name"],
        screenName: json["screen_name"],
        location: json["location"],
        description: json["description"],
        url: json["url"],
        entities: FluffyEntities.fromMap(json["entities"]),
        protected: json["protected"],
        followersCount: json["followers_count"],
        friendsCount: json["friends_count"],
        listedCount: json["listed_count"],
        createdAt: json["created_at"],
        favouritesCount: json["favourites_count"],
        utcOffset: json["utc_offset"],
        timeZone: json["time_zone"],
        geoEnabled: json["geo_enabled"],
        verified: json["verified"],
        statusesCount: json["statuses_count"],
        lang: json["lang"],
        contributorsEnabled: json["contributors_enabled"],
        isTranslator: json["is_translator"],
        isTranslationEnabled: json["is_translation_enabled"],
        profileBackgroundColor: json["profile_background_color"],
        profileBackgroundImageUrl: json["profile_background_image_url"],
        profileBackgroundImageUrlHttps: json["profile_background_image_url_https"],
        profileBackgroundTile: json["profile_background_tile"],
        profileImageUrl: json["profile_image_url"],
        profileImageUrlHttps: json["profile_image_url_https"],
        profileBannerUrl: json["profile_banner_url"],
        profileLinkColor: json["profile_link_color"],
        profileSidebarBorderColor: json["profile_sidebar_border_color"],
        profileSidebarFillColor: json["profile_sidebar_fill_color"],
        profileTextColor: json["profile_text_color"],
        profileUseBackgroundImage: json["profile_use_background_image"],
        hasExtendedProfile: json["has_extended_profile"],
        defaultProfile: json["default_profile"],
        defaultProfileImage: json["default_profile_image"],
        following: json["following"],
        followRequestSent: json["follow_request_sent"],
        notifications: json["notifications"],
        translatorType: json["translator_type"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "id_str": idStr,
        "name": name,
        "screen_name": screenName,
        "location": location,
        "description": description,
        "url": url,
        "entities": entities.toMap(),
        "protected": protected,
        "followers_count": followersCount,
        "friends_count": friendsCount,
        "listed_count": listedCount,
        "created_at": createdAt,
        "favourites_count": favouritesCount,
        "utc_offset": utcOffset,
        "time_zone": timeZone,
        "geo_enabled": geoEnabled,
        "verified": verified,
        "statuses_count": statusesCount,
        "lang": lang,
        "contributors_enabled": contributorsEnabled,
        "is_translator": isTranslator,
        "is_translation_enabled": isTranslationEnabled,
        "profile_background_color": profileBackgroundColor,
        "profile_background_image_url": profileBackgroundImageUrl,
        "profile_background_image_url_https": profileBackgroundImageUrlHttps,
        "profile_background_tile": profileBackgroundTile,
        "profile_image_url": profileImageUrl,
        "profile_image_url_https": profileImageUrlHttps,
        "profile_banner_url": profileBannerUrl,
        "profile_link_color": profileLinkColor,
        "profile_sidebar_border_color": profileSidebarBorderColor,
        "profile_sidebar_fill_color": profileSidebarFillColor,
        "profile_text_color": profileTextColor,
        "profile_use_background_image": profileUseBackgroundImage,
        "has_extended_profile": hasExtendedProfile,
        "default_profile": defaultProfile,
        "default_profile_image": defaultProfileImage,
        "following": following,
        "follow_request_sent": followRequestSent,
        "notifications": notifications,
        "translator_type": translatorType,
    };
}

class FluffyEntities {
    Description description;

    FluffyEntities({
        this.description,
    });

    factory FluffyEntities.fromJson(String str) => FluffyEntities.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory FluffyEntities.fromMap(Map<String, dynamic> json) => new FluffyEntities(
        description: Description.fromMap(json["description"]),
    );

    Map<String, dynamic> toMap() => {
        "description": description.toMap(),
    };
}
