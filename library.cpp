#include <QDebug>
#include <QDir>
#include "library.h"
#include "album.h"

Library::Library(QObject *parent)
    : QObject(parent) {

    Album * album1 = new Album();
    Album * album2 = new Album();
    Album * album3 = new Album();
    Album * album4 = new Album();

    album1->initAlbum("/Users/jinambo/build-CD_Lib-Qt_6_4_0_for_macOS-Debug/CD_Lib.app/Contents/MacOS/booklets//second_nature.png", "Second Nature", "Netsky", 2020, "Liquid DnB");
    album2->initAlbum("/Users/jinambo/build-CD_Lib-Qt_6_4_0_for_macOS-Debug/CD_Lib.app/Contents/MacOS/booklets//snake_monastery.png", "Snake Monastery", "Hydra", 2020, "Neurofunk DnB");
    album3->initAlbum("/Users/jinambo/build-CD_Lib-Qt_6_4_0_for_macOS-Debug/CD_Lib.app/Contents/MacOS/booklets//big_boy_fm.jpeg", "BIG BOY FM", "Gleb", 2022, "Rap");
    album4->initAlbum("/Users/jinambo/build-CD_Lib-Qt_6_4_0_for_macOS-Debug/CD_Lib.app/Contents/MacOS/booklets//gauc_storytelling.jpeg", "Gauč Storytelling", "Gleb", 2019, "Rap");

    album1->addTrack("Hold On");
    album1->addTrack("Mixed Emotions");
    album1->addTrack("Destiny");
    album1->addTrack("I Choose You");

    album2->addTrack("Monastery Gate");
    album2->addTrack("Lava Run");
    album2->addTrack("Shadow Strategy");
    album2->addTrack("Hangjaw");
    album2->addTrack("Horror Room");

    //uint64_t id1 = reinterpret_cast<uint64_t>(&album1);
    //uint64_t id2 = reinterpret_cast<uint64_t>(&album2);
    //album1->setId(id1);
    //album2->setId(id2);

    m_albums.push_back(album1);
    m_albums.push_back(album2);
    m_albums.push_back(album3);
    m_albums.push_back(album4);
}

const QVector<Album*> &Library::albums() const {
    return m_albums;
}

const QString &Library::filter() const {
    return m_filter;
}

void Library::setAlbums(const QVector<Album*> &newAlbums) {
    m_albums = newAlbums;
    emit albumsChanged(newAlbums);
}

void Library::setFilter(const QString &newFilter) {
    m_filter = newFilter;
    emit filterChanged(newFilter);
}

void Library::addAlbum(QString imgUrl, QString title, QString author, int date, QString genre, QVector<QString> tracks) {
    // Copy selected file to booklets folder
    QStringList strList = imgUrl.split("/");
    QString newFilePath = QString("%1/booklets/%2").arg(QDir::currentPath()).arg(strList[strList.length() - 1]);

    QFile::copy(imgUrl, newFilePath);

    // Create and init new album
    Album * newAlbum = new Album();

    newAlbum->initAlbum(newFilePath, title, author, date, genre);
    newAlbum->setTracks(tracks);

    uint64_t id = reinterpret_cast<uint64_t>(newAlbum);
    newAlbum->setId(id);

    m_albums.push_back(newAlbum);
    emit albumsChanged(m_albums);
}

void Library::editAlbum(int index, QString imgUrl, QString title, QString author, int date, QString genre, QVector<QString> tracks) {
    Album * albumToEdit = m_albums[index];

    // If there is new img path, craete a copy in booklets folder
    if (albumToEdit->imgUrl() != imgUrl) {
        // Copy selected file to booklets folder
        QStringList strList = imgUrl.split("/");
        QString newFilePath = QString("%1/booklets/%2").arg(QDir::currentPath()).arg(strList[strList.length() - 1]);

        QFile::copy(imgUrl, newFilePath);
    }

    albumToEdit->initAlbum(imgUrl, title, author, date, genre);
    albumToEdit->setTracks(tracks);
}

void Library::removeAlbum(int index) {
    qDebug() << "Obj to remove: " << m_albums[index]->title();

    // Destruct object
    delete m_albums[index];

    // Remove object from the vector
    m_albums.removeAt(index);

    emit albumsChanged(m_albums);
}
