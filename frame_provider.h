#ifndef FRAMEPROVIDER_H
#define FRAMEPROVIDER_H

#include <QObject>
#include <QAbstractVideoSurface>
#include <QVideoSurfaceFormat>
#include "common.h"
#include "color_setting.h"
#include "ring_buffer.h"
#include "media_file_manage.h"
#include "media_file_preview.h"
#include "SettingsManager.h"

class FrameProvider : public QObject{
Q_OBJECT
    Q_PROPERTY(QAbstractVideoSurface* videoSurface READ videoSurface WRITE setVideoSurface)
public:
    FrameProvider();
    ~FrameProvider();

    QAbstractVideoSurface* videoSurface() const;

    void setVideoSurface(QAbstractVideoSurface* surface);

    void setFormat(int width, int heigth, QVideoFrame::PixelFormat format);

    void mvSetAudioBuf(char* src, size_t size);
    QString moGetDialogRes();
    inline void mvSetRenderType(VideoType type){
        render_type_ = type;
    }

    Q_INVOKABLE void mvSetColorType(QString type){
        qDebug()<<"set color type:"<<type;
        color_setting_.mbChangeColorByName(type);
    }

    Q_INVOKABLE void test();
    Q_INVOKABLE void mvSetScaleRatio(float ratio);
    //TODO 放大缩小
    Q_INVOKABLE void mvZoomIn();
    Q_INVOKABLE void mvZoomOut();
    Q_INVOKABLE bool mbSnapShot();
    //TODO 显示磁盘空间
    Q_INVOKABLE QString mobGetStorageInfo();
    Q_INVOKABLE QImage mvScaleImage(QImage& img);
    //TODO 设置渲染模式,可见光，红外，画中画，细节增强
    Q_INVOKABLE void mvSetRanderMode(QString mode);
    //TODO 测气模式设置
    Q_INVOKABLE void mvSwitchGasMode(bool on_off){
        qDebug()<<"set gas mode:"<<on_off;
    };
    Q_INVOKABLE void mvSwitchGasDectect(QString on_off);
    Q_INVOKABLE void mvSwitchGasSplit(QString on_off);
    Q_INVOKABLE void mvSwitchConcentrationDistri(QString on_off);
    Q_INVOKABLE void mvSwitchCloudGasEnhance(QString on_off);
    Q_INVOKABLE void mvSwitchDisplayTDLAS(QString on_off);
    //TODO 恢复出厂设置
    Q_INVOKABLE bool mbFactoryReset();
    //TODO 搜索升级文件
    Q_INVOKABLE bool mbSearchUpgradeFile();
    //TODO 获取系统版本
    Q_INVOKABLE QString msGetSysVersion(int index);
    //TODO 设置屏幕亮度
    Q_INVOKABLE void mvSetScreenLvl(QString lvl);
    //TODO 格式化
    Q_INVOKABLE bool mbFormatTF();
    //TODO 屏幕亮度
    Q_INVOKABLE void mvSetScreenLvl(int lvl);
    //TODO 温度单位
    Q_INVOKABLE void mvSetTmpUnit(QString val);
    //TODO 距离单位
    Q_INVOKABLE void mvSetDistanceUnit(QString val);
    //TODO 环境温度
    Q_INVOKABLE void mvSetEnvTemp(QString val);
    //TODO 环境湿度
    Q_INVOKABLE void mvSetEnvhumidity(QString val);
    //TODO 测量距离
    Q_INVOKABLE void mvSetDistance(QString val);
    //TODO 发射率
    Q_INVOKABLE void mvSetEmissivity(QString val);
    //TODO 拍照设置
    Q_INVOKABLE bool mbSnap(QString val);
    Q_INVOKABLE bool mbSnapSave(QString val);
    Q_INVOKABLE bool mbSnapRecordVoice(QString val);
    Q_INVOKABLE bool mbSnapBeidouInfo();
    Q_INVOKABLE bool mbSnapQRScan();
    //TODO 录像设置
    Q_INVOKABLE bool mbRecord(QString val);
    Q_INVOKABLE bool mbRecordSave(QString val);
    Q_INVOKABLE bool mbRecordVideoVoice(QString val);
    Q_INVOKABLE bool mbRecordBeidouInfo();
    Q_INVOKABLE bool mbRecordQRScan();

