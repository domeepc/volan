#include "verticalbar.h"

VerticalBar::VerticalBar(QObject *parent)
    : QAbstractItemModel(parent)
{
}

QVariant VerticalBar::headerData(int section, Qt::Orientation orientation, int role) const
{
    // FIXME: Implement me!
}

QModelIndex VerticalBar::index(int row, int column, const QModelIndex &parent) const
{
    // FIXME: Implement me!
}

QModelIndex VerticalBar::parent(const QModelIndex &index) const
{
    // FIXME: Implement me!
}

int VerticalBar::rowCount(const QModelIndex &parent) const
{
    if (!parent.isValid())
        return 0;

    // FIXME: Implement me!
}

int VerticalBar::columnCount(const QModelIndex &parent) const
{
    if (!parent.isValid())
        return 0;

    // FIXME: Implement me!
}

QVariant VerticalBar::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    // FIXME: Implement me!
    return QVariant();
}
