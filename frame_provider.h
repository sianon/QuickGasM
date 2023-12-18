#ifndef FRAMEPRODER_H
#define FRAMEPRODER_H

#include <QObject>
#include <QAbstractVideoSurface>
#include <QVideoSurfaceFormat>

/*!
 * \brief FrameProvider 作为qml VideoOutput.source
 */
class FrameProvider : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QAbstractVideoSurface *videoSurface READ videoSurface WRITE setVideoSurface)


public:
    FrameProvider();
    ~FrameProvider();

    QAbstractVideoSurface *videoSurface() const;

    /*!
     * \brief 可设置外部自定义QAbstractVideoSurface
     * \param surface
     */
    void setVideoSurface(QAbstractVideoSurface *surface);

    /*!
     * \brief 设置视频格式
     * \param width     视频宽
     * \param heigth    视频高
     * \param format    enum QVideoFrame::PixelFormat
     */
    void setFormat(int width, int heigth, QVideoFrame::PixelFormat format);
    Q_INVOKABLE void test();
public slots:
    /*!
     * \brief 接收外部数据源，视频帧
     * \param frame
     */
    void onNewVideoContentReceived(const QVideoFrame &frame);

private:
    QAbstractVideoSurface *m_surface = NULL;
    QVideoSurfaceFormat m_format;
};
#endif // FRAMEPRODER_H
