#include "album.h"
#include <QDebug>

// Constructor
Album::Album(QObject *parent)
    : QObject{parent}, m_imgUrl{""}, m_title{""}, m_author{""}, m_date{0}, m_genre{""} {

    qDebug() <<  "Album initialized";
}

// Methods
void Album::callMe() {
    qDebug() << "Function called.";
}

void Album::initAlbum(const QString &imgUrl, const QString &title, const QString &author, const int &date, const QString &genre) {
    setImgUrl(imgUrl);
    setTitle(title);
    setAuthor(author);
    setDate(date);
    setGenre(genre);
}

void Album::addTrack(QString track) {
    m_tracks.push_back(track);
    emit tracksChanged(m_tracks);
}

void Album::removeTrack(int index) {
    qDebug() << "Obj to remove: " << index;
    m_tracks.removeAt(index);
    emit tracksChanged(m_tracks);
}

// Properties' Getters
const uint64_t &Album::id() const {
    return m_id;
}

const QString &Album::imgUrl() const {
    return m_imgUrl;
}

const QString &Album::title() const {
    return m_title;
}

const QString &Album::author() const {
    return m_author;
}

const int &Album::date() const {
    return m_date;
}

const QString &Album::genre() const {
    return m_genre;
}

const QVector<QString> &Album::tracks() const {
    return m_tracks;
}

// Properties' Setters
void Album::setId(const uint64_t &newId) {
    if (m_id != newId) {
        m_id = newId;
        emit idChanged(newId);
    }
}

void Album::setImgUrl(const QString &newImgUrl) {
    if (m_imgUrl != newImgUrl) {
        m_imgUrl = newImgUrl;
        emit imgUrlChanged(newImgUrl);
    }
}

void Album::setTitle(const QString &newTitle) {
    if (m_title != newTitle) {
        m_title = newTitle;
        emit titleChanged(newTitle);
    }
}

void Album::setAuthor(const QString &newAuthor) {
    if (m_author != newAuthor) {
        m_author = newAuthor;
        emit authorChanged(newAuthor);
    }
}

void Album::setDate(const int &newDate) {
    if (m_date != newDate) {
        m_date = newDate;
        emit dateChanged(newDate);
    }
}

void Album::setGenre(const QString &newGenre) {
    if (m_genre != newGenre) {
        m_genre = newGenre;
        emit genreChanged(newGenre);
    }
}

void Album::setTracks(const QVector<QString> &newTracks) {
    if (m_tracks.length() == 0) {
        m_tracks = newTracks;
        emit tracksChanged(newTracks);
    }
}
