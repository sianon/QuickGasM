#ifndef FRAMEPRODER_H
#define FRAMEPRODER_H

#include <QObject>
#include <QAbstractVideoSurface>
#include <QVideoSurfaceFormat>
#include "common.h"

class FrameProvider : public QObject{
Q_OBJECT
    Q_PROPERTY(QAbstractVideoSurface* videoSurface READ videoSurface WRITE setVideoSurface)
public:
    FrameProvider();
    ~FrameProvider();

    QAbstractVideoSurface* videoSurface() const;

    void setVideoSurface(QAbstractVideoSurface* surface);

    void setFormat(int width, int heigth, QVideoFrame::PixelFormat format);

    inline void mvSetRenderType(VideoType type){
        render_type_ = type;
    }

    Q_INVOKABLE void test();
    Q_INVOKABLE void mvSetScaleRatio(float ratio);
    Q_INVOKABLE void mvZoomIn();
    Q_INVOKABLE void mvZoomOut();
    Q_INVOKABLE QImage mvScaleImage(QImage& img);
    Q_INVOKABLE void mvSetRanderMode();
public slots:
    void onNewVideoContentReceived(const QVideoFrame& frame);

private:
    QAbstractVideoSurface* m_surface = NULL;
    QVideoSurfaceFormat m_format;
    VideoType render_type_;
    float scale_ratio_ = 1;
};

#endif // FRAMEPRODER_H
