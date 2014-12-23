#include "otools.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    OTools w;
    w.show();

    return a.exec();
}
