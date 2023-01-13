#include <QDebug>
#include "library.h"
#include "album.h"

Library::Library(QObject *parent)
    : QObject(parent) {

    Album * album1 = new Album();
    Album * album2 = new Album();

    album1->initAlbum("assets/booklets/second_nature.png", "Second Nature", "Netsky", 2020, "Liquid DnB");
    album2->initAlbum("assets/booklets/snake_monastery.png", "Snake Monastery", "Hydra", 2020, "Neurofunk DnB");

    album1->addTrack("Hold On");
    album1->addTrack("Mixed Emotions");
    album1->addTrack("Destiny");
    album1->addTrack("I Choose You");

    album2->addTrack("Monastery Gate");
    album2->addTrack("Lava Run");
    album2->addTrack("Shadow Strategy");
    album2->addTrack("Hangjaw");
    album2->addTrack("Horror Room");

    uint64_t id1 = reinterpret_cast<uint64_t>(&album1);
    uint64_t id2 = reinterpret_cast<uint64_t>(&album2);

    qDebug() << "ID1: " << id1 << ", ID2: " << id2;

    album1->setId(id1);
    album2->setId(id2);

    m_albums.push_back(album1);
    m_albums.push_back(album2);
}

const QVector<Album*> &Library::albums() const {
    return m_albums;
}

void Library::setAlbums(const QVector<Album*> &newAlbums) {
    if (m_albums.length() == 0) {
        m_albums = newAlbums;
        emit albumsChanged(newAlbums);
    }
}

void Library::addAlbum(QString imgUrl, QString title, QString author, int date, QString genre, QVector<QString> tracks) {
    Album * newAlbum = new Album();

    newAlbum->initAlbum(imgUrl, title, author, date, genre);
    newAlbum->setTracks(tracks);

    uint64_t id = reinterpret_cast<uint64_t>(newAlbum);
    newAlbum->setId(id);

    qDebug() << "Title: " << title << "Author: " << author;

    QString str;
    foreach (str, newAlbum->tracks()) {
        qDebug() << str;
    }

    m_albums.push_back(newAlbum);
    emit albumsChanged(m_albums);
}

void Library::removeAlbum(int index) {
    qDebug() << "Obj to remove: " << index;
    m_albums.removeAt(index);
    emit albumsChanged(m_albums);
}
