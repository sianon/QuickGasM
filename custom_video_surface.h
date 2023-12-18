#ifndef CUSTOM_VIDEO_SURFACE_H
#define CUSTOM_VIDEO_SURFACE_H

#include <QAbstractVideoSurface>
#include <QVideoFrame>
#include <QImage>
#include <QVideoSurfaceFormat>

class CustomVideoSurface : public QAbstractVideoSurface
{
    Q_OBJECT

public:
    CustomVideoSurface(QObject* parent = nullptr);
    QList<QVideoFrame::PixelFormat> supportedPixelFormats(QAbstractVideoBuffer::HandleType handleType) const override;
    bool present(const QVideoFrame& frame) override;
    QVideoSurfaceFormat surfaceFormat() const;

    QImage currentImage() const;

signals:
    void framePresented();

private:
    QImage imageFromVideoFrame(const QVideoFrame& frame);
    QImage currentFrameImage;
};

#endif // CUSTOM_VIDEO_SURFACE_H
