#ifndef LIBRARY_H
#define LIBRARY_H

#include <QObject>
#include "album.h"

class Library : public QObject {
    Q_OBJECT
    Q_PROPERTY(QString filter READ filter WRITE setFilter NOTIFY filterChanged)
    Q_PROPERTY(QVector<Album*> albums READ albums WRITE setAlbums NOTIFY albumsChanged)

public:
    explicit Library(QObject *parent = nullptr);
    const QVector<Album*> &albums() const;
    const QString &filter() const;

signals:
    void albumsChanged(const QVector<Album*> &albums);
    void filterChanged(const QString &filter);

public slots:
    void setAlbums(const QVector<Album*> &albums);
    void setFilter(const QString &filter);
    void addAlbum(QString imgUrl, QString title, QString author, int date, QString genre, QVector<QString> tracks);
    void editAlbum(int index, QString imgUrl, QString title, QString author, int date, QString genre, QVector<QString> tracks);
    void removeAlbum(int index);

private:
    QVector<Album*> m_albums;
    QString m_filter;
};

#endif // LIBRARY_H
