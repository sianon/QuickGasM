#include "custom_video_surface.h"

CustomVideoSurface::CustomVideoSurface(QObject* parent)
    : QAbstractVideoSurface(parent)
{
}

QList<QVideoFrame::PixelFormat> CustomVideoSurface::supportedPixelFormats(QAbstractVideoBuffer::HandleType handleType) const
{
    Q_UNUSED(handleType);
    return QList<QVideoFrame::PixelFormat>() << QVideoFrame::Format_RGB32;
}

bool CustomVideoSurface::present(const QVideoFrame& frame)
{
    if (surfaceFormat().pixelFormat() != frame.pixelFormat() || surfaceFormat().frameSize() != frame.size())
    {
        setError(IncorrectFormatError);
        stop();
        return false;
    }

    currentFrameImage = imageFromVideoFrame(frame);

    emit framePresented();

    return true;
}

QVideoSurfaceFormat CustomVideoSurface::surfaceFormat() const
{
    // Set the desired video format
    return QVideoSurfaceFormat(QSize(640, 480), QVideoFrame::Format_RGB32);
}

QImage CustomVideoSurface::imageFromVideoFrame(const QVideoFrame& tmp_frame)
{
    QVideoFrame frame(tmp_frame);
    if (!frame.map(QAbstractVideoBuffer::ReadOnly))
        return QImage();

    QImage::Format format = QVideoFrame::imageFormatFromPixelFormat(frame.pixelFormat());
    QImage image(frame.bits(),
                 frame.width(),
                 frame.height(),
                 frame.bytesPerLine(),
                 format);

    frame.unmap();

    return image.copy();  // Ensure that you create a copy to detach from the original data
}

QImage CustomVideoSurface::currentImage() const
{
    return currentFrameImage;
}
