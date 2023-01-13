#ifndef LIBRARY_H
#define LIBRARY_H

#include <QObject>
#include "album.h"

class Library : public QObject {
    Q_OBJECT
    Q_PROPERTY(QVector<Album*> albums READ albums WRITE setAlbums NOTIFY albumsChanged)

public:
    explicit Library(QObject *parent = nullptr);
    const QVector<Album*> &albums() const;

signals:
    void albumsChanged(const QVector<Album*> &albums);

public slots:
    void setAlbums(const QVector<Album*> &albums);
    void addAlbum(QString imgUrl, QString title, QString author, int date, QString genre, QVector<QString> tracks);
    void removeAlbum(int index);

private:
    QVector<Album*> m_albums;
};

#endif // LIBRARY_H
