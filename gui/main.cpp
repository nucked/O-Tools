#include "xiaomitool.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    XiaomiTool w;
    w.show();

    return a.exec();
}
