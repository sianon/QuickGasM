//
// Created by cao on 24-4-15.
//

#ifndef MEDIA_FIELE_MANAGE_H
#define MEDIA_FIELE_MANAGE_H

#include <QObject>
#include <QVector>
#include <QDir>

#include "common.h"

class MediaFileManage : public QObject{
Q_OBJECT
public:
    explicit MediaFileManage(QObject* parent = nullptr) : media_file_list_(){
    }

    ~MediaFileManage(){
    }

    void mvDeleteFile(QString file_path){
        if(file_path.isEmpty() || !QFile::exists(file_path)){
            return;
        }

        QFile::remove(file_path);
        media_file_list_.removeOne(file_path);

//        auto tmp = std::find(media_file_list_.begin(), media_file_list_.end(), file_path);
    }

    QStringList moGetFilePaths(){
        return media_file_list_;
    }

    void mvRefreshFileList(QString path){
        QDir dir("/home/cao/");
        media_file_list_.clear();

        dir.setFilter(QDir::Files | QDir::Dirs | QDir::NoDotAndDotDot);
        dir.setNameFilters(QStringList() << "*.png");
        dir.setSorting(QDir::Name);

        QFileInfoList file_list = dir.entryInfoList();
                foreach (const QFileInfo& file, file_list){
                media_file_list_.push_back(file.absoluteFilePath());
            }
    }

private:
    QStringList media_file_list_;
    QString root_path_;
};

#endif //MEDIA_FIELE_MANAGE_H
