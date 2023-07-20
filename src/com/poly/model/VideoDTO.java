package com.poly.model;

public class VideoDTO {
    private Video video;
    private Long likeCount;
    private Long shareCount;

    public VideoDTO(Video video, Long likeCount, Long shareCount) {
        this.video = video;
        this.likeCount = likeCount;
        this.shareCount = shareCount;
    }

    public Video getVideo() {
        return video;
    }

    public void setVideo(Video video) {
        this.video = video;
    }

    public Long getLikeCount() {
        return likeCount;
    }

    public void setLikeCount(Long likeCount) {
        this.likeCount = likeCount;
    }

    public Long getShareCount() {
        return shareCount;
    }

    public void setShareCount(Long shareCount) {
        this.shareCount = shareCount;
    }
}