    //TODO 气体报警
    Q_INVOKABLE void mvSetGasDetectWarrning(bool on_off){
        qDebug()<<"set gas detect warrning:"<<on_off;
    };
    Q_INVOKABLE void mvSetGasDetectWarrningPPM(int val){
        qDebug()<<"set gas detect warrning ppm:"<<val;
    };
    Q_INVOKABLE void mvSetGasDetectWarrningAutoSnap(bool on_off){
        qDebug()<<"set gas detect warrning auto snap:"<<on_off;
    };
    Q_INVOKABLE void mvSetGasDetectWarrningAutoSnapInterval(int val){
        qDebug()<<"set gas detect warrning auto snap interval:"<<val;
    };
    Q_INVOKABLE void mvSetGasDetectWarrningAutoRecord(bool on_off){
        qDebug()<<"set gas detect warrning auto record:"<<on_off;
    };
    Q_INVOKABLE void mvSetGasDetectWarrningNotice(bool on_off){
        qDebug()<<"set gas detect warrning notice:"<<on_off;
    };
    
    //TODO 拍照设置
    Q_INVOKABLE void mvSetManualSnapAutoSave(bool on_off){
        qDebug()<<"set manual snap auto save:"<<on_off;
    };
    Q_INVOKABLE void mvSetSnapAutoUpload(bool on_off){
        qDebug()<<"set snap auto upload:"<<on_off;
    };
    Q_INVOKABLE void mvSetAutoSnapPeriod(bool on_off){
        qDebug()<<"set auto snap period:"<<on_off;
    };
    Q_INVOKABLE void mvSetAutoSnapPeriodInterval(int val){
        qDebug()<<"set auto snap period interval:"<<val;
    };
    Q_INVOKABLE void mvSetAutoSnapPeriodNum(int val){
        qDebug()<<"set auto snap period num:"<<val;
    };
    Q_INVOKABLE void mvSetAutoSnapFormat(QString val){};

    //TODO 录像设置
    Q_INVOKABLE void mvSetManualRecordVideoAutoSave(bool on_off){
        qDebug()<<"set manual record video auto save:"<<on_off;
    };
    Q_INVOKABLE void mvSetVideoRecordFormat(QString val){};
    Q_INVOKABLE void mvSetTime(QString val){
        qDebug()<<"set time:"<<val;
    };

    Q_INVOKABLE void mvCallBackMsg(QString cmd);
    Q_INVOKABLE void mvStartRecordAudio(QString cmd);
    Q_INVOKABLE void mvRefeshFileList(QString cmd);
    Q_INVOKABLE void mvDeleteFile(QString path);
    Q_INVOKABLE QStringList moGetFilePaths();
    Q_INVOKABLE void mvPreviewMediaByPath(QString path);
    Q_INVOKABLE void mvStopPreviewMediaByPath(QString path);
    Q_INVOKABLE void mvPlayPreviewMediaByPath(QString path);
    Q_INVOKABLE QString mvGetVideoThumbnailByPath(QString path);
public slots:
    void onNewVideoContentReceived(const QVideoFrame& frame);
signals:
    void mvSnapOver();
private:
    QAbstractVideoSurface* m_surface = NULL;
    QVideoSurfaceFormat m_format;
    MediaFileManage media_file_manage_;
    MediaFilePreview media_file_preview_;
    SettingsManager setting_manager_;
    VideoType render_type_;
    float scale_ratio_ = 1;
    cv::Mat current_src_mat_;
    ColorSetting color_setting_;
    QImage snap_shot_img_;
    QString cmd_;
    char* audio_buf_;
    size_t audio_buf_size_;
};

#endif // FRAMEPROVIDER_H
