//
// Created by cao on 24-4-15.
//

#ifndef MEDIA_FIELE_PREVIEW_H
#define MEDIA_FIELE_PREVIEW_H

#include <QObject>
#include <QVector>
#include <QDir>
#include <QMediaPlayer>
#include <fstream>
#include <iostream>

#include "common.h"

class MediaFilePreview : public QObject{
Q_OBJECT
public:
    explicit MediaFilePreview(QObject* parent = nullptr){
        player_ = new QMediaPlayer(this);
        player_->setAudioRole(QAudio::VideoRole);
        QObject::connect(this, &MediaFilePreview::mvPlay, player_, &QMediaPlayer::play);
        QObject::connect(this, &MediaFilePreview::mvStop, player_, &QMediaPlayer::stop);
    }

    ~MediaFilePreview(){
    }

    void mvPreviewMediaByPath(QString path){
        if(!QFile::exists(path) || !path.endsWith(".jpg")){
            return;
        }

        using namespace std;
        fstream file;
        file.open(path.toStdString(), ios::trunc | ios::binary);
        file.seekg(0, std::ios::end);
        std::streampos filetail = file.tellg();
        file.seekg(-4, std::ios_base::end);

        char buffer[4];
        file.read(buffer, 4);
        int index = *reinterpret_cast<int*>(buffer);
        size_t size_tmp = static_cast<long long>(filetail);

        char* data = new char[index];

        std::ofstream outputFile("tmp.aac", std::ios::trunc | std::ios::binary);
        if(outputFile.is_open()){
            outputFile.write(data, size_tmp);
        }

        player_->setMedia(QUrl::fromLocalFile("tmp.aac"));
        player_->setVolume(100);
//        mvPlay();
    }

signals:
    void mvPlay();
    void mvStop();
private:
    QMediaPlayer* player_;
    QString root_path_;
};

#endif //MEDIA_FIELE_PREVIEW_H
