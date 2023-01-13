#ifndef ALBUM_H
#define ALBUM_H

#include <QObject>

class Album : public QObject {
    Q_OBJECT
    Q_PROPERTY(uint64_t id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(QString imgUrl READ imgUrl WRITE setImgUrl NOTIFY imgUrlChanged)
    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
    Q_PROPERTY(QString author READ author WRITE setAuthor NOTIFY authorChanged)
    Q_PROPERTY(int date READ date WRITE setDate NOTIFY dateChanged)
    Q_PROPERTY(QString genre READ genre WRITE setGenre NOTIFY genreChanged)
    Q_PROPERTY(QVector<QString> tracks READ tracks WRITE setTracks NOTIFY tracksChanged)

public:
    explicit Album(QObject *parent = nullptr);
    const uint64_t &id() const;
    const QString &imgUrl() const;
    const QString &title() const;
    const QString &author() const;
    const int &date() const;
    const QString &genre() const;
    const QVector<QString> &tracks() const;

signals:
    void idChanged(const uint64_t &id);
    void imgUrlChanged(const QString &imgUrl);
    void titleChanged(const QString &title);
    void authorChanged(const QString &author);
    void dateChanged(const int &date);
    void genreChanged(const QString &genre);
    void tracksChanged(const QVector<QString> &tracks);

public slots:
    void setId(const uint64_t &id);
    void setImgUrl(const QString &imgUrl);
    void setTitle(const QString &title);
    void setAuthor(const QString &author);
    void setDate(const int &date);
    void setGenre(const QString &genre);
    void setTracks(const QVector<QString> &tracks);
    void addTrack(QString track);
    void removeTrack(int index);
    void callMe();
    void initAlbum(const QString &imgUrl, const QString &title, const QString &author, const int &date, const QString &genre);

private:
    uint64_t m_id;
    QString m_imgUrl;
    QString m_title;
    QString m_author;
    int m_date;
    QString m_genre;
    QVector<QString> m_tracks;
};

#endif // ALBUM_H
